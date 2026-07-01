// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(acwrHistory)
const acwrHistoryProvider = AcwrHistoryProvider._();

final class AcwrHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AcwrPoint>>,
          List<AcwrPoint>,
          FutureOr<List<AcwrPoint>>
        >
    with $FutureModifier<List<AcwrPoint>>, $FutureProvider<List<AcwrPoint>> {
  const AcwrHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'acwrHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$acwrHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<AcwrPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AcwrPoint>> create(Ref ref) {
    return acwrHistory(ref);
  }
}

String _$acwrHistoryHash() => r'7371c978b0f5f1a7de94eba4106f4179939ff0a2';

@ProviderFor(oneRmHistory)
const oneRmHistoryProvider = OneRmHistoryFamily._();

final class OneRmHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OneRmPoint>>,
          List<OneRmPoint>,
          FutureOr<List<OneRmPoint>>
        >
    with $FutureModifier<List<OneRmPoint>>, $FutureProvider<List<OneRmPoint>> {
  const OneRmHistoryProvider._({
    required OneRmHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'oneRmHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$oneRmHistoryHash();

  @override
  String toString() {
    return r'oneRmHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OneRmPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OneRmPoint>> create(Ref ref) {
    final argument = this.argument as String;
    return oneRmHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OneRmHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$oneRmHistoryHash() => r'c0814afde7f14c189397de11cdce2595bbd54067';

final class OneRmHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OneRmPoint>>, String> {
  const OneRmHistoryFamily._()
    : super(
        retry: null,
        name: r'oneRmHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OneRmHistoryProvider call(String exerciseId) =>
      OneRmHistoryProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'oneRmHistoryProvider';
}

@ProviderFor(aiAdvice)
const aiAdviceProvider = AiAdviceProvider._();

final class AiAdviceProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  const AiAdviceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiAdviceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiAdviceHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return aiAdvice(ref);
  }
}

String _$aiAdviceHash() => r'1fe2fb7f3e09c4bea37530fc2628026afe7f9674';
