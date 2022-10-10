// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

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

String $_accountRepositoryHash() => r'afe2ee1ebe77e5b3ff7bc7e5d6941b52c0712395';

/// See also [_accountRepository].
final _accountRepositoryProvider = AutoDisposeProvider<AccountRepository>(
  _accountRepository,
  name: r'_accountRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_accountRepositoryHash,
);
typedef _AccountRepositoryRef = AutoDisposeProviderRef<AccountRepository>;
String $_getSelectedAccountHash() =>
    r'09ee14ce0f831e9e4fc8ac51acc3ed4b39693776';

/// See also [_getSelectedAccount].
class _GetSelectedAccountProvider extends AutoDisposeProvider<Account?> {
  _GetSelectedAccountProvider({
    required this.context,
  }) : super(
          (ref) => _getSelectedAccount(
            ref,
            context: context,
          ),
          from: _getSelectedAccountProvider,
          name: r'_getSelectedAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getSelectedAccountHash,
        );

  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is _GetSelectedAccountProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _GetSelectedAccountRef = AutoDisposeProviderRef<Account?>;

/// See also [_getSelectedAccount].
final _getSelectedAccountProvider = _GetSelectedAccountFamily();

class _GetSelectedAccountFamily extends Family<Account?> {
  _GetSelectedAccountFamily();

  _GetSelectedAccountProvider call({
    required BuildContext context,
  }) {
    return _GetSelectedAccountProvider(
      context: context,
    );
  }

  @override
  AutoDisposeProvider<Account?> getProviderOverride(
    covariant _GetSelectedAccountProvider provider,
  ) {
    return call(
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getSelectedAccountProvider';
}
