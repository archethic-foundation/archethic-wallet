import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

class Task<T> {
  Task({
    required this.name,
    Logger? logger,
    required this.action,
  }) : _logger = logger ?? Logger.root;

  final Logger _logger;
  final String name;
  final Future<T> Function() action;
}

extension TaskBatch<T> on Iterable<Task<T>> {
  Future<List<T>> batch({
    int chunkSize = 10,
    Duration restDuration = const Duration(seconds: 1),
  }) async {
    final results = <T>[];
    final chunks = slices(chunkSize);
    for (final chunk in chunks) {
      results.addAll(await Future.wait(chunk.map((task) => task.action())));
    }
    return results;
  }
}

extension TaskRetry<T> on Task<T> {
  Task<T> autoRetry() => Task(
        name: name,
        logger: _logger,
        action: () async {
          const maxRetries = 3;
          const delaySeconds = 5;

          var retryCount = 0;
          while (retryCount < maxRetries) {
            try {
              _logger.info(
                'Call $name',
              );

              return await action();
            } catch (e) {
              if (e is ArchethicTooManyRequestsException) {
                retryCount++;
                _logger.info(
                  'Retry $name',
                );

                await Future.delayed(const Duration(seconds: delaySeconds));
              } else {
                rethrow;
              }
            }
          }

          _logger.info('${DateTime.now()} Max retries exceeded $this');
          throw Exception('Max retries exceeded');
        },
      );
}

extension TasksRetry<T> on Iterable<Task<T>> {
  Iterable<Task<T>> autoRetry() {
    return map((task) => task.autoRetry());
  }
}
