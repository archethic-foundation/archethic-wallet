// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_update_info.dart';

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

String _$_appVersionInfoRepositoryHash() =>
    r'7cdbbaab20bf993f94c7c133bc4caeeb713c9ba8';

/// See also [_appVersionInfoRepository].
final _appVersionInfoRepositoryProvider = Provider<AppVersionInfoRepository>(
  _appVersionInfoRepository,
  name: r'_appVersionInfoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_appVersionInfoRepositoryHash,
);
typedef _AppVersionInfoRepositoryRef = ProviderRef<AppVersionInfoRepository>;
String _$_getAppVersionInfoHash() =>
    r'8e07c50337a8d43e85be8bdb17d759ebde8e49a1';

/// See also [_getAppVersionInfo].
final _getAppVersionInfoProvider = FutureProvider<AppVersionInfo>(
  _getAppVersionInfo,
  name: r'_getAppVersionInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_getAppVersionInfoHash,
);
typedef _GetAppVersionInfoRef = FutureProviderRef<AppVersionInfo>;
