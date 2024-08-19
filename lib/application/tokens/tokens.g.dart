// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokensRepositoryHash() => r'd30111b6cdaaca643925a532add6475526500372';

/// See also [_tokensRepository].
@ProviderFor(_tokensRepository)
final _tokensRepositoryProvider =
    AutoDisposeProvider<TokensRepositoryImpl>.internal(
  _tokensRepository,
  name: r'_tokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _TokensRepositoryRef = AutoDisposeProviderRef<TokensRepositoryImpl>;
String _$getTokensListHash() => r'6e81ca1d2776e29cee6db19840ffd3ee8f498057';

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

/// See also [_getTokensList].
@ProviderFor(_getTokensList)
const _getTokensListProvider = _GetTokensListFamily();

/// See also [_getTokensList].
class _GetTokensListFamily extends Family<AsyncValue<List<AEToken>>> {
  /// See also [_getTokensList].
  const _GetTokensListFamily();

  /// See also [_getTokensList].
  _GetTokensListProvider call(
    String userGenesisAddress, {
    bool withVerified = true,
    bool withLPToken = false,
    bool withNotVerified = false,
  }) {
    return _GetTokensListProvider(
      userGenesisAddress,
      withVerified: withVerified,
      withLPToken: withLPToken,
      withNotVerified: withNotVerified,
    );
  }

  @override
  _GetTokensListProvider getProviderOverride(
    covariant _GetTokensListProvider provider,
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
  String? get name => r'_getTokensListProvider';
}

/// See also [_getTokensList].
class _GetTokensListProvider extends AutoDisposeFutureProvider<List<AEToken>> {
  /// See also [_getTokensList].
  _GetTokensListProvider(
    String userGenesisAddress, {
    bool withVerified = true,
    bool withLPToken = false,
    bool withNotVerified = false,
  }) : this._internal(
          (ref) => _getTokensList(
            ref as _GetTokensListRef,
            userGenesisAddress,
            withVerified: withVerified,
            withLPToken: withLPToken,
            withNotVerified: withNotVerified,
          ),
          from: _getTokensListProvider,
          name: r'_getTokensListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokensListHash,
          dependencies: _GetTokensListFamily._dependencies,
          allTransitiveDependencies:
              _GetTokensListFamily._allTransitiveDependencies,
          userGenesisAddress: userGenesisAddress,
          withVerified: withVerified,
          withLPToken: withLPToken,
          withNotVerified: withNotVerified,
        );

  _GetTokensListProvider._internal(
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
    FutureOr<List<AEToken>> Function(_GetTokensListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokensListProvider._internal(
        (ref) => create(ref as _GetTokensListRef),
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
    return _GetTokensListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokensListProvider &&
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

mixin _GetTokensListRef on AutoDisposeFutureProviderRef<List<AEToken>> {
  /// The parameter `userGenesisAddress` of this provider.
  String get userGenesisAddress;

  /// The parameter `withVerified` of this provider.
  bool get withVerified;

  /// The parameter `withLPToken` of this provider.
  bool get withLPToken;

  /// The parameter `withNotVerified` of this provider.
  bool get withNotVerified;
}

class _GetTokensListProviderElement
    extends AutoDisposeFutureProviderElement<List<AEToken>>
    with _GetTokensListRef {
  _GetTokensListProviderElement(super.provider);

  @override
  String get userGenesisAddress =>
      (origin as _GetTokensListProvider).userGenesisAddress;
  @override
  bool get withVerified => (origin as _GetTokensListProvider).withVerified;
  @override
  bool get withLPToken => (origin as _GetTokensListProvider).withLPToken;
  @override
  bool get withNotVerified =>
      (origin as _GetTokensListProvider).withNotVerified;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
