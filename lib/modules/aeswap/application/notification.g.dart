// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'32cf09126f5267aad468484c4e1575933cfa50be';

/// See also [_notificationService].
@ProviderFor(_notificationService)
final _notificationServiceProvider =
    Provider<ns.TaskNotificationService<DexNotification, Failure>>.internal(
  _notificationService,
  name: r'_notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _NotificationServiceRef
    = ProviderRef<ns.TaskNotificationService<DexNotification, Failure>>;
String _$runningTasksHash() => r'a53f77f44221e2e383bbe85b245d0df6f34f82b1';

/// See also [_runningTasks].
@ProviderFor(_runningTasks)
final _runningTasksProvider =
    StreamProvider<Iterable<ns.Task<DexNotification, Failure>>>.internal(
  _runningTasks,
  name: r'_runningTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$runningTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _RunningTasksRef
    = StreamProviderRef<Iterable<ns.Task<DexNotification, Failure>>>;
String _$doneTasksHash() => r'df6a1139ee09306ec07da8834ddb6447ea301116';

/// See also [_doneTasks].
@ProviderFor(_doneTasks)
final _doneTasksProvider =
    StreamProvider<ns.Task<DexNotification, Failure>>.internal(
  _doneTasks,
  name: r'_doneTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$doneTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DoneTasksRef = StreamProviderRef<ns.Task<DexNotification, Failure>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
