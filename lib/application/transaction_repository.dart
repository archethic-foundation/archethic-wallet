import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

@Riverpod(keepAlive: true)
ArchethicTransactionRepository archethicTransactionRepository(
    ArchethicTransactionRepositoryRef ref,) {
  final networkSettings = ref.watch(
    SettingsProviders.settings.select((settings) => settings.network),
  );
  return ArchethicTransactionRepository(
    phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
    websocketEndpoint: networkSettings.getWebsocketUri(),
  );
}
