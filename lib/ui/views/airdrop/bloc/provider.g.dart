// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$airdropBannerStatusHash() =>
    r'753df7ced7f7ce2f9a2c8b1e9a13d2462ce7849c';

/// See also [airdropBannerStatus].
@ProviderFor(airdropBannerStatus)
final airdropBannerStatusProvider =
    AutoDisposeFutureProvider<({AirdropState state, String? email})>.internal(
  airdropBannerStatus,
  name: r'airdropBannerStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airdropBannerStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AirdropBannerStatusRef
    = AutoDisposeFutureProviderRef<({AirdropState state, String? email})>;
String _$airdropFormNotifierHash() =>
    r'6b0de5d9c4243be35e5b401a26d52022ca423b77';

/// See also [AirdropFormNotifier].
@ProviderFor(AirdropFormNotifier)
final airdropFormNotifierProvider =
    AutoDisposeNotifierProvider<AirdropFormNotifier, AirdropFormState>.internal(
  AirdropFormNotifier.new,
  name: r'airdropFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airdropFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AirdropFormNotifier = AutoDisposeNotifier<AirdropFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
