import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension WidgetRefExt on WidgetRef {
  Future<void> waitUntil<T>(
    ProviderListenable<T> provider,
    bool Function(T? previous, T next) predicate,
  ) async {
    if (predicate(null, read(provider))) return;
    log('start', name: 'WaitUntilProvider ${provider.runtimeType}');
    final waitCompleter = Completer();
    ProviderSubscription? subscription;

    subscription = listenManual(
      provider,
      (previous, next) {
        if (!predicate(previous, next)) return;

        subscription?.close();
        waitCompleter.complete();
        log(
          'predicate verified',
          name: 'WaitUntilProvider ${provider.runtimeType}',
        );
      },
      onError: (error, stackTrace) {
        subscription?.close();
        waitCompleter.completeError(error, stackTrace);
        log('canceled', name: 'WaitUntilProvider ${provider.runtimeType}');
      },
    );

    return waitCompleter.future;
  }

  /// Creates a Stream containing the Provider values.
  /// Stream is initialized with the last Provider value.
  /// Then, every Provider update is added to the stream.
  /// When Stream is not listened anymore, Provider is not watched anymore.
  Stream<T> streamWithCurrentValue<T>(
    AutoDisposeStreamProvider<T> provider,
  ) async* {
    yield await read(provider.future);

    ProviderSubscription<AsyncValue<T>>? subscription;
    final streamController = StreamController<T>(
      onCancel: () {
        subscription?.close();
      },
    );

    subscription = listenManual(
      provider,
      (previous, next) {
        final value = next.valueOrNull;
        if (value == null) return;
        streamController.add(value);
      },
    );

    yield* streamController.stream;
  }
}
