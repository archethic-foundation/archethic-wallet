// TODO(Chralu): that kind of Provider should probably be factorized
// Create a CachedAsyncNotifier.
//    - localFetch method
//    - remoteFetch method
//    - builtin local then remote strategy

import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/transaction/get_recent_transactions.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/infrastructure/repositories/hive_transaction.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_transactions.g.dart';

@Riverpod(keepAlive: true)
TransactionRemoteRepositoryInterface _remoteRepository(
  _RemoteRepositoryRef ref,
) {
  final networkSettings = ref
      .watch(
        SettingsProviders.localSettingsRepository,
      )
      .getNetwork();
  return ArchethicTransactionRepository(
    phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
    websocketEndpoint: networkSettings.getWebsocketUri(),
  );
}

@Riverpod(keepAlive: true)
TransactionLocalRepositoryInterface _localRepository(
  _LocalRepositoryRef ref,
) =>
    HiveTransactionRepository();

@Riverpod(keepAlive: true)
class _RecentTransactionsNotifier
    extends AsyncNotifier<List<RecentTransaction>> {
  @override
  FutureOr<List<RecentTransaction>> build() async {
    final selectedAccount = ref.watch(AccountProviders.selectedAccount);
    if (selectedAccount == null) throw const Failure.loggedOut();

    final session = ref.watch(SessionProviders.session).loggedIn;
    if (session == null) throw const Failure.loggedOut();

    final result = await GetRecentTransactions(
      transactionRepository: ref.watch(
        RecentTransactionProviders.transactionRemoteRepository,
      ),
      accountLocalRepository: ref.watch(
        RecentTransactionProviders.transactionLocalRepository,
      ),
    ).run(
      GetRecentTransactionsCommand(
        account: selectedAccount,
        walletSeed: session.seed,
      ),
    );
    return result.map(
      success: (account) => account.recentTransactions,
      failure: (e) => throw e,
    );
  }
}

abstract class RecentTransactionProviders {
  static final transactionRemoteRepository = _remoteRepositoryProvider;
  static final transactionLocalRepository = _localRepositoryProvider;

  static final recentTransactions = _recentTransactionsNotifierProvider;
}
