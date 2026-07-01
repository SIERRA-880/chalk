// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) =>
    _WorkoutSession(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      blocks:
          (json['blocks'] as List<dynamic>?)
              ?.map((e) => WorkoutBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WorkoutBlock>[],
      sessionRPE: (json['sessionRPE'] as num?)?.toInt() ?? 3,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WorkoutSessionToJson(_WorkoutSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'blocks': instance.blocks,
      'sessionRPE': instance.sessionRPE,
      'durationMinutes': instance.durationMinutes,
    };
