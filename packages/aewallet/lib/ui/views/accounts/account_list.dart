// Flutter imports:
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:core/model/data/account.dart';
import 'package:core/model/data/app_wallet.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/currency_util.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/keychain_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountsList {
  AccountsList(this.seed, this.currencyName, this.appWallet);

  final String? seed;
  final String? currencyName;
  final AppWallet? appWallet;

  mainBottomSheet(BuildContext context) {
    Sheets.showAppHeightNineSheet(
        context: context,
        widget: AccountsListWidget(
          seed: seed,
          currencyName: currencyName,
          appWallet: appWallet,
        ));
  }
}

class AccountsListWidget extends StatefulWidget {
  final String? seed;
  final String? currencyName;
  final AppWallet? appWallet;
  const AccountsListWidget(
      {super.key, this.seed, this.currencyName, this.appWallet});

  @override
  State<AccountsListWidget> createState() => _AccountsListWidgetState();
}

class _AccountsListWidgetState extends State<AccountsListWidget> {
  static const int kMaxAccounts = 50;
  final GlobalKey expandedKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  bool? isPressed;
  bool? animationOpen;
  AppWallet? appWalletLive;
  bool? keychainLoaded;

  @override
  void initState() {
    super.initState();
    isPressed = false;
    animationOpen = false;
    appWalletLive = widget.appWallet;
    appWalletLive!.appKeychain!.accounts!
        .sort((a, b) => a.name!.compareTo(b.name!));
    keychainLoaded = false;
    KeychainUtil()
        .getListAccountsFromKeychain(
            widget.appWallet,
            widget.seed,
            widget.currencyName!,
            widget.appWallet!.appKeychain!
                .getAccountSelected()!
                .balance!
                .nativeTokenName!,
            widget.appWallet!.appKeychain!
                .getAccountSelected()!
                .balance!
                .tokenPrice!,
            currentName:
                widget.appWallet!.appKeychain!.getAccountSelected()!.name)
        .then((AppWallet? value) {
      if (mounted) {
        setState(() {
          value!.appKeychain!.accounts!
              .sort((a, b) => a.name!.compareTo(b.name!));
          appWalletLive = value;
          keychainLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 140),
                child: AutoSizeText(
                  AppLocalization.of(context)!.accountsKeychainAddressHeader,
                  style: AppStyles.textStyleSize12W100Primary(context),
                  maxLines: 1,
                  stepGranularity: 0.1,
                ),
              ),
              InkWell(
                onTap: () {
                  sl.get<HapticUtil>().feedback(FeedbackType.light,
                      StateContainer.of(context).activeVibrations);
                  Clipboard.setData(ClipboardData(
                      text: StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .lastAddress!));
                  UIUtil.showSnackbar(
                      AppLocalization.of(context)!.addressCopied,
                      context,
                      StateContainer.of(context).curTheme.text!,
                      StateContainer.of(context).curTheme.snackBarShadow!);
                },
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 140),
                  child: AutoSizeText(
                    appWalletLive!.appKeychain!.address!.toUpperCase(),
                    style: AppStyles.textStyleSize12W100Primary(context),
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                ),
              ),
              Expanded(
                  key: expandedKey,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount:
                              appWalletLive!.appKeychain!.accounts!.length,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildAccountListItem(
                                context,
                                appWalletLive!.appKeychain!.accounts![index],
                                setState);
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  appWalletLive!.appKeychain!.accounts!.length >= kMaxAccounts
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
                                                            in appWalletLive!
                                                                .appKeychain!
                                                                .accounts!) {
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
                                                                      .yes,
                                                                  () async {
                                                                    await KeychainUtil().addAccountInKeyChain(
                                                                        StateContainer.of(context)
                                                                            .appWallet!,
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
                                                                      isPressed =
                                                                          false;
                                                                    });
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  cancelText:
                                                                      AppLocalization.of(
                                                                              context)!
                                                                          .no,
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
                              appWalletLive!.appKeychain!.accounts!
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
          _showSendingAnimation(context);

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
                                          AutoSizeText(
                                            account.name!,
                                            style: AppStyles
                                                .textStyleSize16W600EquinoxPrimary(
                                                    context),
                                          )
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
                                                    AutoSizeText(
                                                      account.balance!
                                                          .nativeTokenValueToString(),
                                                      style: AppStyles
                                                          .textStyleSize25W900EquinoxPrimary(
                                                              context),
                                                    ),
                                                    AutoSizeText(
                                                      CurrencyUtil
                                                          .getConvertedAmount(
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
                                                          .textStyleSize12W600Primary(
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
                                                      CurrencyUtil
                                                          .getConvertedAmount(
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
                                                          .textStyleSize25W900EquinoxPrimary(
                                                              context),
                                                    ),
                                                    AutoSizeText(
                                                      '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                      style: AppStyles
                                                          .textStyleSize12W600Primary(
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
