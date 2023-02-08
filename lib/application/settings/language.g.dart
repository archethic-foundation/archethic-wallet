// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

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

String _$_selectedLanguageHash() => r'c63fc0ebfcfac294c5aad3f7132338ffb10ab0f1';

/// See also [_selectedLanguage].
final _selectedLanguageProvider = Provider<AvailableLanguage>(
  _selectedLanguage,
  name: r'_selectedLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_selectedLanguageHash,
);
typedef _SelectedLanguageRef = ProviderRef<AvailableLanguage>;
String _$_selectedLocaleHash() => r'b1fa4f810786d439212304efb93e2e420b1d1993';

/// Resolves the selected locale
///
/// If LanguageSetting is set to LanguageSetting.systemDefault, returns defaultLocale
/// Otherwise returns selected locale.
///
/// Copied from [_selectedLocale].
final _selectedLocaleProvider = Provider<Locale>(
  _selectedLocale,
  name: r'_selectedLocaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_selectedLocaleHash,
);
typedef _SelectedLocaleRef = ProviderRef<Locale>;
String _$_availableLocalesHash() => r'6410cb4632cd07d7908474099e9c859a83fc02a8';

/// See also [_availableLocales].
final _availableLocalesProvider = Provider<List<Locale>>(
  _availableLocales,
  name: r'_availableLocalesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_availableLocalesHash,
);
typedef _AvailableLocalesRef = ProviderRef<List<Locale>>;
