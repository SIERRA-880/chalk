import 'dart:math' as math;

import '../../features/workout/models/exercise_set.dart';
import '../../features/workout/models/workout_session.dart';

/// Estimateur 1RM Epley : weight * (1 + reps / 30).
double epley1RM(double weight, int reps) => weight * (1 + reps / 30);

/// Max historique 1RM d'un exercice à partir de l'ensemble de ses sets passés.
/// Retourne 0.0 s'il n'y a aucun set exploitable.
double historical1RM(Iterable<ExerciseSet> sets) => sets
    .where((s) => s.weight != null && s.reps != null && s.reps! > 0)
    .map((s) => epley1RM(s.weight!, s.reps!))
    .fold<double>(0.0, math.max);

/// ACWR (Acute:Chronic Workload Ratio).
/// - charge(session) = sessionRPE * durationMinutes
/// - acute   = somme charge sur 7 derniers jours
/// - chronic = somme charge sur 28 derniers jours / 4   (moyenne hebdo sur 4 semaines)
/// Retourne 0 si chronic == 0.
double acwr(List<WorkoutSession> sessions, DateTime now) {
  double load(WorkoutSession s) =>
      (s.sessionRPE * s.durationMinutes).toDouble();

  final acute = sessions
      .where((s) {
        final d = now.difference(s.date).inDays;
        return d >= 0 && d < 7;
      })
      .fold<double>(0, (a, s) => a + load(s));

  final chronicSum = sessions
      .where((s) {
        final d = now.difference(s.date).inDays;
        return d >= 0 && d < 28;
      })
      .fold<double>(0, (a, s) => a + load(s));
  final chronic = chronicSum / 4.0;

  return chronic == 0 ? 0 : acute / chronic;
}

/// Facteur pyramide montante : 60 % sur la première série → 100 % sur la dernière.
double pyramidFactor(int setIndex, int totalSets) {
  if (totalSets <= 1) return 1.0;
  return 0.6 + 0.4 * (setIndex / (totalSets - 1));
}

/// Suggestion de poids pour la prochaine série (spec utilisateur stricte).
/// - Si pas d'historique 1RM → 0.0
/// - base = historical1RM / (1 + targetReps / 30)
/// - target = base + 2.5 si previousAchievedReps >= targetReps, sinon base
/// - arrondi STRICT : (target / 2.5).floorToDouble() * 2.5
double suggestWeight(
  double historical1RM,
  int targetReps,
  int previousAchievedReps,
  double previousWeight,
) {
  if (historical1RM == 0) return 0.0;
  final base = historical1RM / (1 + targetReps / 30);
  final target = previousAchievedReps >= targetReps ? base + 2.5 : base;
  return (target / 2.5).floorToDouble() * 2.5;
}

// ponytail: self-check exécutable via `dart run lib/core/math/engines.dart`,
// remplace un harnais de tests pour cette phase. Tests structurés à ajouter
// quand un 2e moteur math arrive ou qu'un contributeur s'ajoute.
void main() {
  // epley1RM
  assert(epley1RM(100, 10) == 100 * (1 + 10 / 30));
  assert(epley1RM(100, 1).round() == 103); // 100 * (1 + 1/30) ≈ 103.33
  assert(epley1RM(0, 5) == 0);

  // historical1RM
  assert(historical1RM(const <ExerciseSet>[]) == 0.0);
  final sets = [
    ExerciseSet(id: 'a', exerciseId: 'e1', weight: 80, reps: 5),
    ExerciseSet(id: 'b', exerciseId: 'e1', weight: 100, reps: 1),
    ExerciseSet(id: 'c', exerciseId: 'e1'), // null fields → ignoré
  ];
  // Epley(80,5)=93.33  Epley(100,1)=103.33 → max ≈ 103.33
  assert((historical1RM(sets) - 103.3333).abs() < 0.001);

  // suggestWeight
  assert(suggestWeight(0, 8, 8, 60) == 0.0);
  // base = 100 / (1 + 8/30) = 78.94…  ; achieved < target → target = base = 78.94…
  // (78.94/2.5).floor() * 2.5 = 31 * 2.5 = 77.5
  assert(suggestWeight(100, 8, 7, 60) == 77.5);
  // achieved >= target → +2.5 → 81.44 → floor(32.57)*2.5 = 80.0
  assert(suggestWeight(100, 8, 8, 60) == 80.0);

  // acwr
  final now = DateTime(2026, 6, 30);
  final hist = [
    // 4 sessions sur 28 jours, charge identique 5*60=300 chacune
    WorkoutSession(
        id: '1',
        date: now.subtract(const Duration(days: 1)),
        sessionRPE: 5,
        durationMinutes: 60),
    WorkoutSession(
        id: '2',
        date: now.subtract(const Duration(days: 8)),
        sessionRPE: 5,
        durationMinutes: 60),
    WorkoutSession(
        id: '3',
        date: now.subtract(const Duration(days: 15)),
        sessionRPE: 5,
        durationMinutes: 60),
    WorkoutSession(
        id: '4',
        date: now.subtract(const Duration(days: 22)),
        sessionRPE: 5,
        durationMinutes: 60),
  ];
  // acute = 300 (1 session dans 7j) ; chronic = (4*300)/4 = 300 → ratio = 1.0
  assert(acwr(hist, now) == 1.0);

  // sessions vides
  assert(acwr(const <WorkoutSession>[], now) == 0);

  // ignore: avoid_print
  print('engines.dart self-check OK');
}
