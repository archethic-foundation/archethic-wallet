// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airdrop.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$airdropBackendUrlHash() => r'2fd644bbc1766c2c4dba8173a1196b029e34b683';

/// See also [airdropBackendUrl].
@ProviderFor(airdropBackendUrl)
final airdropBackendUrlProvider = AutoDisposeProvider<String>.internal(
  airdropBackendUrl,
  name: r'airdropBackendUrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airdropBackendUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AirdropBackendUrlRef = AutoDisposeProviderRef<String>;
String _$airdropCountHash() => r'5aa92537a5e7f95e24a271d869f22e229aed0d5c';

/// See also [airdropCount].
@ProviderFor(airdropCount)
final airdropCountProvider = AutoDisposeFutureProvider<
    ({
      int? participantCount,
      int? totalPersonalMultiplier,
      int? totalReferralMultiplier
    })>.internal(
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
    ({
      int? participantCount,
      int? totalPersonalMultiplier,
      int? totalReferralMultiplier
    })>;
String _$airdropPersonalLPHash() => r'94626dadd26ddec3c851f5c6d6e5d93436ea8162';

/// See also [airdropPersonalLP].
@ProviderFor(airdropPersonalLP)
final airdropPersonalLPProvider = AutoDisposeFutureProvider<
    ({
      int personalMultiplier,
      double personalLP,
      double personalLPFlexible
    })>.internal(
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
    ({int personalMultiplier, double personalLP, double personalLPFlexible})>;
String _$airdropUserInfoHash() => r'8b929100b1dda5fcb1cc07c7b427c03a7c18a6a0';

/// See also [airdropUserInfo].
@ProviderFor(airdropUserInfo)
final airdropUserInfoProvider = AutoDisposeFutureProvider<
    ({
      bool? isMailConfirmed,
      String? email,
      String? referralCode,
      int? referralsRegistered,
      int? referralsParticipant,
      int? referralMultiplier
    })>.internal(
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
typedef AirdropUserInfoRef = AutoDisposeFutureProviderRef<
    ({
      bool? isMailConfirmed,
      String? email,
      String? referralCode,
      int? referralsRegistered,
      int? referralsParticipant,
      int? referralMultiplier
    })>;
String _$resendConfirmationMailHash() =>
    r'45c817013de6fc6ec3a74600c3671646ee189d55';

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

String _$checkReferralCodeProvidedHash() =>
    r'db5b3786ce2cbecd956bf55b1ce587f7c701ffa2';

/// See also [checkReferralCodeProvided].
@ProviderFor(checkReferralCodeProvided)
const checkReferralCodeProvidedProvider = CheckReferralCodeProvidedFamily();

/// See also [checkReferralCodeProvided].
class CheckReferralCodeProvidedFamily extends Family<AsyncValue<bool>> {
  /// See also [checkReferralCodeProvided].
  const CheckReferralCodeProvidedFamily();

  /// See also [checkReferralCodeProvided].
  CheckReferralCodeProvidedProvider call(
    String referralCodeProvided,
  ) {
    return CheckReferralCodeProvidedProvider(
      referralCodeProvided,
    );
  }

  @override
  CheckReferralCodeProvidedProvider getProviderOverride(
    covariant CheckReferralCodeProvidedProvider provider,
  ) {
    return call(
      provider.referralCodeProvided,
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
  String? get name => r'checkReferralCodeProvidedProvider';
}

/// See also [checkReferralCodeProvided].
class CheckReferralCodeProvidedProvider
    extends AutoDisposeFutureProvider<bool> {
  /// See also [checkReferralCodeProvided].
  CheckReferralCodeProvidedProvider(
    String referralCodeProvided,
  ) : this._internal(
          (ref) => checkReferralCodeProvided(
            ref as CheckReferralCodeProvidedRef,
            referralCodeProvided,
          ),
          from: checkReferralCodeProvidedProvider,
          name: r'checkReferralCodeProvidedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkReferralCodeProvidedHash,
          dependencies: CheckReferralCodeProvidedFamily._dependencies,
          allTransitiveDependencies:
              CheckReferralCodeProvidedFamily._allTransitiveDependencies,
          referralCodeProvided: referralCodeProvided,
        );

  CheckReferralCodeProvidedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.referralCodeProvided,
  }) : super.internal();

  final String referralCodeProvided;

  @override
  Override overrideWith(
    FutureOr<bool> Function(CheckReferralCodeProvidedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckReferralCodeProvidedProvider._internal(
        (ref) => create(ref as CheckReferralCodeProvidedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        referralCodeProvided: referralCodeProvided,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _CheckReferralCodeProvidedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckReferralCodeProvidedProvider &&
        other.referralCodeProvided == referralCodeProvided;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, referralCodeProvided.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckReferralCodeProvidedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `referralCodeProvided` of this provider.
  String get referralCodeProvided;
}

class _CheckReferralCodeProvidedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with CheckReferralCodeProvidedRef {
  _CheckReferralCodeProvidedProviderElement(super.provider);

  @override
  String get referralCodeProvided =>
      (origin as CheckReferralCodeProvidedProvider).referralCodeProvided;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
