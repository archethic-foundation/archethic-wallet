// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aewallet/ui/views/accounts/account_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/keychain_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Project imports:
import 'package:aewallet/bus/account_changed_event.dart';
import 'package:aewallet/bus/account_modified_event.dart';

// Project imports:

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
  bool? addingAccount;
  final ScrollController scrollController = ScrollController();
  StreamSubscription<AccountModifiedEvent>? accountModifiedSub;
  bool? accountIsChanging;
  bool? isPressed;

  @override
  void initState() {
    super.initState();
    _registerBus();
    isPressed = false;
    addingAccount = false;
    accountIsChanging = false;
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _registerBus() {
    accountModifiedSub = EventTaxiImpl.singleton()
        .registerTo<AccountModifiedEvent>()
        .listen((event) {
      if (event.deleted) {
        if (event.account!.selected!) {
          Future.delayed(const Duration(milliseconds: 50), () {
            setState(() {
              widget.accounts!
                  .where((a) =>
                      a.name == StateContainer.of(context).selectedAccount.name)
                  .forEach((account) {
                account.selected = true;
              });
            });
          });
        }
        setState(() {
          widget.accounts!.removeWhere((a) => a.name == event.account!.name);
        });
      } else {
        // Name change
        setState(() {
          widget.accounts!.removeWhere((a) => a.name == event.account!.name);
          widget.accounts!.add(event.account!);
          widget.accounts!.sort((a, b) => a.name!.compareTo(b.name!));
        });
      }
    });
  }

  void _destroyBus() {
    if (accountModifiedSub != null) {
      accountModifiedSub!.cancel();
    }
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
    EventTaxiImpl.singleton()
        .fire(AccountChangedEvent(account: account, delayPop: true));
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
                          color: StateContainer.of(context).curTheme.primary10,
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
                      'Accounts',
                      style: AppStyles.textStyleSize24W700Primary(context),
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
                          ? const Center(
                              child: Text("Loading"),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: widget.accounts!.length,
                              controller: scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildAccountListItem(
                                    context, widget.accounts![index], setState);
                              },
                            ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 20.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark00!,
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark!,
                              ],
                              begin: const AlignmentDirectional(0.5, 1.0),
                              end: const AlignmentDirectional(0.5, -1.0),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 20.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark!,
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark00!
                              ],
                              begin: const AlignmentDirectional(0.5, 1.0),
                              end: const AlignmentDirectional(0.5, -1.0),
                            ),
                          ),
                        ),
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
                          'Add Account',
                          Dimens.buttonTopDimens,
                          disabled: addingAccount!,
                          onPressed: () {
                            _nameDialog();
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
    return Slidable(
      key: Key(account.name!),
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          flex: 2,
          onPressed: (context) {
            AccountDetailsSheet(account).mainBottomSheet(context);
          },
          backgroundColor: const Color(0xFF0392CF),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          onPressed: (context) {
            AppDialogs.showConfirmDialog(
                context,
                'Hide Account?',
                'Are you sure you want to hide this account? You can re-add it later by tapping the "%1" button.',
                AppLocalization.of(context)!.yes, () {
              sl.get<DBHelper>().hideAccount(account).then((id) {
                EventTaxiImpl.singleton().fire(
                    AccountModifiedEvent(account: account, deleted: true));
                setState(() {
                  widget.accounts!.removeWhere((a) => a.name == account.name);
                });
              });
            }, cancelText: AppLocalization.of(context)!.no);
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.hide_source,
          label: 'Hide',
        ),
      ]),
      child: FlatButton(
          highlightColor: StateContainer.of(context).curTheme.primary15,
          splashColor: StateContainer.of(context).curTheme.primary15,
          onPressed: () {
            if (!accountIsChanging!) {
              if (!account.selected!) {
                setState(() {
                  accountIsChanging = true;
                });
                _changeAccount(account, setState);
              }
            }
          },
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Divider(
                height: 2,
                color: StateContainer.of(context).curTheme.primary15,
              ),
              SizedBox(
                height: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Selected indicator
                    Container(
                      height: 70,
                      width: 6,
                      color: account.selected!
                          ? StateContainer.of(context).curTheme.primary
                          : Colors.transparent,
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            const EdgeInsetsDirectional.only(start: 8, end: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Account name and address
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width * 0.8),
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Account name
                                      AutoSizeText(
                                        account.name!,
                                        style: AppStyles
                                            .textStyleSize16W600Primary(
                                                context),
                                      ),
                                      // Account address
                                      account.lastAddress != null
                                          ? AutoSizeText(
                                              account.lastAddress!
                                                  .toUpperCase(),
                                              style: AppStyles
                                                  .textStyleSize12W100Text60(
                                                      context))
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
                          ? StateContainer.of(context).curTheme.primary
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _nameDialog() async {
    FocusNode nameFocusNode = FocusNode();
    TextEditingController nameController = TextEditingController();
    String? nameError;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(children: [
                    Text(
                      AppLocalization.of(context)!
                          .introNewWalletGetFirstInfosNameRequest,
                      style: AppStyles.textStyleSize16W400Primary(context),
                    ),
                  ]),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    side: BorderSide(
                        color: StateContainer.of(context).curTheme.primary45!)),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppTextField(
                          topMargin: 0,
                          leftMargin: 0,
                          rightMargin: 0,
                          focusNode: nameFocusNode,
                          autocorrect: false,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          style: AppStyles.textStyleSize14W600Primary(context),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20),
                          ],
                        ),
                        nameError != null
                            ? SizedBox(
                                height: 40,
                                child: Text(nameError!,
                                    style: AppStyles.textStyleSize14W600Primary(
                                        context)),
                              )
                            : const SizedBox(
                                height: 40,
                              ),
                        Text(
                          AppLocalization.of(context)!
                              .introNewWalletGetFirstInfosNameInfos,
                          style: AppStyles.textStyleSize14W600Primary(context),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppButton.buildAppButton(
                          const Key('addName'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.ok,
                          Dimens.buttonBottomDimens,
                          onPressed: () async {
                            if (isPressed == true) {
                              return;
                            }
                            setState(() {
                              isPressed = true;
                            });
                            nameError = '';
                            if (nameController.text.isEmpty) {
                              setState(() {
                                nameError = AppLocalization.of(context)!
                                    .introNewWalletGetFirstInfosNameBlank;
                                FocusScope.of(context)
                                    .requestFocus(nameFocusNode);
                              });
                            } else {
                              Account? account = await KeychainUtil()
                                  .addAccount(
                                      await StateContainer.of(context)
                                          .getSeed(),
                                      nameController.text);
                              setState(() {
                                isPressed = false;
                              });
                              Navigator.pop(context);
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
  }
}
