// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:core/model/balance_wallet.dart';
import 'package:core/model/primary_currency.dart';
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
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/keychain_util.dart';
import 'package:core_ui/ui/util/dimens.dart';

class AccountsList {
  List<Account>? accounts;

  AccountsList(this.accounts);

  mainBottomSheet(BuildContext context) {
    Sheets.showAppHeightNineSheet(
        context: context, widget: AccountsListWidget(accounts: accounts));
  }
}

class AccountsListWidget extends StatefulWidget {
  final List<Account>? accounts;

  const AccountsListWidget({super.key, @required this.accounts});

  @override
  State<AccountsListWidget> createState() => _AccountsListWidgetState();
}

class _AccountsListWidgetState extends State<AccountsListWidget> {
  static const int kMaxAccounts = 50;
  final GlobalKey expandedKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  bool? isPressed;

  @override
  void initState() {
    super.initState();
    isPressed = false;
    widget.accounts!.sort((a, b) => a.name!.compareTo(b.name!));
  }

  Future<void> _changeAccount(Account account, StateSetter setState) async {
    for (var a in widget.accounts!) {
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
    await sl.get<DBHelper>().changeAccount(account);
    StateContainer.of(context).recentTransactionsLoading = true;

    await StateContainer.of(context).requestUpdate(account: account);

    StateContainer.of(context).recentTransactionsLoading = false;
    Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
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
              Expanded(
                  key: expandedKey,
                  child: Stack(
                    children: <Widget>[
                      widget.accounts == null
                          ? const SizedBox()
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: widget.accounts!.length,
                              controller: scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildAccountListItem(
                                    context, widget.accounts![index], setState);
                              },
                            ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  widget.accounts == null ||
                          widget.accounts!.length >= kMaxAccounts
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
                                barrierDismissible: false,
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
                                                      bool accountExists =
                                                          false;
                                                      for (Account account
                                                          in widget.accounts!) {
                                                        if (account.name ==
                                                            nameController
                                                                .text) {
                                                          accountExists = true;
                                                        }
                                                      }
                                                      if (accountExists ==
                                                          true) {
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
                                                                      await StateContainer.of(
                                                                              context)
                                                                          .getSeed(),
                                                                      nameController
                                                                          .text);
                                                                  setState(() {
                                                                    widget
                                                                        .accounts!
                                                                        .add(
                                                                            account!);
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
                                                                  setState(() {
                                                                    isPressed =
                                                                        false;
                                                                  });
                                                                });
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
                                });
                            setState(() {
                              widget.accounts!
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
    BalanceWallet balance = BalanceWallet(double.tryParse(account.balance!),
        StateContainer.of(context).curCurrency);
    balance.localCurrencyPrice =
        StateContainer.of(context).wallet!.accountBalance.localCurrencyPrice;

    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: () {
          if (!account.selected!) {
            _changeAccount(account, setState);
          }
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
                                                    AutoSizeText(
                                                      account.balance! +
                                                          ' ' +
                                                          StateContainer.of(
                                                                  context)
                                                              .curNetwork
                                                              .getNetworkCryptoCurrencyLabel(),
                                                      style: AppStyles
                                                          .textStyleSize20W700EquinoxPrimary(
                                                              context),
                                                    ),
                                                    Text(
                                                        balance
                                                            .getConvertedAccountBalanceDisplay(),
                                                        style: AppStyles
                                                            .textStyleSize14W600Primary(
                                                                context)),
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
                                                    Text(
                                                        balance
                                                            .getConvertedAccountBalanceDisplay(),
                                                        style: AppStyles
                                                            .textStyleSize20W700EquinoxPrimary(
                                                                context)),
                                                    AutoSizeText(
                                                      account.balance! +
                                                          ' ' +
                                                          StateContainer.of(
                                                                  context)
                                                              .curNetwork
                                                              .getNetworkCryptoCurrencyLabel(),
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
}
