import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'exercise_set.dart';

part 'workout_block.freezed.dart';
part 'workout_block.g.dart';

@freezed
abstract class WorkoutBlock with _$WorkoutBlock {
  const factory WorkoutBlock({
    required String id,
    required BlockType type,
    @Default(<ExerciseSet>[]) List<ExerciseSet> sets,
  }) = _WorkoutBlock;

  factory WorkoutBlock.fromJson(Map<String, dynamic> json) =>
      _$WorkoutBlockFromJson(json);
}
