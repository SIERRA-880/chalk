// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserConfig _$UserConfigFromJson(Map<String, dynamic> json) => _UserConfig(
  id: json['id'] as String,
  globalObjectives: json['globalObjectives'] as String? ?? '',
  bodyWeightKg: (json['bodyWeightKg'] as num?)?.toDouble(),
  age: (json['age'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserConfigToJson(_UserConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'globalObjectives': instance.globalObjectives,
      'bodyWeightKg': instance.bodyWeightKg,
      'age': instance.age,
    };
