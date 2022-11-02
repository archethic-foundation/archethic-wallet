import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

abstract class GetFromRemoteFirstStrategy<CommandT, ValueT>
    implements UseCase<CommandT, Result<ValueT, Failure>> {
  Future<ValueT?> getLocal(CommandT command);
  Future<void> saveLocal(CommandT command, ValueT value);
  Future<ValueT?> getRemote(CommandT command);

  @override
  Future<Result<ValueT, Failure>> run(CommandT command) async {
    final remoteValue = await getRemote(command);

    if (remoteValue == null) {
      // TODO(Chralu): Should we return a Failure.network here ?
      final localValue = await getLocal(command);
      if (localValue == null) {
        return const Result.failure(
          Failure.other(
            cause: 'Unable to fetch local or remote value',
          ),
        );
      }
      return Result.success(localValue);
    }

    return Result.guard(() async {
      await saveLocal(command, remoteValue);
      return remoteValue;
    });
  }
}
