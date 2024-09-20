import 'dart:async';
import 'dart:developer' as dev;

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.dart';
part 'task_notification_service.freezed.dart';

/// Simple Notification service used to publish/dismiss notifications
/// and consume a notifications iterable.
///
/// This is intended to be library agnostic.
class TaskNotificationService<TaskDataT, TaskFailureT extends Failure> {
  void log(String message) => dev.log(
        message,
        name: 'NotificationService',
      );
  Iterable<Task<TaskDataT, TaskFailureT>> _runningTasks = [];

  final _runningTasksStreamController =
      StreamController<Iterable<Task<TaskDataT, TaskFailureT>>>.broadcast();
  Stream<Iterable<Task<TaskDataT, TaskFailureT>>> runningTasks() =>
      _runningTasksStreamController.stream;

  final _doneTasksStreamController =
      StreamController<Task<TaskDataT, TaskFailureT>>.broadcast();
  Stream<Task<TaskDataT, TaskFailureT>> doneTasks() =>
      _doneTasksStreamController.stream;

  void start(String id, TaskDataT data) {
    if (_containsId(id)) return;

    log('Add Task $id');
    _updateRunningTasks([
      ..._runningTasks,
      Task(
        id: id,
        data: data,
        dateTask: DateTime.now(),
      ),
    ]);
  }

  void failed(String taskId, TaskFailureT failure) {
    log('Task failed $taskId');
    final task = _findRunningTask(taskId);

    _updateRunningTasks(
      _runningTasks.where((notif) => !notif.isSameId(taskId)),
    );

    if (task != null) {
      _doneTasksStreamController.add(
        task.copyWith(
          result: Result.failure(failure),
          dateTask: DateTime.now(),
        ),
      );
    }
  }

  void succeed(String taskId, TaskDataT data) {
    log('Task Succeed $taskId');
    final task = _findRunningTask(taskId);

    _updateRunningTasks(
      _runningTasks.where((notif) => !notif.isSameId(taskId)),
    );

    if (task != null) {
      _doneTasksStreamController.add(
        task.copyWith(
          result: const Result.success(null),
          data: data,
          dateTask: DateTime.now(),
        ),
      );
    }
  }

  void _updateRunningTasks(
    Iterable<Task<TaskDataT, TaskFailureT>> notifications,
  ) {
    _runningTasks = notifications;
    _runningTasksStreamController.add(_runningTasks);
  }

  Task<TaskDataT, TaskFailureT>? _findRunningTask(String id) =>
      _runningTasks.firstWhereOrNull((task) => task.isSameId(id));

  bool _containsId(String id) => _runningTasks.any(
        (task) => task.isSameId(id),
      );
}
