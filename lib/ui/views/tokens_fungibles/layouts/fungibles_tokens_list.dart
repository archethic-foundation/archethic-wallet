/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FungiblesTokensListWidget extends ConsumerWidget {
  const FungiblesTokensListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final fungibleTokensAsyncValue = ref.watch(
          AccountProviders.selectedAccount
              .select((value) => value.valueOrNull?.accountTokens),
        ) ??
        [];
    final theme = ref.watch(ThemeProviders.selectedTheme);
    if (fungibleTokensAsyncValue.isEmpty == true) {
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 6),
          child: Card(
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
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(
                    UiIcons.about,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    localizations.fungiblesTokensListNoTokenYet,
                    style: theme.textStyleSize12W100Primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final accountToken in fungibleTokensAsyncValue)
          _FungiblesTokensLine(
            accountToken: accountToken,
          )
      ],
    );
  }
}

class _FungiblesTokensLine extends StatelessWidget {
  const _FungiblesTokensLine({
    required this.accountToken,
  });

  final AccountToken accountToken;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 6),
        child: _FungiblesTokensDetailTransfer(
          accountFungibleToken: accountToken,
        ),
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalization.of(context)!;
    return Column(
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.backgroundDark!.withOpacity(0.3),
                              border: Border.all(
                                color:
                                    theme.backgroundDarkest!.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_circle_up_outlined,
                                color: theme.backgroundDarkest,
                                size: 21,
                              ),
                              onPressed: () async {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );
                                await TransferSheet(
                                  transferType: TransferType.token,
                                  accountToken: accountFungibleToken,
                                  recipient: const TransferRecipient.address(
                                    address: Address(address: ''),
                                  ),
                                ).show(
                                  context: context,
                                  ref: ref,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              accountFungibleToken.tokenInformations!.name!,
                              style: theme.textStyleSize12W600Primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (preferences.showBalances == true)
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
                      ),
                  ],
                ),
                if (kTokenFordiddenName.contains(
                      accountFungibleToken.tokenInformations!.name!
                          .toUpperCase(),
                    ) ||
                    kTokenFordiddenName.contains(
                      accountFungibleToken.tokenInformations!.symbol!
                          .toUpperCase(),
                    ))
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          UiIcons.warning,
                          size: 10,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          localizations.notOfficialUCOWarning,
                          style: theme.textStyleSize10W100Primary,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
