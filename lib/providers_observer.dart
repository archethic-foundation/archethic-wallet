import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.name != null) {
      log('didAddProvider($value)', name: '${provider.name}');
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider.name != null) {
      log('didUpdateProvider($newValue)', name: '${provider.name}');
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (provider.name != null) {
      log('providerDidFail($error)', name: '${provider.name}');
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    if (provider.name != null) {
      log('didDisposeProvider', name: '${provider.name}');
    }
  }
}
