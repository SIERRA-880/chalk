// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => _ExerciseSet(
  id: json['id'] as String,
  exerciseId: json['exerciseId'] as String,
  weight: (json['weight'] as num?)?.toDouble(),
  reps: (json['reps'] as num?)?.toInt(),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  isTrue1RM: json['isTrue1RM'] as bool? ?? false,
  completed: json['completed'] as bool? ?? false,
  side: json['side'] as String?,
);

Map<String, dynamic> _$ExerciseSetToJson(_ExerciseSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseId': instance.exerciseId,
      'weight': instance.weight,
      'reps': instance.reps,
      'durationSeconds': instance.durationSeconds,
      'isTrue1RM': instance.isTrue1RM,
      'completed': instance.completed,
      'side': instance.side,
    };
