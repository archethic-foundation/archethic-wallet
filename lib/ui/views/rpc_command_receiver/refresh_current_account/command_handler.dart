import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/blog.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/refresh_current_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshCurrentAccountHandler extends CommandHandler {
  RefreshCurrentAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCRefreshCurrentAccountCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCRefreshCurrentAccountCommandData>;

            final _connectivityStatusProvider =
                ref.read(connectivityStatusProviders);
            if (_connectivityStatusProvider ==
                ConnectivityStatus.isDisconnected) {
              return Result.failure(
                RPCFailure.disconnected(),
              );
            }

            await ref
                .read(AccountProviders.selectedAccount.notifier)
                .refreshRecentTransactions();
            ref
              ..invalidate(BlogProviders.fetchArticles)
              ..invalidate(ContactProviders.fetchContacts)
              ..invalidate(MarketPriceProviders.currencyMarketPrice);

            return const Result.success(null);
          },
        );
}
