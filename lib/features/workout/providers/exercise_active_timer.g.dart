// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_active_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseActiveTimer)
const exerciseActiveTimerProvider = ExerciseActiveTimerFamily._();

final class ExerciseActiveTimerProvider
    extends $NotifierProvider<ExerciseActiveTimer, Duration> {
  const ExerciseActiveTimerProvider._({
    required ExerciseActiveTimerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'exerciseActiveTimerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseActiveTimerHash();

  @override
  String toString() {
    return r'exerciseActiveTimerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExerciseActiveTimer create() => ExerciseActiveTimer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseActiveTimerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseActiveTimerHash() =>
    r'3e11730237b2464dd59e62f725209813521e3bb9';

final class ExerciseActiveTimerFamily extends $Family
    with
        $ClassFamilyOverride<
          ExerciseActiveTimer,
          Duration,
          Duration,
          Duration,
          String
        > {
  const ExerciseActiveTimerFamily._()
    : super(
        retry: null,
        name: r'exerciseActiveTimerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseActiveTimerProvider call(String exerciseId) =>
      ExerciseActiveTimerProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'exerciseActiveTimerProvider';
}

abstract class _$ExerciseActiveTimer extends $Notifier<Duration> {
  late final _$args = ref.$arg as String;
  String get exerciseId => _$args;

  Duration build(String exerciseId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Duration, Duration>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Duration, Duration>,
              Duration,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
