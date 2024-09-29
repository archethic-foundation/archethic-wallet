// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifiedTokensRepositoryHash() =>
    r'9d6ecb2f1bb17279dcb11c4cf97e91a8881de4b5';

/// See also [verifiedTokensRepository].
@ProviderFor(verifiedTokensRepository)
final verifiedTokensRepositoryProvider =
    Provider<aedappfm.VerifiedTokensRepositoryInterface>.internal(
  verifiedTokensRepository,
  name: r'verifiedTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VerifiedTokensRepositoryRef
    = ProviderRef<aedappfm.VerifiedTokensRepositoryInterface>;
String _$isVerifiedTokenHash() => r'3195cdd69ff19350c88b725cfec7afd9882c1b61';

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

/// See also [isVerifiedToken].
@ProviderFor(isVerifiedToken)
const isVerifiedTokenProvider = IsVerifiedTokenFamily();

/// See also [isVerifiedToken].
class IsVerifiedTokenFamily extends Family<AsyncValue<bool>> {
  /// See also [isVerifiedToken].
  const IsVerifiedTokenFamily();

  /// See also [isVerifiedToken].
  IsVerifiedTokenProvider call(
    String address,
  ) {
    return IsVerifiedTokenProvider(
      address,
    );
  }

  @override
  IsVerifiedTokenProvider getProviderOverride(
    covariant IsVerifiedTokenProvider provider,
  ) {
    return call(
      provider.address,
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
  String? get name => r'isVerifiedTokenProvider';
}

/// See also [isVerifiedToken].
class IsVerifiedTokenProvider extends FutureProvider<bool> {
  /// See also [isVerifiedToken].
  IsVerifiedTokenProvider(
    String address,
  ) : this._internal(
          (ref) => isVerifiedToken(
            ref as IsVerifiedTokenRef,
            address,
          ),
          from: isVerifiedTokenProvider,
          name: r'isVerifiedTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVerifiedTokenHash,
          dependencies: IsVerifiedTokenFamily._dependencies,
          allTransitiveDependencies:
              IsVerifiedTokenFamily._allTransitiveDependencies,
          address: address,
        );

  IsVerifiedTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsVerifiedTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsVerifiedTokenProvider._internal(
        (ref) => create(ref as IsVerifiedTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  FutureProviderElement<bool> createElement() {
    return _IsVerifiedTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsVerifiedTokenProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsVerifiedTokenRef on FutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsVerifiedTokenProviderElement extends FutureProviderElement<bool>
    with IsVerifiedTokenRef {
  _IsVerifiedTokenProviderElement(super.provider);

  @override
  String get address => (origin as IsVerifiedTokenProvider).address;
}

String _$verifiedTokensHash() => r'519fe3ad7903e97f43041f8f1355407ecb468de8';

/// See also [verifiedTokens].
@ProviderFor(verifiedTokens)
final verifiedTokensProvider = FutureProvider<List<String>>.internal(
  verifiedTokens,
  name: r'verifiedTokensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VerifiedTokensRef = FutureProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
