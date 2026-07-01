import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/db.dart';
import '../models/enums.dart';
import '../models/exercise.dart';
import '../models/exercise_set.dart';
import '../models/routine.dart';
import '../models/workout_block.dart';
import '../models/workout_session.dart';
import 'queries.dart';

part 'workout_builder.g.dart';

const _uuid = Uuid();

@riverpod
class WorkoutBuilder extends _$WorkoutBuilder {
  @override
  WorkoutSession build(Routine routine) {
    final exoById = {
      for (final e in ref.read(allExercisesProvider).asData?.value ?? <Exercise>[])
        e.id: e,
    };
    final blocks = <WorkoutBlock>[];
    for (final rb in routine.blocks) {
      final sets = <ExerciseSet>[];
      for (final exoRef in rb.exercises) {
        final isUnilateral = exoById[exoRef.exerciseId]?.isUnilateral ?? false;
        for (var i = 0; i < exoRef.targetSets; i++) {
          if (isUnilateral) {
            sets.add(ExerciseSet(
                id: _uuid.v4(),
                exerciseId: exoRef.exerciseId,
                reps: exoRef.targetReps,
                side: 'G'));
            sets.add(ExerciseSet(
                id: _uuid.v4(),
                exerciseId: exoRef.exerciseId,
                reps: exoRef.targetReps,
                side: 'D'));
          } else {
            sets.add(ExerciseSet(
                id: _uuid.v4(),
                exerciseId: exoRef.exerciseId,
                reps: exoRef.targetReps));
          }
        }
      }
      blocks.add(WorkoutBlock(id: _uuid.v4(), type: rb.type, sets: sets));
    }
    return WorkoutSession(
      id: _uuid.v4(),
      date: DateTime.now(),
      blocks: blocks,
      sessionRPE: 3,
      durationMinutes: 0,
    );
  }

  void addSet(BlockType type, ExerciseSet s) {
    state = state.copyWith(
      blocks: [
        for (final b in state.blocks)
          if (b.type == type) b.copyWith(sets: [...b.sets, s]) else b,
      ],
    );
  }

  void updateSet(String setId,
      {double? weight, int? reps, int? durationSeconds, bool? completed}) {
    state = state.copyWith(
      blocks: [
        for (final b in state.blocks)
          b.copyWith(sets: [
            for (final s in b.sets)
              if (s.id == setId)
                s.copyWith(
                  weight: weight ?? s.weight,
                  reps: reps ?? s.reps,
                  durationSeconds: durationSeconds ?? s.durationSeconds,
                  completed: completed ?? s.completed,
                )
              else
                s,
          ]),
      ],
    );
  }

  void setRPE(int v) {
    assert(v >= 1 && v <= 5);
    state = state.copyWith(sessionRPE: v);
  }

  void setDuration(int minutes) {
    assert(minutes >= 0);
    state = state.copyWith(durationMinutes: minutes);
  }

  /// Sauvegarde la session en filtrant les sets non validés.
  /// Calcule la durée à partir de `state.date` (initialisé au build).
  Future<void> finalize(int sessionRPE) async {
    final duration = DateTime.now().difference(state.date).inMinutes;
    final cleaned = state.copyWith(
      sessionRPE: sessionRPE,
      durationMinutes: duration < 0 ? 0 : duration,
      blocks: [
        for (final b in state.blocks)
          b.copyWith(sets: b.sets.where((s) => s.completed).toList()),
      ],
    );
    await Db.instance.insertSession(cleaned);
  }
}
