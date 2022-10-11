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

String $_selectedLanguageHash() => r'37b06015c4bf351709d070fe2c623cff28e376fc';

/// See also [_selectedLanguage].
final _selectedLanguageProvider = AutoDisposeProvider<LanguageSetting>(
  _selectedLanguage,
  name: r'_selectedLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedLanguageHash,
);
typedef _SelectedLanguageRef = AutoDisposeProviderRef<LanguageSetting>;
String $_selectedLocaleHash() => r'6721d4f8a355bb8ff4f7bb52dfbc024f5ac22ae3';

/// Resolves the selected locale
///
/// If LanguageSetting is set to LanguageSetting.systemDefault, returns defaultLocale
/// Otherwise returns selected locale.
///
/// Copied from [_selectedLocale].
final _selectedLocaleProvider = AutoDisposeProvider<Locale>(
  _selectedLocale,
  name: r'_selectedLocaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedLocaleHash,
);
typedef _SelectedLocaleRef = AutoDisposeProviderRef<Locale>;
String $_availableLocalesHash() => r'15ade716063e8ec29321174cee3d0b617b4c6955';

/// See also [_availableLocales].
final _availableLocalesProvider = AutoDisposeProvider<List<Locale>>(
  _availableLocales,
  name: r'_availableLocalesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_availableLocalesHash,
);
typedef _AvailableLocalesRef = AutoDisposeProviderRef<List<Locale>>;
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
