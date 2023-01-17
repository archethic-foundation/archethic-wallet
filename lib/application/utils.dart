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
}