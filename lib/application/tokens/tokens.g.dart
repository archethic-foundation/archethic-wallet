// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokensListHash() => r'930807d379873e4cbbfeee9a7a35e0407346a0e2';

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

/// See also [tokensList].
@ProviderFor(tokensList)
const tokensListProvider = TokensListFamily();

/// See also [tokensList].
class TokensListFamily extends Family<AsyncValue<List<AEToken>>> {
  /// See also [tokensList].
  const TokensListFamily();

  /// See also [tokensList].
  TokensListProvider call(
    String userGenesisAddress, {
    bool withVerified = true,
    bool withLPToken = true,
    bool withNotVerified = true,
  }) {
    return TokensListProvider(
      userGenesisAddress,
      withVerified: withVerified,
      withLPToken: withLPToken,
      withNotVerified: withNotVerified,
    );
  }

  @override
  TokensListProvider getProviderOverride(
    covariant TokensListProvider provider,
  ) {
    return call(
      provider.userGenesisAddress,
      withVerified: provider.withVerified,
      withLPToken: provider.withLPToken,
      withNotVerified: provider.withNotVerified,
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
  String? get name => r'tokensListProvider';
}

/// See also [tokensList].
class TokensListProvider extends AutoDisposeFutureProvider<List<AEToken>> {
  /// See also [tokensList].
  TokensListProvider(
    String userGenesisAddress, {
    bool withVerified = true,
    bool withLPToken = true,
    bool withNotVerified = true,
  }) : this._internal(
          (ref) => tokensList(
            ref as TokensListRef,
            userGenesisAddress,
            withVerified: withVerified,
            withLPToken: withLPToken,
            withNotVerified: withNotVerified,
          ),
          from: tokensListProvider,
          name: r'tokensListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tokensListHash,
          dependencies: TokensListFamily._dependencies,
          allTransitiveDependencies:
              TokensListFamily._allTransitiveDependencies,
          userGenesisAddress: userGenesisAddress,
          withVerified: withVerified,
          withLPToken: withLPToken,
          withNotVerified: withNotVerified,
        );

  TokensListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userGenesisAddress,
    required this.withVerified,
    required this.withLPToken,
    required this.withNotVerified,
  }) : super.internal();

  final String userGenesisAddress;
  final bool withVerified;
  final bool withLPToken;
  final bool withNotVerified;

  @override
  Override overrideWith(
    FutureOr<List<AEToken>> Function(TokensListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TokensListProvider._internal(
        (ref) => create(ref as TokensListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userGenesisAddress: userGenesisAddress,
        withVerified: withVerified,
        withLPToken: withLPToken,
        withNotVerified: withNotVerified,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AEToken>> createElement() {
    return _TokensListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TokensListProvider &&
        other.userGenesisAddress == userGenesisAddress &&
        other.withVerified == withVerified &&
        other.withLPToken == withLPToken &&
        other.withNotVerified == withNotVerified;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, withVerified.hashCode);
    hash = _SystemHash.combine(hash, withLPToken.hashCode);
    hash = _SystemHash.combine(hash, withNotVerified.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TokensListRef on AutoDisposeFutureProviderRef<List<AEToken>> {
  /// The parameter `userGenesisAddress` of this provider.
  String get userGenesisAddress;

  /// The parameter `withVerified` of this provider.
  bool get withVerified;

  /// The parameter `withLPToken` of this provider.
  bool get withLPToken;

  /// The parameter `withNotVerified` of this provider.
  bool get withNotVerified;
}

class _TokensListProviderElement
    extends AutoDisposeFutureProviderElement<List<AEToken>> with TokensListRef {
  _TokensListProviderElement(super.provider);

  @override
  String get userGenesisAddress =>
      (origin as TokensListProvider).userGenesisAddress;
  @override
  bool get withVerified => (origin as TokensListProvider).withVerified;
  @override
  bool get withLPToken => (origin as TokensListProvider).withLPToken;
  @override
  bool get withNotVerified => (origin as TokensListProvider).withNotVerified;
}

String _$tokensTotalUSDHash() => r'c78720b9a06587a595203d502be85df72d319435';

/// See also [tokensTotalUSD].
@ProviderFor(tokensTotalUSD)
const tokensTotalUSDProvider = TokensTotalUSDFamily();

/// See also [tokensTotalUSD].
class TokensTotalUSDFamily extends Family<AsyncValue<double>> {
  /// See also [tokensTotalUSD].
  const TokensTotalUSDFamily();

  /// See also [tokensTotalUSD].
  TokensTotalUSDProvider call(
    String userGenesisAddress,
  ) {
    return TokensTotalUSDProvider(
      userGenesisAddress,
    );
  }

  @override
  TokensTotalUSDProvider getProviderOverride(
    covariant TokensTotalUSDProvider provider,
  ) {
    return call(
      provider.userGenesisAddress,
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
  String? get name => r'tokensTotalUSDProvider';
}

/// See also [tokensTotalUSD].
class TokensTotalUSDProvider extends AutoDisposeFutureProvider<double> {
  /// See also [tokensTotalUSD].
  TokensTotalUSDProvider(
    String userGenesisAddress,
  ) : this._internal(
          (ref) => tokensTotalUSD(
            ref as TokensTotalUSDRef,
            userGenesisAddress,
          ),
          from: tokensTotalUSDProvider,
          name: r'tokensTotalUSDProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tokensTotalUSDHash,
          dependencies: TokensTotalUSDFamily._dependencies,
          allTransitiveDependencies:
              TokensTotalUSDFamily._allTransitiveDependencies,
          userGenesisAddress: userGenesisAddress,
        );

  TokensTotalUSDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userGenesisAddress,
  }) : super.internal();

  final String userGenesisAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(TokensTotalUSDRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TokensTotalUSDProvider._internal(
        (ref) => create(ref as TokensTotalUSDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userGenesisAddress: userGenesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _TokensTotalUSDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TokensTotalUSDProvider &&
        other.userGenesisAddress == userGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TokensTotalUSDRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `userGenesisAddress` of this provider.
  String get userGenesisAddress;
}

class _TokensTotalUSDProviderElement
    extends AutoDisposeFutureProviderElement<double> with TokensTotalUSDRef {
  _TokensTotalUSDProviderElement(super.provider);

  @override
  String get userGenesisAddress =>
      (origin as TokensTotalUSDProvider).userGenesisAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
