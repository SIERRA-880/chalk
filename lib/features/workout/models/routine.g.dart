// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoutineExerciseRef _$RoutineExerciseRefFromJson(Map<String, dynamic> json) =>
    _RoutineExerciseRef(
      exerciseId: json['exerciseId'] as String,
      targetSets: (json['targetSets'] as num?)?.toInt() ?? 3,
      targetReps: (json['targetReps'] as num?)?.toInt() ?? 8,
    );

Map<String, dynamic> _$RoutineExerciseRefToJson(_RoutineExerciseRef instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'targetSets': instance.targetSets,
      'targetReps': instance.targetReps,
    };

_RoutineBlock _$RoutineBlockFromJson(Map<String, dynamic> json) =>
    _RoutineBlock(
      type: $enumDecode(_$BlockTypeEnumMap, json['type']),
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map(
                (e) => RoutineExerciseRef.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <RoutineExerciseRef>[],
    );

Map<String, dynamic> _$RoutineBlockToJson(_RoutineBlock instance) =>
    <String, dynamic>{
      'type': _$BlockTypeEnumMap[instance.type]!,
      'exercises': instance.exercises,
    };

const _$BlockTypeEnumMap = {
  BlockType.warmup: 'warmup',
  BlockType.main: 'main',
  BlockType.finisher: 'finisher',
};

_Routine _$RoutineFromJson(Map<String, dynamic> json) => _Routine(
  id: json['id'] as String,
  name: json['name'] as String,
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => RoutineBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RoutineBlock>[],
);

Map<String, dynamic> _$RoutineToJson(_Routine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'blocks': instance.blocks,
};
