// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  targetMuscle: json['targetMuscle'] as String?,
  isUnilateral: json['isUnilateral'] as bool? ?? false,
  trackingType:
      $enumDecodeNullable(_$TrackingTypeEnumMap, json['trackingType']) ??
      TrackingType.weightAndReps,
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'targetMuscle': instance.targetMuscle,
  'isUnilateral': instance.isUnilateral,
  'trackingType': _$TrackingTypeEnumMap[instance.trackingType]!,
};

const _$TrackingTypeEnumMap = {
  TrackingType.weightAndReps: 'weightAndReps',
  TrackingType.bodyweight: 'bodyweight',
  TrackingType.timeBased: 'timeBased',
};
