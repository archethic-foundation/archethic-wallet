/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/refresh_in_progress.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/verified_tokens.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/dex_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
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
          AccountProviders.selectedAccount,
        )
        .valueOrNull;
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
              _ActionButton(
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
              _ActionButton(
                text: localizations.send,
                icon: Symbols.call_made,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 200)),
            if (contact != null)
              _ActionButton(
                key: const Key('receiveUCObutton'),
                text: localizations.receive,
                icon: Symbols.call_received,
                onTap: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  context.push(
                    ContactDetail.routerPage,
                    extra: ContactDetailsRouteParams(
                      contactAddress: contact.genesisAddress!,
                    ).toJson(),
                  );
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250))
            else
              _ActionButton(
                text: localizations.receive,
                icon: Symbols.call_received,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250)),
            if (connectivityStatusProvider == ConnectivityStatus.isConnected)
              _ActionButton(
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
              _ActionButton(
                text: localizations.buy,
                icon: Symbols.add,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 300))
                  .scale(duration: const Duration(milliseconds: 300)),
            if (refreshInProgress == false)
              _ActionButton(
                text: localizations.refresh,
                icon: Symbols.refresh,
                onTap: () async {
                  ref
                      .read(refreshInProgressProviders.notifier)
                      .setRefreshInProgress(true);

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

                  await ref
                      .read(AccountProviders.selectedAccount.notifier)
                      .refreshRecentTransactions();
                  ref
                    ..invalidate(ContactProviders.fetchContacts)
                    ..invalidate(MarketPriceProviders.currencyMarketPrice);
                  await ref
                      .read(
                        VerifiedTokensProviders.verifiedTokens.notifier,
                      )
                      .init();
                  ref
                      .read(refreshInProgressProviders.notifier)
                      .setRefreshInProgress(false);
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
                  _ActionButton(
                    text: localizations.refresh,
                    icon: Symbols.refresh,
                    enabled: false,
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 350))
                      .scale(duration: const Duration(milliseconds: 350)),
                ],
              ),
            // TODO(redDwarf03): WebView POC - To remove
            if (DEXSheet.isAvailable)
              _ActionButton(
                text: 'DEX',
                icon: Symbols.wallet,
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  context.push(DEXSheet.routerPage);
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 400))
                  .scale(duration: const Duration(milliseconds: 400))
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    this.onTap,
    required this.text,
    required this.icon,
    this.enabled = true,
    super.key,
  });

  final VoidCallback? onTap;
  final String text;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              child: Column(
                children: <Widget>[
                  ShaderMask(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        icon,
                        weight: 800,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                        color: enabled
                            ? Colors.white
                            : ArchethicTheme.text.withOpacity(0.3),
                        size: 38,
                      ),
                    ),
                    shaderCallback: (Rect bounds) {
                      const rect = Rect.fromLTRB(0, 0, 40, 40);
                      return ArchethicTheme.gradient.createShader(rect);
                    },
                  ),
                  const SizedBox(height: 5),
                  if (enabled)
                    Text(
                      text,
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                    )
                  else
                    Text(
                      text,
                      style: ArchethicThemeStyles
                          .textStyleSize14W600PrimaryDisabled,
                    ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                ShaderMask(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      icon,
                      color: enabled
                          ? Colors.white
                          : ArchethicTheme.text.withOpacity(0.3),
                      size: 38,
                    ),
                  ),
                  shaderCallback: (Rect bounds) {
                    const rect = Rect.fromLTRB(0, 0, 40, 40);
                    return ArchethicTheme.gradient.createShader(rect);
                  },
                ),
                const SizedBox(height: 5),
                if (enabled)
                  Text(
                    text,
                    style: ArchethicThemeStyles.textStyleSize14W600Primary,
                  )
                else
                  Text(
                    text,
                    style:
                        ArchethicThemeStyles.textStyleSize14W600PrimaryDisabled,
                  ),
              ],
            ),
    );
  }
}
