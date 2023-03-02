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

String $_cleanUriHash() => r'4a44778ecff5589eacdafd249deb86c02f934bec';

/// See also [_cleanUri].
class _CleanUriProvider extends AutoDisposeProvider<Uri> {
  _CleanUriProvider({
    required this.uri,
  }) : super(
          (ref) => _cleanUri(
            ref,
            uri: uri,
          ),
          from: _cleanUriProvider,
          name: r'_cleanUriProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_cleanUriHash,
        );

  final String uri;

  @override
  bool operator ==(Object other) {
    return other is _CleanUriProvider && other.uri == uri;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uri.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _CleanUriRef = AutoDisposeProviderRef<Uri>;

/// See also [_cleanUri].
final _cleanUriProvider = _CleanUriFamily();

class _CleanUriFamily extends Family<Uri> {
  _CleanUriFamily();

  _CleanUriProvider call({
    required String uri,
  }) {
    return _CleanUriProvider(
      uri: uri,
    );
  }

  @override
  AutoDisposeProvider<Uri> getProviderOverride(
    covariant _CleanUriProvider provider,
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
  String? get name => r'_cleanUriProvider';
}

String $_isUrlValidHash() => r'e6e8a5498d22a03e9c08d2d4940d2da8de240176';

/// See also [_isUrlValid].
class _IsUrlValidProvider extends AutoDisposeProvider<bool> {
  _IsUrlValidProvider({
    required this.uri,
  }) : super(
          (ref) => _isUrlValid(
            ref,
            uri: uri,
          ),
          from: _isUrlValidProvider,
          name: r'_isUrlValidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_isUrlValidHash,
        );

  final Uri uri;

  @override
  bool operator ==(Object other) {
    return other is _IsUrlValidProvider && other.uri == uri;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uri.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _IsUrlValidRef = AutoDisposeProviderRef<bool>;

/// See also [_isUrlValid].
final _isUrlValidProvider = _IsUrlValidFamily();

class _IsUrlValidFamily extends Family<bool> {
  _IsUrlValidFamily();

  _IsUrlValidProvider call({
    required Uri uri,
  }) {
    return _IsUrlValidProvider(
      uri: uri,
    );
  }

  @override
  AutoDisposeProvider<bool> getProviderOverride(
    covariant _IsUrlValidProvider provider,
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
  String? get name => r'_isUrlValidProvider';
}

String $_isUrlIPFSHash() => r'5812380f0fe7db502ca372abeb3d4b75e6540ee4';

/// See also [_isUrlIPFS].
class _IsUrlIPFSProvider extends AutoDisposeProvider<bool> {
  _IsUrlIPFSProvider({
    required this.uri,
  }) : super(
          (ref) => _isUrlIPFS(
            ref,
            uri: uri,
          ),
          from: _isUrlIPFSProvider,
          name: r'_isUrlIPFSProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_isUrlIPFSHash,
        );

  final Uri uri;

  @override
  bool operator ==(Object other) {
    return other is _IsUrlIPFSProvider && other.uri == uri;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uri.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _IsUrlIPFSRef = AutoDisposeProviderRef<bool>;

/// See also [_isUrlIPFS].
final _isUrlIPFSProvider = _IsUrlIPFSFamily();

class _IsUrlIPFSFamily extends Family<bool> {
  _IsUrlIPFSFamily();

  _IsUrlIPFSProvider call({
    required Uri uri,
  }) {
    return _IsUrlIPFSProvider(
      uri: uri,
    );
  }

  @override
  AutoDisposeProvider<bool> getProviderOverride(
    covariant _IsUrlIPFSProvider provider,
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
  String? get name => r'_isUrlIPFSProvider';
}
