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

String $_selectedLanguageHash() => r'51be0bff0d8a3b5a0b4b9d4f6017fffe0e1d6ae5';

/// See also [_selectedLanguage].
final _selectedLanguageProvider = Provider<LanguageSetting>(
  _selectedLanguage,
  name: r'_selectedLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedLanguageHash,
);
typedef _SelectedLanguageRef = ProviderRef<LanguageSetting>;
String $_selectedLocaleHash() => r'b1fa4f810786d439212304efb93e2e420b1d1993';

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
      : $_selectedLocaleHash,
);
typedef _SelectedLocaleRef = ProviderRef<Locale>;
String $_availableLocalesHash() => r'6410cb4632cd07d7908474099e9c859a83fc02a8';

/// See also [_availableLocales].
final _availableLocalesProvider = Provider<List<Locale>>(
  _availableLocales,
  name: r'_availableLocalesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_availableLocalesHash,
);
typedef _AvailableLocalesRef = ProviderRef<List<Locale>>;
String $_selectLanguageHash() => r'5e6cedcf0ff3db0cfdf81ea28905965eeda99ec2';

/// See also [_selectLanguage].
class _SelectLanguageProvider extends AutoDisposeFutureProvider<void> {
  _SelectLanguageProvider({
    required this.language,
  }) : super(
          (ref) => _selectLanguage(
            ref,
            language: language,
          ),
          from: _selectLanguageProvider,
          name: r'_selectLanguageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_selectLanguageHash,
        );

  final AvailableLanguage language;

  @override
  bool operator ==(Object other) {
    return other is _SelectLanguageProvider && other.language == language;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, language.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SelectLanguageRef = AutoDisposeFutureProviderRef<void>;

/// See also [_selectLanguage].
final _selectLanguageProvider = _SelectLanguageFamily();

class _SelectLanguageFamily extends Family<AsyncValue<void>> {
  _SelectLanguageFamily();

  _SelectLanguageProvider call({
    required AvailableLanguage language,
  }) {
    return _SelectLanguageProvider(
      language: language,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _SelectLanguageProvider provider,
  ) {
    return call(
      language: provider.language,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_selectLanguageProvider';
}
