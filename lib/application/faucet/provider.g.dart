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

String $_faucetRepositoryHash() => r'0700aacd141f765b45a052ac90ef9a6d3ca9aaa1';

/// See also [_faucetRepository].
final _faucetRepositoryProvider = Provider<FaucetRepositoryInterface>(
  _faucetRepository,
  name: r'_faucetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_faucetRepositoryHash,
);
typedef _FaucetRepositoryRef = ProviderRef<FaucetRepositoryInterface>;
String $_isDeviceCompatibleHash() =>
    r'c54eaf1bcd1f7ead1000d74b66455af25632b5d6';

/// See also [_isDeviceCompatible].
final _isDeviceCompatibleProvider = FutureProvider<bool>(
  _isDeviceCompatible,
  name: r'_isDeviceCompatibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isDeviceCompatibleHash,
);
typedef _IsDeviceCompatibleRef = FutureProviderRef<bool>;
String $_isFaucetEnabledHash() => r'828846b82c9029b973cb4bda1dae1c4de1f15be7';

/// See also [_isFaucetEnabled].
final _isFaucetEnabledProvider = FutureProvider<bool>(
  _isFaucetEnabled,
  name: r'_isFaucetEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_isFaucetEnabledHash,
);
typedef _IsFaucetEnabledRef = FutureProviderRef<bool>;
