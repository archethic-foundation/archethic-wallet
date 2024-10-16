import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.name != null) {
      Logger('${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())} ${provider.name!}${provider.argument != null ? ':${provider.argument}' : ''}')
          .info('didAddProvider($value)');
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
      Logger(provider.name!).info(
        '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())} didUpdateProvider($newValue)',
      );
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
      Logger(provider.name!).info(
        '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())} providerDidFail($error)',
      );
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    if (provider.name != null) {
      Logger(provider.name!).info(
        '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())} didDisposeProvider',
      );
    }
  }
}
