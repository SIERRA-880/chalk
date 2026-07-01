// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutBlock _$WorkoutBlockFromJson(Map<String, dynamic> json) =>
    _WorkoutBlock(
      id: json['id'] as String,
      type: $enumDecode(_$BlockTypeEnumMap, json['type']),
      sets:
          (json['sets'] as List<dynamic>?)
              ?.map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExerciseSet>[],
    );

Map<String, dynamic> _$WorkoutBlockToJson(_WorkoutBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$BlockTypeEnumMap[instance.type]!,
      'sets': instance.sets,
    };

const _$BlockTypeEnumMap = {
  BlockType.warmup: 'warmup',
  BlockType.main: 'main',
  BlockType.finisher: 'finisher',
};
