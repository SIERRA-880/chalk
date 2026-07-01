import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set.freezed.dart';
part 'exercise_set.g.dart';

@freezed
abstract class ExerciseSet with _$ExerciseSet {
  const factory ExerciseSet({
    required String id,
    required String exerciseId,
    double? weight,
    int? reps,
    int? durationSeconds,
    @Default(false) bool isTrue1RM,
    @Default(false) bool completed,
    String? side, // 'G' | 'D' — null pour les exercices bilatéraux
  }) = _ExerciseSet;

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
}
