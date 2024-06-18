import 'dart:async';
import 'dart:collection';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:collection/collection.dart';

/// [CommandDispatcher] is a [Command] queue.
/// Queue can be consumed by many handlers. When a command
/// comes in, it is processed by the first handler which
/// accepts it. (see [CommandHandler.canHandle])
///
/// [Command]s are read and processed sequentially one by one.
/// Processing result is returned to the [Command] emitter.
///
/// This mechanism is used to make RPC context communicate with the UI :
///  - RPC receives a DApp request.
///  - RPC pushes a [Command].
///  - UI consumes the [Command]
///     => it might display a confirmation popup.
///     => eventually command is processed, and result is returned to the [CommandDispatcher]
///  - RPC receives the [Command] result. It returns it to the DApp.
///
class Command<CommandDataT, SuccessDataT> {
  Command(
    this.completer,
    this.command,
  );

  final Completer<Result<SuccessDataT, awc.Failure>> completer;
  final CommandDataT command;
}

class CommandHandler<CommandDataT, SuccessDataT> {
  const CommandHandler({
    required this.handle,
    required this.canHandle,
  });

  final Future<Result<SuccessDataT, awc.Failure>> Function(
    dynamic command,
  ) handle;

  final bool Function(dynamic commandData) canHandle;
}

// Executed before Handlers.
// If an [awc.Failure] is returned, processing stops here.
typedef CommandGuard<CommandDataT> = FutureOr<awc.Failure?> Function(
  CommandDataT command,
);

class CommandDispatcher {
  final _waitingCommands = Queue<Command>();

  // ignore: prefer_collection_literals
  final _guards = <CommandGuard>[];

  // ignore: prefer_collection_literals
  final _handlers = <CommandHandler>[];

  /// Clears all Handlers and Guards.
  void clear() {
    _handlers.clear();
    _guards.clear();
  }

  /// Add a guard.
  /// [CommandGuard]s are executed before processing any command. If the guard's
  /// result is an [awc.Failure], then processing stops returning that failure.
  void addGuard(CommandGuard guard) {
    _guards.add(guard);
  }

  /// Add a [CommandHandler].
  void addHandler<CommandDataT, SuccessDataT>(
    CommandHandler<CommandDataT, SuccessDataT> commandHandler,
  ) {
    _handlers.add(commandHandler);

    if (_handlers.length == 1) {
      unawaited(_process());
    }
  }

  Future<Result<SuccessDataT, awc.Failure>> add<CommandDataT, SuccessDataT>(
    CommandDataT command,
  ) async {
    final completer = Completer<Result<SuccessDataT, awc.Failure>>();
    _waitingCommands.add(
      Command<CommandDataT, SuccessDataT>(
        completer,
        command,
      ),
    );
    unawaited(_process());

    return completer.future;
  }

  CommandHandler<CommandDataT, SuccessDataT>?
      _findHandler<CommandDataT, SuccessDataT>(
    Command<CommandDataT, SuccessDataT> command,
  ) {
    return _handlers
        .whereType<CommandHandler<CommandDataT, SuccessDataT>>()
        .firstWhereOrNull(
      (handler) {
        return handler.canHandle(command.command);
      },
    );
  }

  Future<awc.Failure?> _guard<CommandDataT>(CommandDataT command) async {
    for (final guard in _guards) {
      final failure = await guard(command);
      if (failure != null) return failure;
    }
    return null;
  }

  Future<void> _process() async {
    if (_handlers.isEmpty) return;
    if (_waitingCommands.isEmpty) return;

    final command = _waitingCommands.removeFirst();
    final handler = _findHandler(command);

    if (handler == null) {
      command.completer.complete(
        const Result.failure(
          awc.Failure.unsupportedMethod,
        ),
      );
      return;
    }

    final guardFailure = await _guard(command.command);
    if (guardFailure != null) {
      command.completer.complete(Result.failure(guardFailure));
      return;
    }

    handler
        .handle(command.command)
        .then(
          command.completer.complete,
          onError: (error) => command.completer.complete(Result.failure(error)),
        )
        .whenComplete(_process);
  }
}
