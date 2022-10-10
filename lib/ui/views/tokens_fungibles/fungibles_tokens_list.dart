/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FungiblesTokensListWidget extends ConsumerWidget {
  const FungiblesTokensListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final accountTokens = StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.accountTokens;
    final theme = ref.read(ThemeProviders.theme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (accountTokens!.isEmpty)
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                localizations.fungiblesTokensListNoTokenYet,
                style: theme.textStyleSize14W600Primary,
              ),
            ),
          ),
        for (int i = 0; i < accountTokens.length; i++)
          _FungiblesTokensLine(
            num: i,
            accountTokens: accountTokens,
          )
      ],
    );
  }
}

class _FungiblesTokensLine extends StatelessWidget {
  const _FungiblesTokensLine({required this.num, required this.accountTokens});

  final int num;
  final List<AccountToken> accountTokens;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 6),
        child: (accountTokens.isNotEmpty && accountTokens.length > num) ||
                (StateContainer.of(context).recentTransactionsLoading == true && accountTokens.length > num)
            ? _FungiblesTokensDetailTransfer(
                accountFungibleToken: accountTokens[num],
              )
            : const SizedBox(),
      ),
    );
  }
}

class _FungiblesTokensDetailTransfer extends ConsumerWidget {
  const _FungiblesTokensDetailTransfer({
    required this.accountFungibleToken,
  });

  final AccountToken accountFungibleToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.read(ThemeProviders.theme);

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
                color: theme.backgroundFungiblesTokensListCard!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: theme.backgroundFungiblesTokensListCard,
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
                          color: theme.backgroundDark!.withOpacity(0.3),
                          border: Border.all(
                            color: theme.backgroundDarkest!.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_up_outlined,
                            color: theme.backgroundDarkest,
                            size: 21,
                          ),
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
                            Sheets.showAppHeightNineSheet(
                              context: context,
                              ref: ref,
                              widget: TransferSheet(
                                accountToken: accountFungibleToken,
                                primaryCurrency: StateContainer.of(context).curPrimaryCurrency,
                                title: localizations.transferTokens.replaceAll(
                                  '%1',
                                  accountFungibleToken.tokenInformations!.symbol!,
                                ),
                                localCurrency: StateContainer.of(context).curCurrency,
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
                        style: theme.textStyleSize12W600Primary,
                      ),
                    ],
                  ),
                  if (StateContainer.of(context).showBalance == true)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberUtil.formatThousands(
                            accountFungibleToken.amount!,
                          ),
                          style: theme.textStyleSize12W400Primary,
                        ),
                        Text(
                          accountFungibleToken.tokenInformations!.symbol!,
                          style: theme.textStyleSize12W600Primary,
                        ),
                      ],
                    )
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '···········',
                          style: theme.textStyleSize12W600Primary60,
                        ),
                        Text(
                          accountFungibleToken.tokenInformations!.symbol!,
                          style: theme.textStyleSize12W600Primary,
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
