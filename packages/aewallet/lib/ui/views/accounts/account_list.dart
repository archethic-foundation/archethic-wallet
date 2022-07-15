// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:core/model/data/account.dart';
import 'package:core/model/data/app_wallet.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/currency_util.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/keychain_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AccountsList {
  AccountsList();

  mainBottomSheet(BuildContext context) {
    Sheets.showAppHeightNineSheet(
        context: context, widget: const AccountsListWidget());
  }
}

class AccountsListWidget extends StatefulWidget {
  const AccountsListWidget({super.key});

  @override
  State<AccountsListWidget> createState() => _AccountsListWidgetState();
}

class _AccountsListWidgetState extends State<AccountsListWidget> {
  List<Account> accountList = List<Account>.empty(growable: true);
  static const int kMaxAccounts = 50;
  final GlobalKey expandedKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  bool? isPressed;
  bool? isChangeAccountInProgress;
  bool? animationOpen;
  bool? keychainSync;

  @override
  void initState() {
    super.initState();
    isPressed = false;
    animationOpen = false;
    isChangeAccountInProgress = false;
    keychainSync = false;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _changeAccount(Account account, StateSetter setState) async {
    for (var a in accountList) {
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
    return SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 5,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text10,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140),
                    child: AutoSizeText(
                      AppLocalization.of(context)!.accountsHeader,
                      style:
                          AppStyles.textStyleSize24W700EquinoxPrimary(context),
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ),
                ],
              ),
              FutureBuilder<String?>(
                  future: StateContainer.of(context).getSeed(),
                  builder: (BuildContext context, AsyncSnapshot<String?> seed) {
                    if (isChangeAccountInProgress == true) {
                      return Expanded(
                          key: expandedKey,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemCount: accountList.length,
                                  controller: scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildAccountListItem(
                                        context, accountList[index], setState);
                                  },
                                ),
                              ),
                            ],
                          ));
                    } else {
                      if (seed.hasData) {
                        keychainSync = true;
                        return FutureBuilder<AppWallet?>(
                            future: KeychainUtil().getListAccountsFromKeychain(
                                StateContainer.of(context).appWallet!,
                                seed.data,
                                StateContainer.of(context)
                                    .curCurrency
                                    .currency
                                    .name,
                                StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .balance!
                                    .nativeTokenName!,
                                StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .balance!
                                    .tokenPrice!,
                                currentName: StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .name),
                            builder: (BuildContext context,
                                AsyncSnapshot<AppWallet?> snapshot) {
                              if (snapshot.hasData) {
                                keychainSync = false;
                                accountList =
                                    snapshot.data!.appKeychain!.accounts!;
                                accountList
                                    .sort((a, b) => a.name!.compareTo(b.name!));
                                return Expanded(
                                    key: expandedKey,
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            itemCount: accountList.length,
                                            controller: scrollController,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildAccountListItem(
                                                  context,
                                                  accountList[index],
                                                  setState);
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              } else {
                                accountList = StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .accounts!;
                                accountList
                                    .sort((a, b) => a.name!.compareTo(b.name!));
                                return Expanded(
                                    key: expandedKey,
                                    child: Stack(
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  AppLocalization.of(context)!
                                                      .keychainSync,
                                                  style: AppStyles
                                                      .textStyleSize16W400Primary(
                                                          context)),
                                              JumpingDotsProgressIndicator(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              ),
                                            ]),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            itemCount: accountList.length,
                                            controller: scrollController,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildAccountListItem(
                                                  context,
                                                  accountList[index],
                                                  setState);
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              }
                            });
                      } else {
                        return const SizedBox();
                      }
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  accountList.length >= kMaxAccounts
                      ? const SizedBox()
                      : AppButton.buildAppButton(
                          const Key('addAccount'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.addAccount,
                          Dimens.buttonTopDimens,
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
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Column(children: [
                                            Text(
                                              AppLocalization.of(context)!
                                                  .introNewWalletGetFirstInfosNameRequest,
                                              style: AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                            ),
                                          ]),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16.0)),
                                            side: BorderSide(
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .text45!)),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: AppStyles
                                                      .textStyleSize14W600Primary(
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
                                                                .textStyleSize14W600Primary(
                                                                    context)),
                                                      )
                                                    : const SizedBox(
                                                        height: 40,
                                                      ),
                                                Text(
                                                  AppLocalization.of(context)!
                                                      .introNewWalletGetFirstInfosNameInfos,
                                                  style: AppStyles
                                                      .textStyleSize14W600Primary(
                                                          context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                AppButton.buildAppButton(
                                                    const Key('addName'),
                                                    context,
                                                    isPressed == false
                                                        ? AppButtonType.primary
                                                        : AppButtonType
                                                            .primaryOutline,
                                                    AppLocalization.of(context)!
                                                        .ok,
                                                    Dimens.buttonBottomDimens,
                                                    onPressed: () async {
                                                  if (isPressed == true) {
                                                    return;
                                                  }
                                                  nameError = '';
                                                  if (nameController
                                                      .text.isEmpty) {
                                                    setState(() {
                                                      nameError = AppLocalization
                                                              .of(context)!
                                                          .introNewWalletGetFirstInfosNameBlank;
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              nameFocusNode);
                                                    });
                                                  } else {
                                                    if (nameController.text
                                                            .contains(' ') ||
                                                        nameController.text
                                                            .contains('\\')) {
                                                      setState(() {
                                                        nameError = AppLocalization
                                                                .of(context)!
                                                            .introNewWalletGetFirstInfosNameCharacterNonValid;
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                nameFocusNode);

                                                        isPressed = false;
                                                      });
                                                    } else {
                                                      {
                                                        bool accountExists =
                                                            false;
                                                        for (Account account
                                                            in accountList) {
                                                          if (account.name ==
                                                              nameController
                                                                  .text) {
                                                            accountExists =
                                                                true;
                                                          }
                                                        }
                                                        if (accountExists ==
                                                            true) {
                                                          setState(() {
                                                            nameError =
                                                                AppLocalization.of(
                                                                        context)!
                                                                    .addAccountExists;
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    nameFocusNode);
                                                          });
                                                        } else {
                                                          setState(() {
                                                            isPressed = true;
                                                          });
                                                          AppDialogs
                                                              .showConfirmDialog(
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
                                                                      .yes
                                                                      .toUpperCase(),
                                                                  () async {
                                                                    Account? account = await KeychainUtil().addAccountInKeyChain(
                                                                        await StateContainer.of(context)
                                                                            .getSeed(),
                                                                        nameController
                                                                            .text,
                                                                        StateContainer.of(context)
                                                                            .curCurrency
                                                                            .currency
                                                                            .name);
                                                                    setState(
                                                                        () {
                                                                      StateContainer.of(
                                                                              context)
                                                                          .appWallet!
                                                                          .appKeychain!
                                                                          .accounts!
                                                                          .add(
                                                                              account!);
                                                                      StateContainer.of(
                                                                              context)
                                                                          .appWallet!
                                                                          .save();

                                                                      isPressed =
                                                                          false;
                                                                    });
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  cancelText: AppLocalization.of(
                                                                          context)!
                                                                      .no
                                                                      .toUpperCase(),
                                                                  cancelAction:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      isPressed =
                                                                          false;
                                                                    });
                                                                  });
                                                        }
                                                      }
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
                              accountList
                                  .sort((a, b) => a.name!.compareTo(b.name!));
                            });
                          },
                        ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildAccountListItem(
      BuildContext context, Account account, StateSetter setState) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: () async {
          if (keychainSync == true) {
            return;
          }
          _showSendingAnimation(context);
          setState(() {
            isChangeAccountInProgress = true;
          });
          if (!account.selected!) {
            _changeAccount(account, setState);
            StateContainer.of(context).appWallet =
                await sl.get<DBHelper>().changeAccount(account);
            await StateContainer.of(context)
                .requestUpdate(forceUpdateChart: false);
          }
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        },
        child: Column(
          children: <Widget>[
            Divider(
              height: 2,
              color: StateContainer.of(context).curTheme.text15,
            ),
            SizedBox(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Selected indicator
                  Container(
                    height: 70,
                    width: 6,
                    color: account.selected!
                        ? const Color(0xFF00A4DB)
                        : Colors.transparent,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsetsDirectional.only(start: 8, end: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 0.9),
                                margin: const EdgeInsetsDirectional.only(
                                    start: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          keychainSync == false
                                              ? AutoSizeText(
                                                  account.name!,
                                                  style: AppStyles
                                                      .textStyleSize16W600EquinoxPrimary(
                                                          context),
                                                )
                                              : AutoSizeText(
                                                  account.name!,
                                                  style: AppStyles
                                                      .textStyleSize16W600EquinoxPrimary30(
                                                          context),
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
                                                            .NATIVE)
                                                    .primaryCurrency
                                                    .name
                                            ? Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    keychainSync == false
                                                        ? AutoSizeText(
                                                            account.balance!
                                                                .nativeTokenValueToString(),
                                                            style: AppStyles
                                                                .textStyleSize25W900EquinoxPrimary(
                                                                    context),
                                                          )
                                                        : AutoSizeText(
                                                            account.balance!
                                                                .nativeTokenValueToString(),
                                                            style: AppStyles
                                                                .textStyleSize25W900EquinoxPrimary30(
                                                                    context),
                                                          ),
                                                    keychainSync == false
                                                        ? AutoSizeText(
                                                            CurrencyUtil.getConvertedAmount(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency
                                                                    .currency
                                                                    .name,
                                                                account.balance!
                                                                    .fiatCurrencyValue!),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppStyles
                                                                .textStyleSize12W600Primary(
                                                                    context),
                                                          )
                                                        : AutoSizeText(
                                                            CurrencyUtil.getConvertedAmount(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency
                                                                    .currency
                                                                    .name,
                                                                account.balance!
                                                                    .fiatCurrencyValue!),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppStyles
                                                                .textStyleSize12W600Primary30(
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
                                                    keychainSync == false
                                                        ? AutoSizeText(
                                                            CurrencyUtil.getConvertedAmount(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency
                                                                    .currency
                                                                    .name,
                                                                account.balance!
                                                                    .fiatCurrencyValue!),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppStyles
                                                                .textStyleSize25W900EquinoxPrimary(
                                                                    context),
                                                          )
                                                        : AutoSizeText(
                                                            CurrencyUtil.getConvertedAmount(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency
                                                                    .currency
                                                                    .name,
                                                                account.balance!
                                                                    .fiatCurrencyValue!),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppStyles
                                                                .textStyleSize25W900EquinoxPrimary30(
                                                                    context),
                                                          ),
                                                    keychainSync == false
                                                        ? AutoSizeText(
                                                            '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                            style: AppStyles
                                                                .textStyleSize12W600Primary(
                                                                    context),
                                                          )
                                                        : AutoSizeText(
                                                            '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                            style: AppStyles
                                                                .textStyleSize12W600Primary30(
                                                                    context),
                                                          ),
                                                  ],
                                                ),
                                              )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Selected indicator
                  Container(
                    height: 70,
                    width: 6,
                    color: account.selected!
                        ? const Color(0xFFCC00FF)
                        : Colors.transparent,
                  )
                ],
              ),
            ),
          ],
        ));
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
