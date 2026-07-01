import 'package:freezed_annotation/freezed_annotation.dart';

import 'workout_block.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required DateTime date,
    @Default(<WorkoutBlock>[]) List<WorkoutBlock> blocks,
    @Default(3) int sessionRPE,
    @Default(0) int durationMinutes,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);
}
