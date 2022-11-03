import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

/// Handles read strategies and persistent cache.
mixin ReadStrategy<CommandT, ValueT> {
  /// Reads data from local data source.
  Future<ValueT?> getLocal(CommandT command);

  /// Saves data to local data source.
  Future<void> saveLocal(CommandT command, ValueT value);

  /// Reads data from remote data source.
  Future<ValueT?> getRemote(CommandT command);

  Future<Result<ValueT, Failure>> _getFromRemoteFirst(CommandT command) async {
    try {
      final remoteValue = await getRemote(command);

      if (remoteValue != null) {
        await saveLocal(command, remoteValue);
        return Result.success(remoteValue);
      }
    } catch (_) {
      // TODO(Chralu): Should we log network failure ?
    }

    try {
      final localValue = await getLocal(command);
      if (localValue != null) {
        return Result.success(localValue);
      }
    } catch (_) {
      // TODO(Chralu): Should we log local failure ?
    }

    return const Result.failure(
      Failure.other(
        cause: 'Unable to fetch local or remote value',
      ),
    );
  }

  Future<Result<ValueT, Failure>> _getFromLocalFirst(CommandT command) async {
    try {
      final localValue = await getLocal(command);
      if (localValue != null) return Result.success(localValue);
    } catch (_) {
      // TODO(Chralu): Should we log local failure ?
    }

    try {
      final remoteValue = await getRemote(command);
      if (remoteValue != null) {
        await saveLocal(command, remoteValue);
        return Result.success(remoteValue);
      }
    } catch (_) {
      // TODO(Chralu): Should we log remote failure ?
    }

    return const Result.failure(
      Failure.other(
        cause: 'Unable to fetch local or remote value',
      ),
    );
  }

  /// Creates a [UseCase] that reads data from remote data source.
  /// Remote data is then persisted in local cache.
  /// If remote read fails, tries to fetch local data.
  UseCase<CommandT, Result<ValueT, Failure>> get updateFromRemoteUseCase =>
      _GetFromRemoteFirstUseCase<CommandT, ValueT>(
        this,
      );

  /// Creates a [UseCase] that read data from local data source.
  /// If local data source has no data, fetches data from remote.
  UseCase<CommandT, Result<ValueT, Failure>> get readFromLocalFirstUseCase =>
      _GetFromLocalFirstUseCase<CommandT, ValueT>(
        this,
      );
}

class _GetFromLocalFirstUseCase<CommandT, ValueT>
    implements UseCase<CommandT, Result<ValueT, Failure>> {
  _GetFromLocalFirstUseCase(this.readStrategy);

  final ReadStrategy<CommandT, ValueT> readStrategy;

  @override
  Future<Result<ValueT, Failure>> run(CommandT command) =>
      readStrategy._getFromLocalFirst(command);
}

class _GetFromRemoteFirstUseCase<CommandT, ValueT>
    implements UseCase<CommandT, Result<ValueT, Failure>> {
  _GetFromRemoteFirstUseCase(this.readStrategy);

  final ReadStrategy<CommandT, ValueT> readStrategy;

  @override
  Future<Result<ValueT, Failure>> run(CommandT command) =>
      readStrategy._getFromRemoteFirst(command);
}
