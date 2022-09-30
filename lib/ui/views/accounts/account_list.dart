// Flutter imports:
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
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

class AccountsListWidget extends StatefulWidget {
  final String? currencyName;
  final AppWallet? appWallet;
  const AccountsListWidget({super.key, this.currencyName, this.appWallet});

  @override
  State<AccountsListWidget> createState() => _AccountsListWidgetState();
}

class _AccountsListWidgetState extends State<AccountsListWidget> {
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
    appWalletLive!.appKeychain!.accounts!
        .sort((a, b) => a.name!.compareTo(b.name!));
  }

  void _changeAccount(Account account, StateSetter setState) async {
    for (var a in appWalletLive!.appKeychain!.accounts!) {
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
    return Container(
      key: expandedKey,
      padding: const EdgeInsets.only(top: 40, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 20),
            child: Text(AppLocalization.of(context)!.accountsListDescription,
                textAlign: TextAlign.justify,
                style: AppStyles.textStyleSize12W400Primary(context)),
          ),
          for (int i = 0; i < appWalletLive!.appKeychain!.accounts!.length; i++)
            _buildAccountListItem(
                context, appWalletLive!.appKeychain!.accounts![i], setState),
          Row(
            children: <Widget>[
              appWalletLive!.appKeychain!.accounts!.length >= kMaxAccounts
                  ? const SizedBox()
                  : AppButton.buildAppButtonTiny(
                      const Key('addAccount'),
                      context,
                      AppButtonType.primary,
                      AppLocalization.of(context)!.addAccount,
                      Dimens.buttonBottomDimens,
                      onPressed: () async {
                        FocusNode nameFocusNode = FocusNode();
                        TextEditingController nameController =
                            TextEditingController();
                        String? nameError;
                        await showDialog(
                            context: expandedKey.currentContext!,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Column(children: [
                                        Text(
                                          AppLocalization.of(context)!
                                              .introNewWalletGetFirstInfosNameRequest,
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                                  context),
                                        ),
                                      ]),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        side: BorderSide(
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .text45!)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            AppTextField(
                                              topMargin: 0,
                                              leftMargin: 0,
                                              rightMargin: 0,
                                              focusNode: nameFocusNode,
                                              autocorrect: false,
                                              controller: nameController,
                                              keyboardType: TextInputType.text,
                                              style: AppStyles
                                                  .textStyleSize12W600Primary(
                                                      context),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                LengthLimitingTextInputFormatter(
                                                    20),
                                                UpperCaseTextFormatter(),
                                              ],
                                            ),
                                            nameError != null
                                                ? SizedBox(
                                                    height: 40,
                                                    child: Text(nameError!,
                                                        style: AppStyles
                                                            .textStyleSize12W600Primary(
                                                                context)),
                                                  )
                                                : const SizedBox(
                                                    height: 40,
                                                  ),
                                            Text(
                                              AppLocalization.of(context)!
                                                  .introNewWalletGetFirstInfosNameInfos,
                                              style: AppStyles
                                                  .textStyleSize12W600Primary(
                                                      context),
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
                                                isPressed == false
                                                    ? AppButtonType.primary
                                                    : AppButtonType
                                                        .primaryOutline,
                                                AppLocalization.of(context)!.ok,
                                                Dimens.buttonBottomDimens,
                                                onPressed: () async {
                                              if (isPressed == true) {
                                                return;
                                              }
                                              nameError = '';
                                              if (nameController.text.isEmpty) {
                                                setState(() {
                                                  nameError = AppLocalization
                                                          .of(context)!
                                                      .introNewWalletGetFirstInfosNameBlank;
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          nameFocusNode);
                                                });
                                              } else {
                                                bool accountExists = false;
                                                for (Account account
                                                    in appWalletLive!
                                                        .appKeychain!
                                                        .accounts!) {
                                                  if (account.name ==
                                                      nameController.text) {
                                                    accountExists = true;
                                                  }
                                                }
                                                if (accountExists == true) {
                                                  setState(() {
                                                    nameError =
                                                        AppLocalization.of(
                                                                context)!
                                                            .addAccountExists;
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            nameFocusNode);
                                                  });
                                                } else {
                                                  setState(() {
                                                    isPressed = true;
                                                  });
                                                  AppDialogs.showConfirmDialog(
                                                      context,
                                                      AppLocalization.of(
                                                              context)!
                                                          .addAccount,
                                                      AppLocalization.of(
                                                              context)!
                                                          .addAccountConfirmation
                                                          .replaceAll(
                                                              '%1',
                                                              nameController
                                                                  .text),
                                                      AppLocalization.of(
                                                              context)!
                                                          .yes,
                                                      () async {
                                                        try {
                                                          await KeychainUtil().addAccountInKeyChain(
                                                              StateContainer.of(
                                                                      context)
                                                                  .appWallet!,
                                                              await StateContainer
                                                                      .of(
                                                                          context)
                                                                  .getSeed(),
                                                              nameController
                                                                  .text,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curCurrency
                                                                  .currency
                                                                  .name,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curNetwork
                                                                  .getNetworkCryptoCurrencyLabel());
                                                        } on ArchethicConnectionException {
                                                          UIUtil.showSnackbar(
                                                              AppLocalization.of(
                                                                      context)!
                                                                  .noConnection,
                                                              context,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .text!,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .snackBarShadow!,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          5));
                                                        } on Exception {
                                                          UIUtil.showSnackbar(
                                                              AppLocalization.of(
                                                                      context)!
                                                                  .keychainNotExistWarning,
                                                              context,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .text!,
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .snackBarShadow!,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          5));
                                                        }

                                                        setState(() {
                                                          isPressed = false;
                                                        });
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      cancelText:
                                                          AppLocalization.of(
                                                                  context)!
                                                              .no,
                                                      cancelAction: () {
                                                        setState(() {
                                                          isPressed = false;
                                                        });
                                                      });
                                                }
                                              }
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {
                          appWalletLive!.appKeychain!.accounts!
                              .sort((a, b) => a.name!.compareTo(b.name!));
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
      BuildContext context, Account account, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26, bottom: 8),
      child: GestureDetector(
        onTap: () async {
          sl.get<HapticUtil>().feedback(
              FeedbackType.light, StateContainer.of(context).activeVibrations);
          _showSendingAnimation(context);
          if (!account.selected!) {
            _changeAccount(account, setState);
            StateContainer.of(context).appWallet =
                await sl.get<DBHelper>().changeAccount(account);
            await StateContainer.of(context)
                .requestUpdate(forceUpdateChart: false);
          }
          StateContainer.of(context).bottomBarCurrentPage = 1;
          StateContainer.of(context)
              .bottomBarPageController!
              .jumpToPage(StateContainer.of(context).bottomBarCurrentPage);
          Preferences preferences = await Preferences.getInstance();
          preferences.setMainScreenCurrentPage(
              StateContainer.of(context).bottomBarCurrentPage);
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        },
        onLongPress: () {
          sl.get<HapticUtil>().feedback(
              FeedbackType.light, StateContainer.of(context).activeVibrations);
          Sheets.showAppHeightNineSheet(
              context: context,
              widget: ReceiveSheet(address: account.lastAddress),
              onDisposed: () {
                setState(() {
                  StateContainer.of(context)
                      .requestUpdate(forceUpdateChart: false);
                });
              });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: StateContainer.of(context)
                    .curTheme
                    .backgroundAccountsListCardSelected!,
                width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: StateContainer.of(context)
              .curTheme
              .backgroundAccountsListCardSelected,
          child: Container(
            height: 80,
            color: account.selected!
                ? StateContainer.of(context)
                    .curTheme
                    .backgroundAccountsListCardSelected
                : StateContainer.of(context)
                    .curTheme
                    .backgroundAccountsListCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: AutoSizeText(
                                                  account.name!,
                                                  style: AppStyles
                                                      .textStyleSize12W400Primary(
                                                          context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        StateContainer.of(context).showBalance
                                            ? StateContainer.of(context)
                                                        .curPrimaryCurrency
                                                        .primaryCurrency
                                                        .name ==
                                                    PrimaryCurrencySetting(
                                                            AvailablePrimaryCurrency
                                                                .native)
                                                        .primaryCurrency
                                                        .name
                                                ? Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        AutoSizeText(
                                                          '${account.balance!.nativeTokenValueToString()} ${account.balance!.nativeTokenName!}',
                                                          style: AppStyles
                                                              .textStyleSize12W400Primary(
                                                                  context),
                                                        ),
                                                        AutoSizeText(
                                                          CurrencyUtil.getConvertedAmount(
                                                              StateContainer.of(
                                                                      context)
                                                                  .curCurrency
                                                                  .currency
                                                                  .name,
                                                              account.balance!
                                                                  .fiatCurrencyValue!),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppStyles
                                                              .textStyleSize12W400Primary(
                                                                  context),
                                                        ),
                                                        if (account.accountTokens !=
                                                                null &&
                                                            account
                                                                .accountTokens!
                                                                .isNotEmpty)
                                                          AutoSizeText(
                                                            account.accountTokens!
                                                                        .length >
                                                                    1
                                                                ? '${account.accountTokens!.length} ${AppLocalization.of(context)!.tokens}'
                                                                : '${account.accountTokens!.length} ${AppLocalization.of(context)!.token}',
                                                            style: AppStyles
                                                                .textStyleSize12W400Primary(
                                                                    context),
                                                          ),
                                                        if (account.accountNFT !=
                                                                null &&
                                                            account.accountNFT!
                                                                .isNotEmpty)
                                                          AutoSizeText(
                                                            '${account.accountNFT!.length} ${AppLocalization.of(context)!.nft}',
                                                            style: AppStyles
                                                                .textStyleSize12W400Primary(
                                                                    context),
                                                          ),
                                                      ],
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        AutoSizeText(
                                                          CurrencyUtil.getConvertedAmount(
                                                              StateContainer.of(
                                                                      context)
                                                                  .curCurrency
                                                                  .currency
                                                                  .name,
                                                              account.balance!
                                                                  .fiatCurrencyValue!),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppStyles
                                                              .textStyleSize12W400Primary(
                                                                  context),
                                                        ),
                                                        AutoSizeText(
                                                          '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                          style: AppStyles
                                                              .textStyleSize12W400Primary(
                                                                  context),
                                                        ),
                                                        if (account.accountTokens !=
                                                                null &&
                                                            account
                                                                .accountTokens!
                                                                .isNotEmpty)
                                                          AutoSizeText(
                                                            account.accountTokens!
                                                                        .length >
                                                                    1
                                                                ? '${account.accountTokens!.length} ${AppLocalization.of(context)!.tokens}'
                                                                : '${account.accountTokens!.length} ${AppLocalization.of(context)!.token}',
                                                            style: AppStyles
                                                                .textStyleSize12W400Primary(
                                                                    context),
                                                          ),
                                                      ],
                                                    ),
                                                  )
                                            : Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    AutoSizeText(
                                                      '···········',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppStyles
                                                          .textStyleSize12W600Primary60(
                                                              context),
                                                    ),
                                                    AutoSizeText(
                                                      '···········',
                                                      style: AppStyles
                                                          .textStyleSize12W600Primary60(
                                                              context),
                                                    ),
                                                    AutoSizeText(
                                                      '···········',
                                                      style: AppStyles
                                                          .textStyleSize12W600Primary60(
                                                              context),
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
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false));
  }
}
