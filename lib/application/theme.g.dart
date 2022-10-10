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

String $_selectedThemeHash() => r'9c5b1303dd00571d8330e43193f29fdea47a64e6';

/// See also [_selectedTheme].
final _selectedThemeProvider = AutoDisposeProvider<BaseTheme>(
  _selectedTheme,
  name: r'_selectedThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedThemeHash,
);
typedef _SelectedThemeRef = AutoDisposeProviderRef<BaseTheme>;
String $_selectedThemeOptionHash() =>
    r'41ffc74805f1bac4147cdc749a3eff6d13aab936';

/// See also [_selectedThemeOption].
final _selectedThemeOptionProvider = AutoDisposeProvider<ThemeOptions>(
  _selectedThemeOption,
  name: r'_selectedThemeOptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedThemeOptionHash,
);
typedef _SelectedThemeOptionRef = AutoDisposeProviderRef<ThemeOptions>;
String $_selectThemeHash() => r'e1271b3e8fd93b4bdc9fb3ecdea16512ba07846f';

/// See also [_selectTheme].
class _SelectThemeProvider extends AutoDisposeFutureProvider<void> {
  _SelectThemeProvider({
    required this.theme,
  }) : super(
          (ref) => _selectTheme(
            ref,
            theme: theme,
          ),
          from: _selectThemeProvider,
          name: r'_selectThemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_selectThemeHash,
        );

  final ThemeOptions theme;

  @override
  bool operator ==(Object other) {
    return other is _SelectThemeProvider && other.theme == theme;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, theme.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SelectThemeRef = AutoDisposeFutureProviderRef<void>;

/// See also [_selectTheme].
final _selectThemeProvider = _SelectThemeFamily();

class _SelectThemeFamily extends Family<AsyncValue<void>> {
  _SelectThemeFamily();

  _SelectThemeProvider call({
    required ThemeOptions theme,
  }) {
    return _SelectThemeProvider(
      theme: theme,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _SelectThemeProvider provider,
  ) {
    return call(
      theme: provider.theme,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_selectThemeProvider';
}
