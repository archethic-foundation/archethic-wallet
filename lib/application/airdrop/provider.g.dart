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
String $_isAirdropEligibleHash() => r'e9c9350992f33b59625d7e23adbf52fb744e5ca6';

/// Is currently selected account authorized to claim Airdrop reward ?
///
/// Copied from [_isAirdropEligible].
final _isAirdropEligibleProvider = FutureProvider<bool>(
  _isAirdropEligible,
  name: r'_isAirdropEligibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isAirdropEligibleHash,
);
typedef _IsAirdropEligibleRef = FutureProviderRef<bool>;
String $_isAirdropEnabledHash() => r'7b901542684b974b9fcb7f0ab2e92750fcf7ca96';

/// See also [_isAirdropEnabled].
final _isAirdropEnabledProvider = FutureProvider<bool>(
  _isAirdropEnabled,
  name: r'_isAirdropEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isAirdropEnabledHash,
);
typedef _IsAirdropEnabledRef = FutureProviderRef<bool>;
