import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'routine.freezed.dart';
part 'routine.g.dart';

@freezed
abstract class RoutineExerciseRef with _$RoutineExerciseRef {
  const factory RoutineExerciseRef({
    required String exerciseId,
    @Default(3) int targetSets,
    @Default(8) int targetReps,
  }) = _RoutineExerciseRef;

  factory RoutineExerciseRef.fromJson(Map<String, dynamic> json) =>
      _$RoutineExerciseRefFromJson(json);
}

@freezed
abstract class RoutineBlock with _$RoutineBlock {
  const factory RoutineBlock({
    required BlockType type,
    @Default(<RoutineExerciseRef>[]) List<RoutineExerciseRef> exercises,
  }) = _RoutineBlock;

  factory RoutineBlock.fromJson(Map<String, dynamic> json) =>
      _$RoutineBlockFromJson(json);
}

@freezed
abstract class Routine with _$Routine {
  const factory Routine({
    required String id,
    required String name,
    @Default(<RoutineBlock>[]) List<RoutineBlock> blocks,
  }) = _Routine;

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);
}
