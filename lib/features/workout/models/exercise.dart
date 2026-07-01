import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    String? description,
    String? targetMuscle,
    @Default(false) bool isUnilateral,
    @Default(TrackingType.weightAndReps) TrackingType trackingType,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
