/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/service_type_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item_token_info.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountListItem extends ConsumerStatefulWidget {
  const AccountListItem({
    super.key,
    required this.account,
  });
  final Account account;

  @override
  ConsumerState<AccountListItem> createState() => _AccountListItemState();
}

class _AccountListItemState extends ConsumerState<AccountListItem> {
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event);
        return;
      }

      if (event.response == 'ok') {
        await _showSendSucceed(event);
        return;
      }

      _showNotEnoughConfirmation();
    });
  }

  void _showNotEnoughConfirmation() {
    UIUtil.showSnackbar(
      AppLocalizations.of(context)!.notEnoughConfirmations,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      icon: Symbols.info,
    );
    context.pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
  ) async {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalizations.of(context)!
              .retireAccountConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalizations.of(context)!
              .retireAccountConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
    );
    await ref.read(SessionProviders.session.notifier).refresh();
    await ref
        .read(AccountProviders.selectedAccount.notifier)
        .refreshRecentTransactions();

    if (mounted) {
      context.go(HomePage.routerPage);
    }
  }

  void _showSendFailed(
    TransactionSendEvent event,
  ) {
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(seconds: 5),
    );
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
  }

  @override
  void dispose() {
    _sendTxSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;

    final settings = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final language = ref.watch(
      LanguageProviders.selectedLanguage,
    );

    AsyncValue<Contact?>? contact;
    if (widget.account.serviceType == 'archethicWallet') {
      contact = ref.watch(
        ContactProviders.getContactWithName(
          Uri.encodeFull(widget.account.nameDisplayed),
        ),
      );
    }

    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final asyncFiatAmount = ref.watch(
      MarketPriceProviders.convertedToSelectedCurrency(
        nativeAmount: widget.account.balance?.nativeTokenValue ?? 0,
      ),
    );
    final fiatAmountString = asyncFiatAmount.maybeWhen(
      data: (fiatAmount) => CurrencyUtil.format(
        settings.currency.name,
        fiatAmount,
      ),
      orElse: () => '--',
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {
          if (widget.account.serviceType == 'archethicWallet') {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  ref.read(
                    SettingsProviders.settings.select(
                      (value) => value.activeVibrations,
                    ),
                  ),
                );

            if (selectedAccount == null ||
                selectedAccount.nameDisplayed != widget.account.nameDisplayed) {
              ShowSendingAnimation.build(context);
              await ref
                  .read(AccountProviders.accounts.notifier)
                  .selectAccount(widget.account);
              await ref
                  .read(
                    AccountProviders.account(widget.account.name).notifier,
                  )
                  .refreshRecentTransactions();
            }

            await ref
                .read(SettingsProviders.settings.notifier)
                .resetMainScreenCurrentPage();
            context.go(HomePage.routerPage);
            ref.read(mainTabControllerProvider)!.animateTo(
                  ref.read(SettingsProviders.settings).mainScreenCurrentPage,
                  duration: Duration.zero,
                );
          }
        },
        onLongPress: () {
          if (widget.account.serviceType != 'other') {
            return contact!.map(
              data: (data) {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      settings.activeVibrations,
                    );
                context.push(
                  ContactDetail.routerPage,
                  extra: ContactDetailsRouteParams(
                    contactAddress: data.value!.genesisAddress!,
                  ).toJson(),
                );
              },
              error: (_) {},
              loading: (_) {},
            );
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.sheetBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: aedappfm.AppThemeBase.sheetBorder,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.account.selected!
                  ? ArchethicTheme.backgroundAccountsListCardSelected
                  : ArchethicTheme.backgroundAccountsListCard,
            ),
            height: 100,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 17,
                        child: AutoSizeText(
                          widget.account.nameDisplayed,
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary,
                        ),
                      ),
                      if (widget.account.serviceType != null)
                        Row(
                          children: [
                            Icon(
                              ServiceTypeFormatters(
                                widget.account.serviceType!,
                              ).getIcon(),
                              size: 15,
                            ),
                            const SizedBox(width: 3),
                            AutoSizeText(
                              ServiceTypeFormatters(widget.account.serviceType!)
                                  .getLabel(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ArchethicTheme.backgroundDark
                                    .withOpacity(0.3),
                                border: Border.all(
                                  color: ArchethicTheme.backgroundDarkest
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Symbols.open_in_new,
                                color: ArchethicTheme.backgroundDarkest,
                                size: 20,
                              ),
                            ),
                            onTap: () async {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    preferences.activeVibrations,
                                  );
                              UIUtil.showWebview(
                                context,
                                '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${widget.account.lastAddress}',
                                '',
                              );
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ArchethicTheme.backgroundDark
                                    .withOpacity(0.3),
                                border: Border.all(
                                  color: ArchethicTheme.backgroundDarkest
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Symbols.delete,
                                color: ArchethicTheme.backgroundDarkest,
                                size: 20,
                              ),
                            ),
                            onTap: () async {
                              final session =
                                  ref.read(SessionProviders.session).loggedIn;
                              final keychain = await sl
                                  .get<ApiService>()
                                  .getKeychain(session!.wallet.seed);

                              var nbOfAccounts = 0;
                              keychain.services.forEach((key, value) {
                                if (key.startsWith('archethic-wallet')) {
                                  nbOfAccounts++;
                                }
                              });
                              if (nbOfAccounts <= 1 &&
                                  widget.account.name
                                      .startsWith('archethic-wallet')) {
                                UIUtil.showSnackbar(
                                  AppLocalizations.of(context)!
                                      .removeKeychainAtLeast1,
                                  context,
                                  ref,
                                  ArchethicTheme.text,
                                  ArchethicTheme.snackBarShadow,
                                  icon: Symbols.info,
                                );
                                return;
                              }

                              final language = ref.read(
                                LanguageProviders.selectedLanguage,
                              );

                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    preferences.activeVibrations,
                                  );
                              AppDialogs.showConfirmDialog(
                                  context,
                                  ref,
                                  CaseChange.toUpperCase(
                                    localizations.warning,
                                    language.getLocaleString(),
                                  ),
                                  localizations.removeKeychainDetail.replaceAll(
                                    '%1',
                                    widget.account.nameDisplayed,
                                  ),
                                  localizations.removeKeychainAction, () {
                                // Show another confirm dialog
                                AppDialogs.showConfirmDialog(
                                  context,
                                  ref,
                                  localizations.areYouSure,
                                  localizations.removeKeychainLater,
                                  localizations.yes,
                                  () async {
                                    ShowSendingAnimation.build(
                                      context,
                                    );

                                    await KeychainUtil().removeService(
                                      ref
                                          .read(SettingsProviders.settings)
                                          .network,
                                      widget.account.name,
                                      keychain,
                                    );
                                  },
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.account.serviceType != 'aeweb')
                  if (settings.showBalances)
                    primaryCurrency.primaryCurrency ==
                            AvailablePrimaryCurrencyEnum.native
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 17,
                                child: AutoSizeText(
                                  '${widget.account.balance!.nativeTokenValueToString(language.getLocaleStringWithoutDefault(), digits: widget.account.balance!.nativeTokenValue < 1 ? 8 : 2)} ${widget.account.balance!.nativeTokenName}',
                                  style: ArchethicThemeStyles
                                      .textStyleSize12W100Primary,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(
                                height: 17,
                                child: AutoSizeText(
                                  fiatAmountString,
                                  textAlign: TextAlign.end,
                                  style: ArchethicThemeStyles
                                      .textStyleSize12W100Primary,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              AccountListItemTokenInfo(account: widget.account),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                fiatAmountString,
                                textAlign: TextAlign.end,
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                              ),
                              AutoSizeText(
                                '${widget.account.balance!.nativeTokenValueToString(language.getLocaleStringWithoutDefault(), digits: widget.account.balance!.nativeTokenValue < 1 ? 8 : 2)} ${widget.account.balance!.nativeTokenName}',
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              AccountListItemTokenInfo(account: widget.account),
                            ],
                          )
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          '···········',
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary60,
                        ),
                        AutoSizeText(
                          '···········',
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary60,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        if (widget.account.serviceType != 'aeweb')
                          AutoSizeText(
                            '···········',
                            style: ArchethicThemeStyles
                                .textStyleSize12W100Primary60,
                          ),
                        if (widget.account.serviceType != 'aeweb')
                          AutoSizeText(
                            '···········',
                            style: ArchethicThemeStyles
                                .textStyleSize12W100Primary60,
                          ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
