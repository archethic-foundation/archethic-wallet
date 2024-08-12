import 'dart:async';
import 'dart:math';

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
    int chunkSize = 5,
    Duration taskMinDuration = const Duration(milliseconds: 100),
  }) async {
    final results = <T>[];
    final chunks = slices(chunkSize);
    for (final chunk in chunks) {
      results.addAll(
        await Future.wait(
          chunk.map((task) => task.minDuration(taskMinDuration).action()),
        ),
      );
    }
    return results;
  }
}

/// Default retry delay computation function.
/// Delay will increase at each retry : 2s, 5s, 10s ...
int _taskDefaultRetryDelay(int retryCount) =>
    (3 * pow(retryCount, 1.5)).round();

extension TaskRetry<T> on Task<T> {
  /// Ensures the [Task] wont be quicker than [minDuration]
  /// This is helpful to prevent backend spam detection
  Task<T> minDuration(Duration minDuration) => Task(
        name: name,
        logger: _logger,
        action: () async {
          final result = await Future.wait([
            Future.delayed(minDuration),
            action(),
          ]);
          return result[1];
        },
      );

  /// Makes the [Task] to retry if it fails.
  Task<T> autoRetry({
    int maxRetries = 3,
    int Function(int retryCount) retryDelay = _taskDefaultRetryDelay,
  }) =>
      Task(
        name: name,
        logger: _logger,
        action: () async {
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
                final delay = Duration(seconds: retryDelay(retryCount));
                _logger.warning(
                  'Retry $name in $delay',
                );

                await Future.delayed(delay);
              } else {
                _logger.severe(
                  'Max retries reached for $name',
                );
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
