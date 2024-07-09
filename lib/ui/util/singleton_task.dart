import 'dart:async';

import 'package:logging/logging.dart';

class SingletonTask<T> {
  SingletonTask({
    required this.name,
    required this.task,
  }) {
    this._logger = Logger(name);
  }

  Completer<T>? _completer;
  final String name;
  final Future<T> Function() task;

  late final Logger _logger;

  Future<T> run() async {
    if (_completer != null) {
      _logger.info('Already running. Waiting for result...');
      return _completer!.future;
    }

    _completer = Completer<T>();
    unawaited(
      Future.sync(() async {
        try {
          _logger.info('Starting');

          _completer?.complete(await task());
          _logger.info('Done');
        } catch (e) {
          _completer?.completeError(e);
          _logger.info('Failed');
        } finally {
          _completer = null;
        }
      }),
    );

    return _completer!.future;
  }
}
