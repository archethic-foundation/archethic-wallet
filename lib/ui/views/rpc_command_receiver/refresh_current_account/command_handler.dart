import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshCurrentAccountHandler extends CommandHandler {
  RefreshCurrentAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.RefreshCurrentAccountRequest>,
          handle: (command) async {
            command as RPCCommand<awc.RefreshCurrentAccountRequest>;

            final _connectivityStatusProvider =
                ref.read(connectivityStatusProviders);
            if (_connectivityStatusProvider ==
                ConnectivityStatus.isDisconnected) {
              return const Result.failure(
                awc.Failure.connectivity,
              );
            }
            final poolListRaw =
                await ref.read(DexPoolProviders.getPoolListRaw.future);
            await (await ref
                    .read(AccountProviders.accounts.notifier)
                    .selectedAccountNotifier)
                ?.refreshRecentTransactions(poolListRaw);
            ref
              ..invalidate(ContactProviders.fetchContacts)
              ..invalidate(MarketPriceProviders.currencyMarketPrice);

            return const Result.success(awc.RefreshCurrentAccountResponse());
          },
        );
}
