// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $_repositoryHash() => r'2d0970425bfa60ca8bd216a9118fb6c8502cc577';

/// See also [_repository].
final _repositoryProvider = Provider<PriceHistoryRepositoryInterface>(
  _repository,
  name: r'_repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $_repositoryHash,
);
typedef _RepositoryRef = ProviderRef<PriceHistoryRepositoryInterface>;
String $_intervalOptionHash() => r'1d96ed2fccef7118b031018144165de4749ec1b4';

/// See also [_intervalOption].
final _intervalOptionProvider = Provider<MarketPriceHistoryInterval>(
  _intervalOption,
  name: r'_intervalOptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_intervalOptionHash,
);
typedef _IntervalOptionRef = ProviderRef<MarketPriceHistoryInterval>;
String $_chartDataHash() => r'22f6d864c32bf2664200d77ddb153d2b8cc31b09';

/// See also [_chartData].
class _ChartDataProvider extends FutureProvider<List<PriceHistoryValue>> {
  _ChartDataProvider({
    required this.scaleOption,
  }) : super(
          (ref) => _chartData(
            ref,
            scaleOption: scaleOption,
          ),
          from: _chartDataProvider,
          name: r'_chartDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_chartDataHash,
        );

  final MarketPriceHistoryInterval scaleOption;

  @override
  bool operator ==(Object other) {
    return other is _ChartDataProvider && other.scaleOption == scaleOption;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scaleOption.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _ChartDataRef = FutureProviderRef<List<PriceHistoryValue>>;

/// See also [_chartData].
final _chartDataProvider = _ChartDataFamily();

class _ChartDataFamily extends Family<AsyncValue<List<PriceHistoryValue>>> {
  _ChartDataFamily();

  _ChartDataProvider call({
    required MarketPriceHistoryInterval scaleOption,
  }) {
    return _ChartDataProvider(
      scaleOption: scaleOption,
    );
  }

  @override
  FutureProvider<List<PriceHistoryValue>> getProviderOverride(
    covariant _ChartDataProvider provider,
  ) {
    return call(
      scaleOption: provider.scaleOption,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_chartDataProvider';
}
