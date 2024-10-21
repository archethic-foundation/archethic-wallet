import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefListenSelectExtension<State extends Object?, T> on Ref<State> {
  void invalidateSelfOnPropertyChange(
    T? Function(State? state) select,
  ) {
    listenSelf((previous, next) {
      final previousValue = select(previous);
      final nextValue = select(next);

      if (previousValue == nextValue) return;
      invalidateSelf();
    });
  }
}

extension PeriodicReloadExtension on Ref<Object?> {
  /// Updates periodically the provider.
  void periodicReload(Duration duration) {
    final timer = Timer(
      duration,
      invalidateSelf,
    );
    onDispose(timer.cancel);
  }
}
