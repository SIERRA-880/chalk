import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/db.dart';
import '../../../core/math/engines.dart';
import '../models/exercise.dart';
import '../models/exercise_set.dart';
import '../models/routine.dart';
import '../models/workout_session.dart';

part 'queries.g.dart';

@riverpod
Future<List<Exercise>> allExercises(Ref ref) => Db.instance.allExercises();

@riverpod
Future<List<Routine>> allRoutines(Ref ref) => Db.instance.allRoutines();

@riverpod
Future<List<WorkoutSession>> allSessionsHistory(Ref ref) =>
    Db.instance.allSessions();

@riverpod
Future<List<WorkoutSession>> sessionsLast28d(Ref ref) {
  final now = DateTime.now();
  return Db.instance.sessionsBetween(
    now.subtract(const Duration(days: 28)),
    now.add(const Duration(days: 1)),
  );
}

@riverpod
Future<List<ExerciseSet>> setsForExercise(Ref ref, String exerciseId) =>
    Db.instance.setsForExercise(exerciseId);

@riverpod
Future<double> suggestedWeight(
    Ref ref, String exerciseId, int targetReps) async {
  final sets = await ref.watch(setsForExerciseProvider(exerciseId).future);
  if (sets.isEmpty) return 0;
  final hist = historical1RM(sets);
  final last = sets.last;
  return suggestWeight(
    hist,
    targetReps,
    last.reps ?? 0,
    last.weight ?? 0,
  );
}
