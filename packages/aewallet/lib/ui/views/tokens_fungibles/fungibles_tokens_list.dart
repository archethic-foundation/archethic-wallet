/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:core/model/data/account_token.dart';
import 'package:core_ui/ui/util/hexagon.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FungiblesTokensListWidget extends StatefulWidget {
  const FungiblesTokensListWidget({super.key});
  @override
  State<FungiblesTokensListWidget> createState() =>
      _FungiblesTokensListWidgetState();
}

class _FungiblesTokensListWidgetState extends State<FungiblesTokensListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .accountTokens!
            .isEmpty)
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                  AppLocalization.of(context)!.fungiblesTokensListNoTokenYet,
                  style: AppStyles.textStyleSize14W600Primary(context)),
            ),
          ),
        for (int i = 0;
            i <
                StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .accountTokens!
                    .length;
            i++)
          getLign(context, i)
      ],
    );
  }

  static Container getLign(BuildContext context, int num) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26, top: 6),
          child: (StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .accountTokens!
                          .isNotEmpty &&
                      StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .accountTokens!
                              .length >
                          num) ||
                  (StateContainer.of(context).recentTransactionsLoading ==
                          true &&
                      StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .accountTokens!
                              .length >
                          num)
              ? displayTxDetailTransfer(
                  context,
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .accountTokens![num])
              : const SizedBox()),
    );
  }

  static Widget displayTxDetailTransfer(
      BuildContext context, AccountToken accountFungibleToken) {
    return InkWell(
      onTap: () {
        sl.get<HapticUtil>().feedback(
            FeedbackType.light, StateContainer.of(context).activeVibrations);
      },
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            color: Colors.white.withOpacity(0.1),
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDark!
                              .withOpacity(0.3),
                          border: Border.all(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest!
                                  .withOpacity(0.2),
                              width: 2),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_circle_up_outlined,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest!,
                              size: 21),
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(FeedbackType.light,
                                StateContainer.of(context).activeVibrations);
                            Sheets.showAppHeightNineSheet(
                              context: context,
                              widget: TransferSheet(
                                  accountToken: accountFungibleToken,
                                  primaryCurrency: StateContainer.of(context)
                                      .curPrimaryCurrency,
                                  title: AppLocalization.of(context)!
                                      .transferTokens
                                      .replaceAll(
                                          '%1',
                                          accountFungibleToken
                                              .tokenInformations!.symbol!),
                                  localCurrency:
                                      StateContainer.of(context).curCurrency),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(accountFungibleToken.tokenInformations!.name!,
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text(
                              '${AppLocalization.of(context)!.tokenSupply} ${accountFungibleToken.tokenInformations!.supply!}',
                              style: AppStyles.textStyleSize12W400Primary(
                                  context)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(accountFungibleToken.amount!.toString(),
                          style: AppStyles.textStyleSize12W400Primary(context)),
                      Text(accountFungibleToken.tokenInformations!.symbol!,
                          style: AppStyles.textStyleSize12W600Primary(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
