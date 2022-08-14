// Flutter imports:
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
import 'package:aewallet/ui/util/hexagon.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';

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
  final ScrollController scrollController = ScrollController();
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
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 140),
                child: AutoSizeText(
                  AppLocalization.of(context)!.keychainHeader,
                  style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
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
                    text: appWalletLive!.appKeychain!.address!.toUpperCase()));
                UIUtil.showSnackbar(
                    AppLocalization.of(context)!.addressCopied,
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!);
              },
              child: Column(
                children: [
                  AutoSizeText(
                    appWalletLive!.appKeychain!.address!
                        .toUpperCase()
                        .substring(0, 34),
                    style: AppStyles.textStyleSize12W100Primary(context),
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                  AutoSizeText(
                    appWalletLive!.appKeychain!.address!
                        .toUpperCase()
                        .substring(34),
                    style: AppStyles.textStyleSize12W100Primary(context),
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                ],
              )),
          Expanded(
              key: expandedKey,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: appWalletLive!.appKeychain!.accounts!.length,
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
          Row(
            children: <Widget>[
              appWalletLive!.appKeychain!.accounts!.length >= kMaxAccounts
                  ? const SizedBox()
                  : AppButton.buildAppButton(
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
                                              .textStyleSize16W400Primary(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                        await KeychainUtil().addAccountInKeyChain(
                                                            StateContainer.of(
                                                                    context)
                                                                .appWallet!,
                                                            await StateContainer
                                                                    .of(context)
                                                                .getSeed(),
                                                            nameController.text,
                                                            StateContainer.of(
                                                                    context)
                                                                .curCurrency
                                                                .currency
                                                                .name,
                                                            StateContainer.of(
                                                                    context)
                                                                .curNetwork
                                                                .getNetworkCryptoCurrencyLabel());

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
        child: Container(
          color: account.selected!
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
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
                                Container(
                                  width: (MediaQuery.of(context).size.width),
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                              .native)
                                                      .primaryCurrency
                                                      .name
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      AutoSizeText(
                                                        '${account.balance!.nativeTokenValueToString()} ${account.balance!.nativeTokenName!}',
                                                        style: AppStyles
                                                            .textStyleSize14W600Primary(
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
                                                            .textStyleSize14W600Primary(
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
                                                            .textStyleSize14W600Primary(
                                                                context),
                                                      ),
                                                      AutoSizeText(
                                                        '${account.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
                                                        style: AppStyles
                                                            .textStyleSize14W600Primary(
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
                      ],
                    ),
                  ),
                ],
              ),
              if (account.accountTokens != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: account.accountTokens!
                          .map(
                            (accountToken) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: ClipPath(
                                clipper: ClipperHexagon(),
                                child: Stack(
                                  alignment: const Alignment(0.0, 0.0),
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 30,
                                      decoration: ShapeDecoration(
                                        gradient: StateContainer.of(context)
                                            .curTheme
                                            .gradientHexagon!,
                                        shape: const StadiumBorder(),
                                        shadows: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.normal,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 7,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        accountToken.tokenInformations!.symbol!,
                                        style: AppStyles
                                            .textStyleSize10W600Hexagon(
                                                context)),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
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
