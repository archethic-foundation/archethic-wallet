// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airdrop.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$airdropCountHash() => r'47f3b31f19c232b01edf74cd11212c43fa1ce636';

/// See also [airdropCount].
@ProviderFor(airdropCount)
final airdropCountProvider = AutoDisposeFutureProvider<
    ({int? participantCount, int? totalMultiplier})>.internal(
  airdropCount,
  name: r'airdropCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$airdropCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AirdropCountRef = AutoDisposeFutureProviderRef<
    ({int? participantCount, int? totalMultiplier})>;
String _$airdropPersonalLPHash() => r'63c4b9218433fa8e05dc8e7d1704224f1c634bd2';

/// See also [airdropPersonalLP].
@ProviderFor(airdropPersonalLP)
final airdropPersonalLPProvider = AutoDisposeFutureProvider<
    ({double personalLP, double personalLPFlexible})>.internal(
  airdropPersonalLP,
  name: r'airdropPersonalLPProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airdropPersonalLPHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AirdropPersonalLPRef = AutoDisposeFutureProviderRef<
    ({double personalLP, double personalLPFlexible})>;
String _$airdropUserInfoHash() => r'cd7a29733f105380c5e876d8497693c94976866d';

/// See also [airdropUserInfo].
@ProviderFor(airdropUserInfo)
final airdropUserInfoProvider = AutoDisposeFutureProvider<void>.internal(
  airdropUserInfo,
  name: r'airdropUserInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airdropUserInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AirdropUserInfoRef = AutoDisposeFutureProviderRef<void>;
String _$resendConfirmationMailHash() =>
    r'940e298edc7fe9debbc79faf2bb8f9fbbc32895d';

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

/// See also [resendConfirmationMail].
@ProviderFor(resendConfirmationMail)
const resendConfirmationMailProvider = ResendConfirmationMailFamily();

/// See also [resendConfirmationMail].
class ResendConfirmationMailFamily extends Family<AsyncValue<http.Response?>> {
  /// See also [resendConfirmationMail].
  const ResendConfirmationMailFamily();

  /// See also [resendConfirmationMail].
  ResendConfirmationMailProvider call(
    String mailAddress,
  ) {
    return ResendConfirmationMailProvider(
      mailAddress,
    );
  }

  @override
  ResendConfirmationMailProvider getProviderOverride(
    covariant ResendConfirmationMailProvider provider,
  ) {
    return call(
      provider.mailAddress,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'resendConfirmationMailProvider';
}

/// See also [resendConfirmationMail].
class ResendConfirmationMailProvider
    extends AutoDisposeFutureProvider<http.Response?> {
  /// See also [resendConfirmationMail].
  ResendConfirmationMailProvider(
    String mailAddress,
  ) : this._internal(
          (ref) => resendConfirmationMail(
            ref as ResendConfirmationMailRef,
            mailAddress,
          ),
          from: resendConfirmationMailProvider,
          name: r'resendConfirmationMailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resendConfirmationMailHash,
          dependencies: ResendConfirmationMailFamily._dependencies,
          allTransitiveDependencies:
              ResendConfirmationMailFamily._allTransitiveDependencies,
          mailAddress: mailAddress,
        );

  ResendConfirmationMailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mailAddress,
  }) : super.internal();

  final String mailAddress;

  @override
  Override overrideWith(
    FutureOr<http.Response?> Function(ResendConfirmationMailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResendConfirmationMailProvider._internal(
        (ref) => create(ref as ResendConfirmationMailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mailAddress: mailAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<http.Response?> createElement() {
    return _ResendConfirmationMailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResendConfirmationMailProvider &&
        other.mailAddress == mailAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mailAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ResendConfirmationMailRef
    on AutoDisposeFutureProviderRef<http.Response?> {
  /// The parameter `mailAddress` of this provider.
  String get mailAddress;
}

class _ResendConfirmationMailProviderElement
    extends AutoDisposeFutureProviderElement<http.Response?>
    with ResendConfirmationMailRef {
  _ResendConfirmationMailProviderElement(super.provider);

  @override
  String get mailAddress =>
      (origin as ResendConfirmationMailProvider).mailAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
