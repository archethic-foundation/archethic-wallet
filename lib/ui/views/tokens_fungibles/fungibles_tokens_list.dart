/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FungiblesTokensListWidget extends StatelessWidget {
  const FungiblesTokensListWidget({super.key});

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
                style: AppStyles.textStyleSize14W600Primary(context),
              ),
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
                (StateContainer.of(context).recentTransactionsLoading == true &&
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
                    .accountTokens![num],
              )
            : const SizedBox(),
      ),
    );
  }

  static Widget displayTxDetailTransfer(
    BuildContext context,
    AccountToken accountFungibleToken,
  ) {
    return InkWell(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
      },
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: StateContainer.of(context)
                    .curTheme
                    .backgroundFungiblesTokensListCard!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: StateContainer.of(context)
                .curTheme
                .backgroundFungiblesTokensListCard,
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDark!
                              .withOpacity(0.3),
                          border: Border.all(
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest!
                                .withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_up_outlined,
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest,
                            size: 21,
                          ),
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
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
                                          .tokenInformations!.symbol!,
                                    ),
                                localCurrency:
                                    StateContainer.of(context).curCurrency,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        accountFungibleToken.tokenInformations!.name!,
                        style: AppStyles.textStyleSize12W600Primary(context),
                      ),
                    ],
                  ),
                  if (StateContainer.of(context).showBalance == true) Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              NumberUtil.formatThousands(
                                accountFungibleToken.amount!,
                              ),
                              style: AppStyles.textStyleSize12W400Primary(
                                context,
                              ),
                            ),
                            Text(
                              accountFungibleToken.tokenInformations!.symbol!,
                              style: AppStyles.textStyleSize12W600Primary(
                                context,
                              ),
                            ),
                          ],
                        ) else Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '···········',
                              style: AppStyles.textStyleSize12W600Primary60(
                                context,
                              ),
                            ),
                            Text(
                              accountFungibleToken.tokenInformations!.symbol!,
                              style: AppStyles.textStyleSize12W600Primary(
                                context,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
