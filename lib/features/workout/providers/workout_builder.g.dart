// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutBuilder)
const workoutBuilderProvider = WorkoutBuilderFamily._();

final class WorkoutBuilderProvider
    extends $NotifierProvider<WorkoutBuilder, WorkoutSession> {
  const WorkoutBuilderProvider._({
    required WorkoutBuilderFamily super.from,
    required Routine super.argument,
  }) : super(
         retry: null,
         name: r'workoutBuilderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutBuilderHash();

  @override
  String toString() {
    return r'workoutBuilderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WorkoutBuilder create() => WorkoutBuilder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutSession>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutBuilderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutBuilderHash() => r'3b5e3d90fc4fe325f4ccadaa7475b89487735876';

final class WorkoutBuilderFamily extends $Family
    with
        $ClassFamilyOverride<
          WorkoutBuilder,
          WorkoutSession,
          WorkoutSession,
          WorkoutSession,
          Routine
        > {
  const WorkoutBuilderFamily._()
    : super(
        retry: null,
        name: r'workoutBuilderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WorkoutBuilderProvider call(Routine routine) =>
      WorkoutBuilderProvider._(argument: routine, from: this);

  @override
  String toString() => r'workoutBuilderProvider';
}

abstract class _$WorkoutBuilder extends $Notifier<WorkoutSession> {
  late final _$args = ref.$arg as Routine;
  Routine get routine => _$args;

  WorkoutSession build(Routine routine);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<WorkoutSession, WorkoutSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkoutSession, WorkoutSession>,
              WorkoutSession,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
