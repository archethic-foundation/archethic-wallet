// Flutter imports:
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountsListWidget extends ConsumerStatefulWidget {
  const AccountsListWidget({super.key, this.currencyName, this.appWallet});
  final String? currencyName;
  final AppWallet? appWallet;

  @override
  ConsumerState<AccountsListWidget> createState() => _AccountsListWidgetState();
}

class _AccountsListWidgetState extends ConsumerState<AccountsListWidget> {
  static const int kMaxAccounts = 50;
  final GlobalKey expandedKey = GlobalKey();
  bool? isPressed;
  bool? animationOpen;
  AppWallet? appWalletLive;

  @override
  void initState() {
    super.initState();
    isPressed = false;
    animationOpen = false;
    appWalletLive = widget.appWallet;
    appWalletLive!.appKeychain!.accounts!.sort((a, b) => a.name!.compareTo(b.name!));
  }

  Future<void> _changeAccount(Account account, StateSetter setState) async {
    for (final a in appWalletLive!.appKeychain!.accounts!) {
      if (a.selected!) {
        setState(() {
          a.selected = false;
        });
      } else if (account.name == a.name) {
        setState(() {
          a.selected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);
    return Container(
      key: expandedKey,
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
          for (int i = 0; i < appWalletLive!.appKeychain!.accounts!.length; i++)
            _buildAccountListItem(
              context,
              appWalletLive!.appKeychain!.accounts![i],
              setState,
            ),
          Row(
            children: <Widget>[
              if (appWalletLive!.appKeychain!.accounts!.length >= kMaxAccounts)
                const SizedBox()
              else
                AppButton.buildAppButtonTiny(
                  const Key('addAccount'),
                  context,
                  ref,
                  AppButtonType.primary,
                  localizations.addAccount,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    final nameFocusNode = FocusNode();
                    final nameController = TextEditingController();
                    String? nameError;
                    await showDialog(
                      context: expandedKey.currentContext!,
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
                                      AppButton.buildAppButtonTiny(
                                        const Key('addName'),
                                        context,
                                        ref,
                                        isPressed == false ? AppButtonType.primary : AppButtonType.primaryOutline,
                                        localizations.ok,
                                        Dimens.buttonBottomDimens,
                                        onPressed: () async {
                                          if (isPressed == true) {
                                            return;
                                          }
                                          nameError = '';
                                          if (nameController.text.isEmpty) {
                                            setState(() {
                                              nameError = localizations.introNewWalletGetFirstInfosNameBlank;
                                              FocusScope.of(context).requestFocus(
                                                nameFocusNode,
                                              );
                                            });
                                          } else {
                                            var accountExists = false;
                                            for (final account in appWalletLive!.appKeychain!.accounts!) {
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
                                                localizations.addAccountConfirmation.replaceAll(
                                                  '%1',
                                                  nameController.text,
                                                ),
                                                localizations.yes,
                                                () async {
                                                  try {
                                                    await KeychainUtil().addAccountInKeyChain(
                                                      StateContainer.of(
                                                        context,
                                                      ).appWallet,
                                                      await StateContainer.of(
                                                        context,
                                                      ).getSeed(),
                                                      nameController.text,
                                                      StateContainer.of(
                                                        context,
                                                      ).curCurrency.currency.name,
                                                      StateContainer.of(
                                                        context,
                                                      ).curNetwork.getNetworkCryptoCurrencyLabel(),
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
                    setState(() {
                      appWalletLive!.appKeychain!.accounts!.sort((a, b) => a.name!.compareTo(b.name!));
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountListItem(
    BuildContext context,
    Account account,
    StateSetter setState,
  ) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26, bottom: 8),
      child: GestureDetector(
        onTap: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          _showSendingAnimation(context);
          if (!account.selected!) {
            _changeAccount(account, setState);
            StateContainer.of(context).appWallet = await sl.get<DBHelper>().changeAccount(account);
            await StateContainer.of(context).requestUpdate(forceUpdateChart: false);
          }
          StateContainer.of(context).bottomBarCurrentPage = 1;
          StateContainer.of(context)
              .bottomBarPageController!
              .jumpToPage(StateContainer.of(context).bottomBarCurrentPage);
          final preferences = await Preferences.getInstance();
          preferences.setMainScreenCurrentPage(
            StateContainer.of(context).bottomBarCurrentPage,
          );
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        },
        onLongPress: () {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: ReceiveSheet(address: account.lastAddress),
            onDisposed: () {
              setState(() {
                StateContainer.of(context).requestUpdate(forceUpdateChart: false);
              });
            },
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.backgroundAccountsListCardSelected!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: theme.backgroundAccountsListCardSelected,
          child: Container(
            height: 80,
            color: account.selected! ? theme.backgroundAccountsListCardSelected : theme.backgroundAccountsListCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                child: AutoSizeText(
                                                  account.name!,
                                                  style: theme.textStyleSize12W400Primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (StateContainer.of(context).showBalance)
                                          StateContainer.of(context).curPrimaryCurrency.primaryCurrency.name ==
                                                  const PrimaryCurrencySetting(
                                                    AvailablePrimaryCurrency.native,
                                                  ).primaryCurrency.name
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      AutoSizeText(
                                                        '${account.balance!.nativeTokenValueToString()} ${account.balance!.nativeTokenName!}',
                                                        style: theme.textStyleSize12W400Primary,
                                                      ),
                                                      AutoSizeText(
                                                        CurrencyUtil.getConvertedAmount(
                                                          StateContainer.of(
                                                            context,
                                                          ).curCurrency.currency.name,
                                                          account.balance!.fiatCurrencyValue!,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        style: theme.textStyleSize12W400Primary,
                                                      ),
                                                      if (account.accountTokens != null &&
                                                          account.accountTokens!.isNotEmpty)
                                                        AutoSizeText(
                                                          account.accountTokens!.length > 1
                                                              ? '${account.accountTokens!.length} ${localizations.tokens}'
                                                              : '${account.accountTokens!.length} ${localizations.token}',
                                                          style: theme.textStyleSize12W400Primary,
                                                        ),
                                                      if (account.accountNFT != null && account.accountNFT!.isNotEmpty)
                                                        AutoSizeText(
                                                          '${account.accountNFT!.length} ${localizations.nft}',
                                                          style: theme.textStyleSize12W400Primary,
                                                        ),
                                                    ],
                                                  ),
                                                )
                                              : Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      AutoSizeText(
                                                        CurrencyUtil.getConvertedAmount(
                                                          StateContainer.of(
                                                            context,
                                                          ).curCurrency.currency.name,
                                                          account.balance!.fiatCurrencyValue!,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        style: theme.textStyleSize12W400Primary,
                                                      ),
                                                      AutoSizeText(
                                                        '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                        style: theme.textStyleSize12W400Primary,
                                                      ),
                                                      if (account.accountTokens != null &&
                                                          account.accountTokens!.isNotEmpty)
                                                        AutoSizeText(
                                                          account.accountTokens!.length > 1
                                                              ? '${account.accountTokens!.length} ${localizations.tokens}'
                                                              : '${account.accountTokens!.length} ${localizations.token}',
                                                          style: theme.textStyleSize12W400Primary,
                                                        ),
                                                    ],
                                                  ),
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
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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

  void _showSendingAnimation(BuildContext context) {
    final theme = ref.watch(ThemeProviders.theme);
    animationOpen = true;
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        theme.animationOverlayStrong!,
        theme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false,
      ),
    );
  }
}
