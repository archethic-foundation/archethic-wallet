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
String _$getTokensListHash() => r'6828404cac5119af9b100b2ed92133a397020eb8';

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
    String userGenesisAddress,
  ) {
    return _GetTokensListProvider(
      userGenesisAddress,
    );
  }

  @override
  _GetTokensListProvider getProviderOverride(
    covariant _GetTokensListProvider provider,
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
  String? get name => r'_getTokensListProvider';
}

/// See also [_getTokensList].
class _GetTokensListProvider extends AutoDisposeFutureProvider<List<AEToken>> {
  /// See also [_getTokensList].
  _GetTokensListProvider(
    String userGenesisAddress,
  ) : this._internal(
          (ref) => _getTokensList(
            ref as _GetTokensListRef,
            userGenesisAddress,
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
        );

  _GetTokensListProvider._internal(
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
        other.userGenesisAddress == userGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokensListRef on AutoDisposeFutureProviderRef<List<AEToken>> {
  /// The parameter `userGenesisAddress` of this provider.
  String get userGenesisAddress;
}

class _GetTokensListProviderElement
    extends AutoDisposeFutureProviderElement<List<AEToken>>
    with _GetTokensListRef {
  _GetTokensListProviderElement(super.provider);

  @override
  String get userGenesisAddress =>
      (origin as _GetTokensListProvider).userGenesisAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
