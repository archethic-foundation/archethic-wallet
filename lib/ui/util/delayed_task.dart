import 'dart:async';

class CanceledTask implements Exception {
  const CanceledTask();
}

class CancelableTask<T> {
  CancelableTask({
    required this.task,
  });

  Completer<T>? _completer;
  bool _canceled = false;
  final Future<T> Function() task;

  Future<T> run() async {
    if (_canceled) {
      return Future.error(const CanceledTask());
    }

    if (_completer != null) {
      return _completer!.future;
    }

    _completer = Completer();
    unawaited(
      task().then((result) {
        if (_canceled) {
          _completer!.completeError(
            const CanceledTask(),
          );
          return;
        }
        _completer!.complete(result);
      }),
    );

    return _completer!.future;
  }

  Future<T> schedule(Duration delay) async => Future.delayed(
        delay,
        run,
      );

  void cancel() {
    _canceled = true;
  }
}
