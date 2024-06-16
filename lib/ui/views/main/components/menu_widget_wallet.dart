/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/refresh_in_progress.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/verified_tokens.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/action_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MenuWidgetWallet extends ConsumerWidget {
  const MenuWidgetWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.accounts,
        )
        .valueOrNull
        ?.selectedAccount;
    final preferences = ref.watch(SettingsProviders.settings);
    final contact = ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final refreshInProgress = ref.watch(refreshInProgressProviders);

    if (accountSelected == null) return const SizedBox();

    final localizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (accountSelected.balance!.isNativeTokenValuePositive() &&
                connectivityStatusProvider == ConnectivityStatus.isConnected)
              ActionButton(
                key: const Key('sendUCObutton'),
                text: localizations.send,
                icon: Symbols.call_made,
                onTap: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );

                  await const TransferSheet(
                    transferType: TransferType.uco,
                    recipient: TransferRecipient.address(
                      address: Address(address: ''),
                    ),
                  ).show(
                    context: context,
                    ref: ref,
                  );
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 200))
            else
              ActionButton(
                text: localizations.send,
                icon: Symbols.call_made,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 200)),
            if (contact != null)
              ActionButton(
                key: const Key('receiveUCObutton'),
                text: localizations.receive,
                icon: Symbols.call_received,
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  unawaited(
                    context.push(
                      ContactDetail.routerPage,
                      extra: ContactDetailsRouteParams(
                        contactAddress: contact.genesisAddress!,
                      ).toJson(),
                    ),
                  );
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250))
            else
              ActionButton(
                text: localizations.receive,
                icon: Symbols.call_received,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250)),
            if (connectivityStatusProvider == ConnectivityStatus.isConnected)
              ActionButton(
                text: localizations.buy,
                icon: Symbols.add,
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  context.go(BuySheet.routerPage);
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 300))
                  .scale(duration: const Duration(milliseconds: 300))
            else
              ActionButton(
                text: localizations.buy,
                icon: Symbols.add,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 300))
                  .scale(duration: const Duration(milliseconds: 300)),
            if (refreshInProgress == false)
              ActionButton(
                text: localizations.refresh,
                icon: Symbols.refresh,
                onTap: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  final _connectivityStatusProvider =
                      ref.read(connectivityStatusProviders);
                  if (_connectivityStatusProvider ==
                      ConnectivityStatus.isDisconnected) {
                    return;
                  }

                  await (await ref
                          .read(AccountProviders.accounts.notifier)
                          .selectedAccountNotifier)
                      ?.refreshRecentTransactions();

                  if (context.mounted) {
                    ref
                      ..invalidate(ContactProviders.fetchContacts)
                      ..invalidate(MarketPriceProviders.currencyMarketPrice);
                    await ref
                        .read(
                          VerifiedTokensProviders.verifiedTokens.notifier,
                        )
                        .init();
                  }
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 350))
                  .scale(duration: const Duration(milliseconds: 350))
            else
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Opacity(
                      opacity: 0.5,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                  ),
                  ActionButton(
                    text: localizations.refresh,
                    icon: Symbols.refresh,
                    enabled: false,
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 350))
                      .scale(duration: const Duration(milliseconds: 350)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
