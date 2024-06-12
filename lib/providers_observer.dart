import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.name != null) {
      Logger(provider.name!).info('didAddProvider($value)');
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
      Logger(provider.name!).info('didUpdateProvider($newValue)');
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
      Logger(provider.name!).info('providerDidFail($error)');
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    if (provider.name != null) {
      Logger(provider.name!).info('didDisposeProvider');
    }
  }
}
