// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$environmentHash() => r'b04ffa81ca16ec271c5c3e798f17e95c6f543088';

/// See also [environment].
@ProviderFor(environment)
final environmentProvider = Provider<Environment>.internal(
  environment,
  name: r'environmentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$environmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnvironmentRef = ProviderRef<Environment>;
String _$sessionAESwapNotifierHash() =>
    r'ac7ea8a535a9a6645d6f92e873ec48ed4b6ca038';

/// See also [SessionAESwapNotifier].
@ProviderFor(SessionAESwapNotifier)
final sessionAESwapNotifierProvider =
    NotifierProvider<SessionAESwapNotifier, SessionAESwap>.internal(
  SessionAESwapNotifier.new,
  name: r'sessionAESwapNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionAESwapNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionAESwapNotifier = Notifier<SessionAESwap>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
