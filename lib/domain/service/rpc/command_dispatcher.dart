import 'dart:async';
import 'dart:collection';

/// [CommandDispatcher] is a [Command] queue.
/// Queue can be consumed by one handler.
///
/// The handler reads and processes [Command]s one by one.
/// Processing result is returned to the [Command] emitter.
///
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

typedef CommandHandler<C, R> = Future<R> Function(C);

class CommandDispatcher<C, R> {
  CommandHandler<C, R>? _handler;
  final _waitingCommands = Queue<Command>();

  set handler(CommandHandler<C, R>? handler) {
    _handler = handler;
    unawaited(_process());
  }

  CommandHandler<C, R>? get handler => _handler;

  Future<R> add(C command) async {
    final completer = Completer<R>();
    _waitingCommands.add(
      Command(
        completer,
        command,
      ),
    );
    unawaited(_process());

    return completer.future;
  }

  Future<void> _process() async {
    if (_handler == null) return;
    if (_waitingCommands.isEmpty) return;

    final command = _waitingCommands.first;
    _waitingCommands.removeFirst();
    _handler!(command.command)
        .then(
          command.completer.complete,
          onError: command.completer.completeError,
        )
        .whenComplete(_process);
  }
}
