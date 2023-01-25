// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

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

String $_networkLinkHash() => r'a1ad177b35a24e339a2202520047ef4199644dc4';

/// See also [_networkLink].
class _NetworkLinkProvider extends AutoDisposeProvider<String> {
  _NetworkLinkProvider({
    required this.network,
  }) : super(
          (ref) => _networkLink(
            ref,
            network: network,
          ),
          from: _networkLinkProvider,
          name: r'_networkLinkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_networkLinkHash,
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

typedef _NetworkLinkRef = AutoDisposeProviderRef<String>;

/// See also [_networkLink].
final _networkLinkProvider = _NetworkLinkFamily();

class _NetworkLinkFamily extends Family<String> {
  _NetworkLinkFamily();

  _NetworkLinkProvider call({
    required AvailableNetworks network,
  }) {
    return _NetworkLinkProvider(
      network: network,
    );
  }

  @override
  AutoDisposeProvider<String> getProviderOverride(
    covariant _NetworkLinkProvider provider,
  ) {
    return call(
      network: provider.network,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_networkLinkProvider';
}

String $_networkNodesHash() => r'9e80abce0e872f3536ca1c81cd6d2710eda2ba87';

/// See also [_networkNodes].
class _NetworkNodesProvider extends AutoDisposeFutureProvider<List<Node>> {
  _NetworkNodesProvider({
    required this.network,
  }) : super(
          (ref) => _networkNodes(
            ref,
            network: network,
          ),
          from: _networkNodesProvider,
          name: r'_networkNodesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_networkNodesHash,
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

typedef _NetworkNodesRef = AutoDisposeFutureProviderRef<List<Node>>;

/// See also [_networkNodes].
final _networkNodesProvider = _NetworkNodesFamily();

class _NetworkNodesFamily extends Family<AsyncValue<List<Node>>> {
  _NetworkNodesFamily();

  _NetworkNodesProvider call({
    required AvailableNetworks network,
  }) {
    return _NetworkNodesProvider(
      network: network,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Node>> getProviderOverride(
    covariant _NetworkNodesProvider provider,
  ) {
    return call(
      network: provider.network,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_networkNodesProvider';
}

String $_isReservedNodeUriHash() => r'60dab84965fa35027911aaa0cabff6c5523183b5';

/// See also [_isReservedNodeUri].
class _IsReservedNodeUriProvider extends AutoDisposeFutureProvider<bool> {
  _IsReservedNodeUriProvider({
    required this.uri,
  }) : super(
          (ref) => _isReservedNodeUri(
            ref,
            uri: uri,
          ),
          from: _isReservedNodeUriProvider,
          name: r'_isReservedNodeUriProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_isReservedNodeUriHash,
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

typedef _IsReservedNodeUriRef = AutoDisposeFutureProviderRef<bool>;

/// See also [_isReservedNodeUri].
final _isReservedNodeUriProvider = _IsReservedNodeUriFamily();

class _IsReservedNodeUriFamily extends Family<AsyncValue<bool>> {
  _IsReservedNodeUriFamily();

  _IsReservedNodeUriProvider call({
    required Uri uri,
  }) {
    return _IsReservedNodeUriProvider(
      uri: uri,
    );
  }

  @override
  AutoDisposeFutureProvider<bool> getProviderOverride(
    covariant _IsReservedNodeUriProvider provider,
  ) {
    return call(
      uri: provider.uri,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_isReservedNodeUriProvider';
}
