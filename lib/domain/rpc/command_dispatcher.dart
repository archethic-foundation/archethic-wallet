import 'dart:async';
import 'dart:collection';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
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
class Command<C> {
  Command(
    this.completer,
    this.command,
  );

  final Completer completer;
  final C command;
}

class CommandHandler<C, S> {
  const CommandHandler({
    required this.handle,
    required this.canHandle,
  });

  final Future<Result<S, RPCFailure>> Function(C command) handle;

  final bool Function(dynamic commandData) canHandle;
}

// Executed before Handlers.
// If an [RPCFailure] is returned, processing stops here.
typedef CommandGuard<C> = FutureOr<RPCFailure?> Function(C command);

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
  /// result is an [RPCFailure], then processing stops returning that failure.
  void addGuard(CommandGuard guard) {
    _guards.add(guard);
  }

  /// Add a [CommandHandler].
  void addHandler(
    CommandHandler commandHandler,
  ) {
    _handlers.add(commandHandler);

    if (_handlers.length == 1) {
      unawaited(_process());
    }
  }

  Future<Result<S, RPCFailure>> add<C, S>(
    C command,
  ) async {
    final completer = Completer<Result<S, RPCFailure>>();
    _waitingCommands.add(
      Command(
        completer,
        command,
      ),
    );
    unawaited(_process());

    return completer.future;
  }

  CommandHandler? _findHandler<C, S>(
    C commandData,
  ) {
    return _handlers.firstWhereOrNull(
      (handler) {
        return handler.canHandle(commandData);
      },
    );
  }

  Future<RPCFailure?> _guard<C>(C command) async {
    for (final guard in _guards) {
      final failure = await guard(command);
      if (failure != null) return failure;
    }
    return null;
  }

  Future<void> _process() async {
    if (_handlers.isEmpty) return;
    if (_waitingCommands.isEmpty) return;

    final command = _waitingCommands.first;
    _waitingCommands.removeFirst();
    final handler = _findHandler(command.command);

    if (handler == null) {
      command.completer.completeError(
        RPCFailure.unsupportedMethod(),
      );
      return;
    }

    final guardFailure = await _guard(command.command);
    if (guardFailure != null) {
      command.completer.completeError(guardFailure);
      return;
    }

    await handler
        .handle(command.command)
        .then(
          command.completer.complete,
          onError: command.completer.completeError,
        )
        .whenComplete(_process);
  }
}
