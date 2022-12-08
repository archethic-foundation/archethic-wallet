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

String $_airDropRepositoryHash() => r'f7c97ae3c8b1870ea062645b2d38e9ea3e643d3d';

/// See also [_airDropRepository].
final _airDropRepositoryProvider = Provider<AirDropRepositoryInterface>(
  _airDropRepository,
  name: r'_airDropRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_airDropRepositoryHash,
);
typedef _AirDropRepositoryRef = ProviderRef<AirDropRepositoryInterface>;
String $_isAirdropEnabledHash() => r'59eebd0a852ab5e5ba6bbd441692ffd0659c0bd9';

/// See also [_isAirdropEnabled].
final _isAirdropEnabledProvider = FutureProvider<bool>(
  _isAirdropEnabled,
  name: r'_isAirdropEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isAirdropEnabledHash,
);
typedef _IsAirdropEnabledRef = FutureProviderRef<bool>;
