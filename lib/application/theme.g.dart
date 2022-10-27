// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

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

String $_ThemeNotifierHash() => r'78b9eb32fc3fb98c4419f0fd7fb5e96d5ce2470e';

/// See also [_ThemeNotifier].
final _themeNotifierProvider = NotifierProvider<_ThemeNotifier, ThemeOptions>(
  _ThemeNotifier.new,
  name: r'_themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_ThemeNotifierHash,
);
typedef _ThemeNotifierRef = NotifierProviderRef<ThemeOptions>;

abstract class _$ThemeNotifier extends Notifier<ThemeOptions> {
  @override
  ThemeOptions build();
}

String $_selectedThemeHash() => r'f3e875949f84ddd7762bbb820067351e081c2e42';

/// See also [_selectedTheme].
final _selectedThemeProvider = Provider<BaseTheme>(
  _selectedTheme,
  name: r'_selectedThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedThemeHash,
);
typedef _SelectedThemeRef = ProviderRef<BaseTheme>;
