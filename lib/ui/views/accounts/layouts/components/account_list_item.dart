/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/service_type_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item_token_info.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
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
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok') {
        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalizations.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      icon: Symbols.info,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
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
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
    );
    await ref.read(SessionProviders.session.notifier).refresh();
    await ref
        .read(AccountProviders.selectedAccount.notifier)
        .refreshRecentTransactions();

    if (mounted) {
      Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
    }
  }

  void _showSendFailed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) {
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
    Navigator.of(context).pop();
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

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
              ShowSendingAnimation.build(context, theme);
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
            Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
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

                Sheets.showAppHeightNineSheet(
                  context: context,
                  ref: ref,
                  widget: ContactDetail(
                    contact: data.value!,
                  ),
                );
              },
              error: (_) {},
              loading: (_) {},
            );
          }
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.backgroundAccountsListCardSelected!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: widget.account.serviceType == 'archethicWallet'
              ? theme.backgroundAccountsListCardSelected
              : Colors.transparent,
          child: Container(
            height: 100,
            color: widget.account.selected!
                ? theme.backgroundAccountsListCardSelected
                : theme.backgroundAccountsListCard,
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
                          style: theme.textStyleSize12W400Primary,
                        ),
                      ),
                      if (widget.account.serviceType != null)
                        Row(
                          children: [
                            Icon(
                              ServiceTypeFormatters(widget.account.serviceType!)
                                  .getIcon(),
                              size: 15,
                            ),
                            const SizedBox(width: 3),
                            AutoSizeText(
                              ServiceTypeFormatters(widget.account.serviceType!)
                                  .getLabel(context),
                              style: theme.textStyleSize12W400Primary,
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
                                color: theme.backgroundDark!.withOpacity(0.3),
                                border: Border.all(
                                  color:
                                      theme.backgroundDarkest!.withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Symbols.open_in_new,
                                color: theme.backgroundDarkest,
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
                                color: theme.backgroundDark!.withOpacity(0.3),
                                border: Border.all(
                                  color:
                                      theme.backgroundDarkest!.withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Symbols.delete,
                                color: theme.backgroundDarkest,
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
                                  theme.text!,
                                  theme.snackBarShadow!,
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
                                      theme,
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
                                  '${widget.account.balance!.nativeTokenValueToString(digits: 2)} ${widget.account.balance!.nativeTokenName}',
                                  style: theme.textStyleSize12W400Primary,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(
                                height: 17,
                                child: AutoSizeText(
                                  fiatAmountString,
                                  textAlign: TextAlign.end,
                                  style: theme.textStyleSize12W400Primary,
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
                                style: theme.textStyleSize12W400Primary,
                              ),
                              AutoSizeText(
                                '${widget.account.balance!.nativeTokenValueToString(digits: 2)} ${widget.account.balance!.nativeTokenName}',
                                style: theme.textStyleSize12W400Primary,
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
                          style: theme.textStyleSize12W600Primary60,
                        ),
                        AutoSizeText(
                          '···········',
                          style: theme.textStyleSize12W600Primary60,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        if (widget.account.serviceType != 'aeweb')
                          AutoSizeText(
                            '···········',
                            style: theme.textStyleSize12W600Primary60,
                          ),
                        if (widget.account.serviceType != 'aeweb')
                          AutoSizeText(
                            '···········',
                            style: theme.textStyleSize12W600Primary60,
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
