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
    r'2caaa8028809aaef5b9d40e7857b8c195ae27617';

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
