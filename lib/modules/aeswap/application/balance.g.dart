// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userBalanceHash() => r'4cc6390453ca575b7019dbfa84665773c8100459';

/// See also [userBalance].
@ProviderFor(userBalance)
final userBalanceProvider =
    AutoDisposeFutureProvider<archethic.Balance>.internal(
  userBalance,
  name: r'userBalanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserBalanceRef = AutoDisposeFutureProviderRef<archethic.Balance>;
String _$getBalanceHash() => r'434260970828b87135c5630cca11ea79edadc8aa';

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

/// See also [getBalance].
@ProviderFor(getBalance)
const getBalanceProvider = GetBalanceFamily();

/// See also [getBalance].
class GetBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [getBalance].
  const GetBalanceFamily();

  /// See also [getBalance].
  GetBalanceProvider call(
    String tokenAddress,
  ) {
    return GetBalanceProvider(
      tokenAddress,
    );
  }

  @override
  GetBalanceProvider getProviderOverride(
    covariant GetBalanceProvider provider,
  ) {
    return call(
      provider.tokenAddress,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getBalanceProvider';
}

/// See also [getBalance].
class GetBalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [getBalance].
  GetBalanceProvider(
    String tokenAddress,
  ) : this._internal(
          (ref) => getBalance(
            ref as GetBalanceRef,
            tokenAddress,
          ),
          from: getBalanceProvider,
          name: r'getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              GetBalanceFamily._allTransitiveDependencies,
          tokenAddress: tokenAddress,
        );

  GetBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenAddress,
  }) : super.internal();

  final String tokenAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBalanceProvider._internal(
        (ref) => create(ref as GetBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokenAddress: tokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBalanceProvider && other.tokenAddress == tokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<double> with GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  String get tokenAddress => (origin as GetBalanceProvider).tokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
