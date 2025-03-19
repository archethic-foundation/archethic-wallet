// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transak.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transakWebpageUriHash() => r'35f5189aa42355840a67c122a8972901518b3564';

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

/// See also [transakWebpageUri].
@ProviderFor(transakWebpageUri)
const transakWebpageUriProvider = TransakWebpageUriFamily();

/// See also [transakWebpageUri].
class TransakWebpageUriFamily extends Family<Uri> {
  /// See also [transakWebpageUri].
  const TransakWebpageUriFamily();

  /// See also [transakWebpageUri].
  TransakWebpageUriProvider call({
    required String depositAddress,
  }) {
    return TransakWebpageUriProvider(
      depositAddress: depositAddress,
    );
  }

  @override
  TransakWebpageUriProvider getProviderOverride(
    covariant TransakWebpageUriProvider provider,
  ) {
    return call(
      depositAddress: provider.depositAddress,
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
  String? get name => r'transakWebpageUriProvider';
}

/// See also [transakWebpageUri].
class TransakWebpageUriProvider extends AutoDisposeProvider<Uri> {
  /// See also [transakWebpageUri].
  TransakWebpageUriProvider({
    required String depositAddress,
  }) : this._internal(
          (ref) => transakWebpageUri(
            ref as TransakWebpageUriRef,
            depositAddress: depositAddress,
          ),
          from: transakWebpageUriProvider,
          name: r'transakWebpageUriProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transakWebpageUriHash,
          dependencies: TransakWebpageUriFamily._dependencies,
          allTransitiveDependencies:
              TransakWebpageUriFamily._allTransitiveDependencies,
          depositAddress: depositAddress,
        );

  TransakWebpageUriProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.depositAddress,
  }) : super.internal();

  final String depositAddress;

  @override
  Override overrideWith(
    Uri Function(TransakWebpageUriRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransakWebpageUriProvider._internal(
        (ref) => create(ref as TransakWebpageUriRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        depositAddress: depositAddress,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Uri> createElement() {
    return _TransakWebpageUriProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransakWebpageUriProvider &&
        other.depositAddress == depositAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, depositAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransakWebpageUriRef on AutoDisposeProviderRef<Uri> {
  /// The parameter `depositAddress` of this provider.
  String get depositAddress;
}

class _TransakWebpageUriProviderElement extends AutoDisposeProviderElement<Uri>
    with TransakWebpageUriRef {
  _TransakWebpageUriProviderElement(super.provider);

  @override
  String get depositAddress =>
      (origin as TransakWebpageUriProvider).depositAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
