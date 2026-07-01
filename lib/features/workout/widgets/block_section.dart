import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums.dart';
import '../models/exercise.dart';
import '../models/exercise_set.dart';
import '../models/routine.dart';
import '../models/workout_block.dart';
import '../providers/exercise_active_timer.dart';
import '../providers/queries.dart';
import 'set_row.dart';

class BlockSection extends ConsumerWidget {
  const BlockSection({
    super.key,
    required this.routine,
    required this.block,
  });

  final Routine routine;
  final WorkoutBlock block;

  static const _labels = {
    BlockType.warmup: 'ÉCHAUFFEMENT',
    BlockType.main: 'CORPS DE SÉANCE',
    BlockType.finisher: 'FINISHER CARDIO',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exosAsync = ref.watch(allExercisesProvider);
    // Groupe les sets par exerciseId en conservant l'ordre d'apparition.
    final groups = <String, List<ExerciseSet>>{};
    for (final s in block.sets) {
      groups.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(_labels[block.type]!,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            if (groups.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Aucun exercice planifié.'),
              )
            else
              for (final entry in groups.entries)
                _ExerciseGroup(
                  routine: routine,
                  exerciseId: entry.key,
                  sets: entry.value,
                  exoName: _exerciseName(exosAsync, entry.key),
                  trackingType: _exerciseType(exosAsync, entry.key),
                  isUnilateral: _exerciseIsUnilateral(exosAsync, entry.key),
                ),
          ],
        ),
      ),
    );
  }

  String _exerciseName(AsyncValue<List<Exercise>> async, String id) =>
      async.maybeWhen(
        data: (xs) => xs.firstWhere(
          (e) => e.id == id,
          orElse: () => const Exercise(id: '', name: '?'),
        ).name,
        orElse: () => '…',
      );

  TrackingType _exerciseType(AsyncValue<List<Exercise>> async, String id) =>
      async.maybeWhen(
        data: (xs) => xs.firstWhere(
          (e) => e.id == id,
          orElse: () => const Exercise(id: '', name: '?'),
        ).trackingType,
        orElse: () => TrackingType.weightAndReps,
      );

  bool _exerciseIsUnilateral(AsyncValue<List<Exercise>> async, String id) =>
      async.maybeWhen(
        data: (xs) => xs.firstWhere(
          (e) => e.id == id,
          orElse: () => const Exercise(id: '', name: '?'),
        ).isUnilateral,
        orElse: () => false,
      );
}

class _ExerciseGroup extends ConsumerWidget {
  const _ExerciseGroup({
    required this.routine,
    required this.exerciseId,
    required this.sets,
    required this.exoName,
    required this.trackingType,
    required this.isUnilateral,
  });

  final Routine routine;
  final String exerciseId;
  final List<ExerciseSet> sets;
  final String exoName;
  final TrackingType trackingType;
  final bool isUnilateral;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(exerciseActiveTimerProvider(exerciseId));
    final allDone = sets.every((s) => s.completed);
    // Stop automatique du timer quand tous les sets sont validés.
    if (allDone && timer.inMilliseconds > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(exerciseActiveTimerProvider(exerciseId).notifier)
            .stop();
      });
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Expanded(
                    child: Text(exoName,
                        style:
                            Theme.of(context).textTheme.titleSmall)),
                Text(_fmt(timer)),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(allDone ? Icons.check_circle : Icons.play_arrow),
                  onPressed: allDone
                      ? null
                      : () => ref
                          .read(exerciseActiveTimerProvider(exerciseId)
                              .notifier)
                          .start(),
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () => ref
                      .read(exerciseActiveTimerProvider(exerciseId).notifier)
                      .stop(),
                ),
              ],
            ),
          ),
          for (var i = 0; i < sets.length; i++)
            SetRow(
                routine: routine,
                set: sets[i],
                index: i,
                totalSets: sets.length,
                trackingType: trackingType,
                isUnilateral: isUnilateral),
        ],
      ),
    );
  }

  static String _fmt(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
