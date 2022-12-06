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
String $_airdropCooldownHash() => r'90a7d7f222b26a81f09ff5d25411fbc0e6c6f072';

/// See also [_airdropCooldown].
final _airdropCooldownProvider = FutureProvider<Duration>(
  _airdropCooldown,
  name: r'_airdropCooldownProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_airdropCooldownHash,
);
typedef _AirdropCooldownRef = FutureProviderRef<Duration>;
String $_isAirdropEligibleHash() => r'822f16247707f90430d8ce617c36b1b7bbf1d787';

/// See also [_isAirdropEligible].
final _isAirdropEligibleProvider = FutureProvider<bool>(
  _isAirdropEligible,
  name: r'_isAirdropEligibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isAirdropEligibleHash,
);
typedef _IsAirdropEligibleRef = FutureProviderRef<bool>;
