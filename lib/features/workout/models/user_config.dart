import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_config.freezed.dart';
part 'user_config.g.dart';

@freezed
abstract class UserConfig with _$UserConfig {
  const factory UserConfig({
    required String id,
    @Default('') String globalObjectives,
    double? bodyWeightKg,
    int? age,
  }) = _UserConfig;

  factory UserConfig.fromJson(Map<String, dynamic> json) =>
      _$UserConfigFromJson(json);
}
