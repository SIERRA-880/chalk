import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';
import '../models/exercise.dart';
import '../models/exercise_set.dart';
import '../models/workout_session.dart';
import '../providers/queries.dart';

class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.session});
  final WorkoutSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exosAsync = ref.watch(allExercisesProvider);
    final totalSets =
        session.blocks.fold<int>(0, (a, b) => b.sets.length + a);

    return Scaffold(
      appBar: AppBar(title: Text(_formatDate(session.date))),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Résumé de la séance
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Stat(label: 'Durée', value: '${session.durationMinutes} min'),
                  _Stat(label: 'Séries', value: '$totalSets'),
                  _Stat(label: 'RPE', value: '${session.sessionRPE}/5'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Blocs
          for (final block in session.blocks)
            if (block.sets.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _blockLabel(block.type),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              ..._groupByExercise(block.sets)
                  .entries
                  .map((entry) => _ExerciseCard(
                        exerciseId: entry.key,
                        sets: entry.value,
                        exosAsync: exosAsync,
                      )),
            ],
        ],
      ),
    );
  }

  Map<String, List<ExerciseSet>> _groupByExercise(List<ExerciseSet> sets) {
    final map = <String, List<ExerciseSet>>{};
    for (final s in sets) {
      map.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    return map;
  }

  String _formatDate(DateTime d) {
    const jours = [
      'Lundi', 'Mardi', 'Mercredi', 'Jeudi',
      'Vendredi', 'Samedi', 'Dimanche'
    ];
    const mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${jours[d.weekday - 1]} ${d.day} ${mois[d.month - 1]} ${d.year}';
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.exerciseId,
    required this.sets,
    required this.exosAsync,
  });
  final String exerciseId;
  final List<ExerciseSet> sets;
  final AsyncValue<List<Exercise>> exosAsync;

  @override
  Widget build(BuildContext context) {
    final exo = exosAsync.maybeWhen(
      data: (xs) => xs.firstWhere((e) => e.id == exerciseId,
          orElse: () => const Exercise(id: '', name: '?')),
      orElse: () => const Exercise(id: '', name: '…'),
    );
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exo.name,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            for (var i = 0; i < sets.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '${i + 1}.  ${_setLabel(sets[i], exo.trackingType)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _setLabel(ExerciseSet s, TrackingType type) {
    if (type == TrackingType.timeBased) {
      return s.durationSeconds != null ? '${s.durationSeconds} s' : '—';
    }
    if (type == TrackingType.calories) {
      return s.reps != null ? '${s.reps} kcal' : '—';
    }
    final w = s.weight != null ? '${s.weight} kg' : null;
    final r = s.reps != null ? '${s.reps} reps' : null;
    return [w, r].whereType<String>().join(' × ');
  }
}

String _blockLabel(BlockType t) => switch (t) {
      BlockType.warmup => 'ÉCHAUFFEMENT',
      BlockType.main => 'CORPS DE SÉANCE',
      BlockType.finisher => 'FINISHER CARDIO',
    };
