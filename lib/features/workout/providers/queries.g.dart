// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queries.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allExercises)
const allExercisesProvider = AllExercisesProvider._();

final class AllExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Exercise>>,
          List<Exercise>,
          FutureOr<List<Exercise>>
        >
    with $FutureModifier<List<Exercise>>, $FutureProvider<List<Exercise>> {
  const AllExercisesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allExercisesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allExercisesHash();

  @$internal
  @override
  $FutureProviderElement<List<Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Exercise>> create(Ref ref) {
    return allExercises(ref);
  }
}

String _$allExercisesHash() => r'f354ccc0523206c6492096af9d567b5e1fbe318e';

@ProviderFor(allRoutines)
const allRoutinesProvider = AllRoutinesProvider._();

final class AllRoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          FutureOr<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $FutureProvider<List<Routine>> {
  const AllRoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allRoutinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allRoutinesHash();

  @$internal
  @override
  $FutureProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Routine>> create(Ref ref) {
    return allRoutines(ref);
  }
}

String _$allRoutinesHash() => r'e43b55b8c80ebfeec2b5639c5fd12dc12a2bccde';

@ProviderFor(allSessionsHistory)
const allSessionsHistoryProvider = AllSessionsHistoryProvider._();

final class AllSessionsHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutSession>>,
          List<WorkoutSession>,
          FutureOr<List<WorkoutSession>>
        >
    with
        $FutureModifier<List<WorkoutSession>>,
        $FutureProvider<List<WorkoutSession>> {
  const AllSessionsHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSessionsHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSessionsHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<WorkoutSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutSession>> create(Ref ref) {
    return allSessionsHistory(ref);
  }
}

String _$allSessionsHistoryHash() =>
    r'722c8e98bff59bbc2431028b646eb8c1d879d0fa';

@ProviderFor(sessionsLast28d)
const sessionsLast28dProvider = SessionsLast28dProvider._();

final class SessionsLast28dProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutSession>>,
          List<WorkoutSession>,
          FutureOr<List<WorkoutSession>>
        >
    with
        $FutureModifier<List<WorkoutSession>>,
        $FutureProvider<List<WorkoutSession>> {
  const SessionsLast28dProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionsLast28dProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionsLast28dHash();

  @$internal
  @override
  $FutureProviderElement<List<WorkoutSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutSession>> create(Ref ref) {
    return sessionsLast28d(ref);
  }
}

String _$sessionsLast28dHash() => r'4a4fdc3bf5ba77ab2ad697fa5b840d9a37c37e49';

@ProviderFor(setsForExercise)
const setsForExerciseProvider = SetsForExerciseFamily._();

final class SetsForExerciseProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExerciseSet>>,
          List<ExerciseSet>,
          FutureOr<List<ExerciseSet>>
        >
    with
        $FutureModifier<List<ExerciseSet>>,
        $FutureProvider<List<ExerciseSet>> {
  const SetsForExerciseProvider._({
    required SetsForExerciseFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'setsForExerciseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$setsForExerciseHash();

  @override
  String toString() {
    return r'setsForExerciseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExerciseSet>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExerciseSet>> create(Ref ref) {
    final argument = this.argument as String;
    return setsForExercise(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SetsForExerciseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$setsForExerciseHash() => r'ca616f7a782771660e6582e9586b643b338093c0';

final class SetsForExerciseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ExerciseSet>>, String> {
  const SetsForExerciseFamily._()
    : super(
        retry: null,
        name: r'setsForExerciseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SetsForExerciseProvider call(String exerciseId) =>
      SetsForExerciseProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'setsForExerciseProvider';
}

@ProviderFor(suggestedWeight)
const suggestedWeightProvider = SuggestedWeightFamily._();

final class SuggestedWeightProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  const SuggestedWeightProvider._({
    required SuggestedWeightFamily super.from,
    required (String, int) super.argument,
  }) : super(
         retry: null,
         name: r'suggestedWeightProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$suggestedWeightHash();

  @override
  String toString() {
    return r'suggestedWeightProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    final argument = this.argument as (String, int);
    return suggestedWeight(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SuggestedWeightProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$suggestedWeightHash() => r'7ba053c09a025d624b90d2f1dc11846871e5e566';

final class SuggestedWeightFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<double>, (String, int)> {
  const SuggestedWeightFamily._()
    : super(
        retry: null,
        name: r'suggestedWeightProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SuggestedWeightProvider call(String exerciseId, int targetReps) =>
      SuggestedWeightProvider._(argument: (exerciseId, targetReps), from: this);

  @override
  String toString() => r'suggestedWeightProvider';
}
