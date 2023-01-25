import 'dart:async';
import 'dart:collection';

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
