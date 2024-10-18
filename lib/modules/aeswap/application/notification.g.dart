// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'728b1d31d97ecf4ad047994bd3ecc6585486e472';

/// See also [_notificationService].
@ProviderFor(_notificationService)
final _notificationServiceProvider = AutoDisposeProvider<
    ns.TaskNotificationService<DexNotification, Failure>>.internal(
  _notificationService,
  name: r'_notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _NotificationServiceRef = AutoDisposeProviderRef<
    ns.TaskNotificationService<DexNotification, Failure>>;
String _$runningTasksHash() => r'0c6a1bbceddf6f3df5513c70ccca8852d28d690f';

/// See also [_runningTasks].
@ProviderFor(_runningTasks)
final _runningTasksProvider = AutoDisposeStreamProvider<
    Iterable<ns.Task<DexNotification, Failure>>>.internal(
  _runningTasks,
  name: r'_runningTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$runningTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _RunningTasksRef
    = AutoDisposeStreamProviderRef<Iterable<ns.Task<DexNotification, Failure>>>;
String _$doneTasksHash() => r'b373730ca692fb673204369de57a51320a6d6dc4';

/// See also [_doneTasks].
@ProviderFor(_doneTasks)
final _doneTasksProvider =
    AutoDisposeStreamProvider<ns.Task<DexNotification, Failure>>.internal(
  _doneTasks,
  name: r'_doneTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$doneTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DoneTasksRef
    = AutoDisposeStreamProviderRef<ns.Task<DexNotification, Failure>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
