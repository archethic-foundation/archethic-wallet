// Flutter imports:
// Project imports:
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountsListWidget extends ConsumerWidget {
  const AccountsListWidget({
    super.key,
    this.currencyName,
  });
  final String? currencyName;
  static const int kMaxAccounts = 50;

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accounts = ref.watch(AccountProviders.sortedAccounts).valueOrNull ??
        []; // TODO(Chralu): show a loading screen ?
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 50),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 20),
            child: Text(
              localizations.accountsListDescription,
              textAlign: TextAlign.justify,
              style: theme.textStyleSize12W400Primary,
            ),
          ),
          for (int i = 0; i < accounts.length; i++)
            _AccountListItem(
              account: accounts[i],
            ),
          if (accounts.length < kMaxAccounts)
            Row(
              children: const [
                _AddAccountButton(),
              ],
            ),
        ],
      ),
    );
  }
}

class _AddAccountButton extends ConsumerStatefulWidget {
  const _AddAccountButton();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AddAccountButtonState();
}

class __AddAccountButtonState extends ConsumerState<_AddAccountButton> {
  bool? isPressed = false;
  final GlobalKey expandedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accounts =
        ref.watch(AccountProviders.sortedAccounts).valueOrNull ?? [];

    return AppButtonTiny(
      AppButtonTinyType.primary,
      localizations.addAccount,
      Dimens.buttonBottomDimens,
      key: const Key('addAccount'),
      onPressed: () async {
        final nameFocusNode = FocusNode();
        final nameController = TextEditingController();
        String? nameError;
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          localizations.introNewWalletGetFirstInfosNameRequest,
                          style: theme.textStyleSize12W400Primary,
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    side: BorderSide(
                      color: theme.text45!,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AppTextField(
                            leftMargin: 0,
                            rightMargin: 0,
                            focusNode: nameFocusNode,
                            autocorrect: false,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            style: theme.textStyleSize12W600Primary,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                20,
                              ),
                              UpperCaseTextFormatter(),
                            ],
                          ),
                          if (nameError != null)
                            SizedBox(
                              height: 40,
                              child: Text(
                                nameError!,
                                style: theme.textStyleSize12W600Primary,
                              ),
                            )
                          else
                            const SizedBox(
                              height: 40,
                            ),
                          Text(
                            localizations.introNewWalletGetFirstInfosNameInfos,
                            style: theme.textStyleSize12W600Primary,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          AppButtonTiny(
                            isPressed == false
                                ? AppButtonTinyType.primary
                                : AppButtonTinyType.primaryOutline,
                            localizations.ok,
                            Dimens.buttonBottomDimens,
                            key: const Key('addName'),
                            onPressed: () async {
                              if (isPressed == true) {
                                return;
                              }
                              nameError = '';
                              if (nameController.text.isEmpty) {
                                setState(() {
                                  nameError = localizations
                                      .introNewWalletGetFirstInfosNameBlank;
                                  FocusScope.of(context).requestFocus(
                                    nameFocusNode,
                                  );
                                });
                              } else {
                                var accountExists = false;
                                for (final account in accounts) {
                                  if (account.name == nameController.text) {
                                    accountExists = true;
                                  }
                                }
                                if (accountExists == true) {
                                  setState(() {
                                    nameError = localizations.addAccountExists;
                                    FocusScope.of(context).requestFocus(
                                      nameFocusNode,
                                    );
                                  });
                                } else {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  AppDialogs.showConfirmDialog(
                                    context,
                                    ref,
                                    localizations.addAccount,
                                    localizations.addAccountConfirmation
                                        .replaceAll(
                                      '%1',
                                      nameController.text,
                                    ),
                                    localizations.yes,
                                    () async {
                                      try {
                                        await ref
                                            .read(
                                              AccountProviders
                                                  .accounts.notifier,
                                            )
                                            .addAccount(
                                              name: nameController.text,
                                            );
                                      } on ArchethicConnectionException {
                                        UIUtil.showSnackbar(
                                          localizations.noConnection,
                                          context,
                                          ref,
                                          theme.text!,
                                          theme.snackBarShadow!,
                                          duration: const Duration(
                                            seconds: 5,
                                          ),
                                        );
                                      } on Exception {
                                        UIUtil.showSnackbar(
                                          localizations.keychainNotExistWarning,
                                          context,
                                          ref,
                                          theme.text!,
                                          theme.snackBarShadow!,
                                          duration: const Duration(
                                            seconds: 5,
                                          ),
                                        );
                                      }

                                      setState(() {
                                        isPressed = false;
                                      });
                                      Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },
                                    cancelText: localizations.no,
                                    cancelAction: () {
                                      setState(() {
                                        isPressed = false;
                                      });
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _AccountListItem extends ConsumerWidget {
  const _AccountListItem({
    required this.account,
  });
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final contact = ref.watch(
      ContactProviders.getContactWithName(
        account.name,
      ),
    );

    final selectedAccount = ref.watch(AccountProviders.selectedAccount);

    return contact.map(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.only(left: 26, right: 26, bottom: 8),
          child: GestureDetector(
            onTap: () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    ref.read(
                      SettingsProviders.settings.select(
                        (value) => value.activeVibrations,
                      ),
                    ),
                  );
              ShowSendingAnimation.build(context, theme);
              if (!account.selected!) {
                await ref
                    .read(AccountProviders.accounts.notifier)
                    .selectAccount(account);
              }
              StateContainer.of(context).bottomBarCurrentPage = 1;
              StateContainer.of(context)
                  .bottomBarPageController!
                  .jumpToPage(StateContainer.of(context).bottomBarCurrentPage);
              final preferences_ = await Preferences.getInstance();
              preferences_.setMainScreenCurrentPage(
                StateContainer.of(context).bottomBarCurrentPage,
              );
              Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
            },
            onLongPress: () {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );

              Sheets.showAppHeightNineSheet(
                context: context,
                ref: ref,
                widget: ContactDetail(
                  contact: data.value,
                ),
                onDisposed: () {
                  ref
                      .read(AccountProviders.selectedAccount.notifier)
                      .refreshRecentTransactions(); // TODO(reddwarf03): Faudrait il recharger autre chose ?
                },
              );
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
              color: theme.backgroundAccountsListCardSelected,
              child: Container(
                height: 85,
                color: account.selected!
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
                      child: AutoSizeText(
                        account.name,
                        style: theme.textStyleSize12W400Primary,
                      ),
                    ),
                    if (preferences.showBalances)
                      primaryCurrency.primaryCurrency ==
                              AvailablePrimaryCurrencyEnum.native
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                AutoSizeText(
                                  '${account.balance!.nativeTokenValueToString()} ${account.balance!.nativeTokenName!}',
                                  style: theme.textStyleSize12W400Primary,
                                  textAlign: TextAlign.end,
                                ),
                                AutoSizeText(
                                  CurrencyUtil.getConvertedAmount(
                                    currency.currency.name,
                                    account.balance!.fiatCurrencyValue!,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: theme.textStyleSize12W400Primary,
                                ),
                                if (account.accountTokens != null &&
                                    account.accountTokens!.isNotEmpty)
                                  AutoSizeText(
                                    account.accountTokens!.length > 1
                                        ? '${account.accountTokens!.length} ${localizations.tokens}'
                                        : '${account.accountTokens!.length} ${localizations.token}',
                                    style: theme.textStyleSize12W400Primary,
                                    textAlign: TextAlign.end,
                                  ),
                                if (account.accountNFT != null &&
                                    account.accountNFT!.isNotEmpty)
                                  AutoSizeText(
                                    '${account.accountNFT!.length} ${localizations.nft}',
                                    style: theme.textStyleSize12W400Primary,
                                    textAlign: TextAlign.end,
                                  ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                AutoSizeText(
                                  CurrencyUtil.getConvertedAmount(
                                    currency.currency.name,
                                    account.balance!.fiatCurrencyValue!,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: theme.textStyleSize12W400Primary,
                                ),
                                AutoSizeText(
                                  '${account.balance!.nativeTokenValueToString()} ${selectedAccount!.balance!.nativeTokenName!}',
                                  style: theme.textStyleSize12W400Primary,
                                  textAlign: TextAlign.end,
                                ),
                                if (account.accountTokens != null &&
                                    account.accountTokens!.isNotEmpty)
                                  AutoSizeText(
                                    account.accountTokens!.length > 1
                                        ? '${account.accountTokens!.length} ${localizations.tokens}'
                                        : '${account.accountTokens!.length} ${localizations.token}',
                                    style: theme.textStyleSize12W400Primary,
                                    textAlign: TextAlign.end,
                                  ),
                                if (account.accountNFT != null &&
                                    account.accountNFT!.isNotEmpty)
                                  AutoSizeText(
                                    '${account.accountNFT!.length} ${localizations.nft}',
                                    style: theme.textStyleSize12W400Primary,
                                    textAlign: TextAlign.end,
                                  ),
                              ],
                            )
                    else
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AutoSizeText(
                              '···········',
                              textAlign: TextAlign.center,
                              style: theme.textStyleSize12W600Primary60,
                            ),
                            AutoSizeText(
                              '···········',
                              style: theme.textStyleSize12W600Primary60,
                            ),
                            AutoSizeText(
                              '···········',
                              style: theme.textStyleSize12W600Primary60,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error) => const SizedBox(),
      loading: (loading) => const SizedBox(),
    );
  }
}
