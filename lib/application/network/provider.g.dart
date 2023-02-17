// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkLinkHash() => r'a1ad177b35a24e339a2202520047ef4199644dc4';

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

typedef _NetworkLinkRef = AutoDisposeProviderRef<String>;

/// See also [_networkLink].
@ProviderFor(_networkLink)
const _networkLinkProvider = _NetworkLinkFamily();

/// See also [_networkLink].
class _NetworkLinkFamily extends Family<String> {
  /// See also [_networkLink].
  const _NetworkLinkFamily();

  /// See also [_networkLink].
  _NetworkLinkProvider call({
    required AvailableNetworks network,
  }) {
    return _NetworkLinkProvider(
      network: network,
    );
  }

  @override
  _NetworkLinkProvider getProviderOverride(
    covariant _NetworkLinkProvider provider,
  ) {
    return call(
      network: provider.network,
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
  String? get name => r'_networkLinkProvider';
}

/// See also [_networkLink].
class _NetworkLinkProvider extends AutoDisposeProvider<String> {
  /// See also [_networkLink].
  _NetworkLinkProvider({
    required this.network,
  }) : super.internal(
          (ref) => _networkLink(
            ref,
            network: network,
          ),
          from: _networkLinkProvider,
          name: r'_networkLinkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$networkLinkHash,
          dependencies: _NetworkLinkFamily._dependencies,
          allTransitiveDependencies:
              _NetworkLinkFamily._allTransitiveDependencies,
        );

  final AvailableNetworks network;

  @override
  bool operator ==(Object other) {
    return other is _NetworkLinkProvider && other.network == network;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$networkNodesHash() => r'9e80abce0e872f3536ca1c81cd6d2710eda2ba87';
typedef _NetworkNodesRef = AutoDisposeFutureProviderRef<List<Node>>;

/// See also [_networkNodes].
@ProviderFor(_networkNodes)
const _networkNodesProvider = _NetworkNodesFamily();

/// See also [_networkNodes].
class _NetworkNodesFamily extends Family<AsyncValue<List<Node>>> {
  /// See also [_networkNodes].
  const _NetworkNodesFamily();

  /// See also [_networkNodes].
  _NetworkNodesProvider call({
    required AvailableNetworks network,
  }) {
    return _NetworkNodesProvider(
      network: network,
    );
  }

  @override
  _NetworkNodesProvider getProviderOverride(
    covariant _NetworkNodesProvider provider,
  ) {
    return call(
      network: provider.network,
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
  String? get name => r'_networkNodesProvider';
}

/// See also [_networkNodes].
class _NetworkNodesProvider extends AutoDisposeFutureProvider<List<Node>> {
  /// See also [_networkNodes].
  _NetworkNodesProvider({
    required this.network,
  }) : super.internal(
          (ref) => _networkNodes(
            ref,
            network: network,
          ),
          from: _networkNodesProvider,
          name: r'_networkNodesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$networkNodesHash,
          dependencies: _NetworkNodesFamily._dependencies,
          allTransitiveDependencies:
              _NetworkNodesFamily._allTransitiveDependencies,
        );

  final AvailableNetworks network;

  @override
  bool operator ==(Object other) {
    return other is _NetworkNodesProvider && other.network == network;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$isReservedNodeUriHash() => r'60dab84965fa35027911aaa0cabff6c5523183b5';
typedef _IsReservedNodeUriRef = AutoDisposeFutureProviderRef<bool>;

/// See also [_isReservedNodeUri].
@ProviderFor(_isReservedNodeUri)
const _isReservedNodeUriProvider = _IsReservedNodeUriFamily();

/// See also [_isReservedNodeUri].
class _IsReservedNodeUriFamily extends Family<AsyncValue<bool>> {
  /// See also [_isReservedNodeUri].
  const _IsReservedNodeUriFamily();

  /// See also [_isReservedNodeUri].
  _IsReservedNodeUriProvider call({
    required Uri uri,
  }) {
    return _IsReservedNodeUriProvider(
      uri: uri,
    );
  }

  @override
  _IsReservedNodeUriProvider getProviderOverride(
    covariant _IsReservedNodeUriProvider provider,
  ) {
    return call(
      uri: provider.uri,
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
  String? get name => r'_isReservedNodeUriProvider';
}

/// See also [_isReservedNodeUri].
class _IsReservedNodeUriProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [_isReservedNodeUri].
  _IsReservedNodeUriProvider({
    required this.uri,
  }) : super.internal(
          (ref) => _isReservedNodeUri(
            ref,
            uri: uri,
          ),
          from: _isReservedNodeUriProvider,
          name: r'_isReservedNodeUriProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isReservedNodeUriHash,
          dependencies: _IsReservedNodeUriFamily._dependencies,
          allTransitiveDependencies:
              _IsReservedNodeUriFamily._allTransitiveDependencies,
        );

  final Uri uri;

  @override
  bool operator ==(Object other) {
    return other is _IsReservedNodeUriProvider && other.uri == uri;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uri.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
