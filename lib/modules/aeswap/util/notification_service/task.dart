part of 'task_notification_service.dart';

@freezed
class Task<DataT, FailureT extends Failure> with _$Task<DataT, FailureT> {
  const factory Task({
    required String id,
    required DataT data,
    DateTime? dateTask,
    Result<void, FailureT>? result,
  }) = _Task<DataT, FailureT>;
  const Task._();

  bool get isRunning => result == null;
  FailureT? get failure => result?.failureOrNull;

  bool isSameTask(Task task) => id == task.id;
  bool isSameId(String taskId) => id == taskId;
}
