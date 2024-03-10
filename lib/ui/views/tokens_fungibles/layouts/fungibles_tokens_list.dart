/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/tokens/verified_token_icon.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class FungiblesTokensListWidget extends ConsumerWidget {
  const FungiblesTokensListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final fungibleTokensAsyncValue = ref.watch(
          AccountProviders.selectedAccount
              .select((value) => value.valueOrNull?.accountTokens),
        ) ??
        [];

    var index = 0;
    if (fungibleTokensAsyncValue.isEmpty == true) {
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: ArchethicTheme.backgroundFungiblesTokensListCard,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: ArchethicTheme.backgroundFungiblesTokensListCard,
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(
                    Symbols.info,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localizations.fungiblesTokensListNoTokenYet,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
      children: fungibleTokensAsyncValue.map((accountToken) {
        index++;
        return _FungiblesTokensLine(
          accountToken: accountToken,
        )
            .animate(delay: (100 * index).ms)
            .fadeIn(duration: 400.ms, delay: 200.ms)
            .move(
              begin: const Offset(-16, 0),
              curve: Curves.easeOutQuad,
            );
      }).toList(),
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
        padding: const EdgeInsets.only(top: 15),
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
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: aedappfm.AppThemeBase.sheetBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: aedappfm.AppThemeBase.sheetBorder,
                ),
              ),
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
                                  color: ArchethicTheme.backgroundDark
                                      .withOpacity(0.3),
                                  border: Border.all(
                                    color: ArchethicTheme.backgroundDarkest
                                        .withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Symbols.arrow_circle_up,
                                    color: ArchethicTheme.backgroundDarkest,
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
                                      recipient:
                                          const TransferRecipient.address(
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
                                child: InkWell(
                                  key: const Key('viewExplorer'),
                                  onTap: () {
                                    UIUtil.showWebview(
                                      context,
                                      '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${accountFungibleToken.tokenInformation!.address!}',
                                      '',
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              accountFungibleToken
                                                  .tokenInformation!.name!,
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W100Primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AutoSizeText(
                                            AddressFormatters(
                                              accountFungibleToken
                                                  .tokenInformation!.address!,
                                            ).getShortString4(),
                                            style: ArchethicThemeStyles
                                                .textStyleSize12W100Primary,
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Symbols.open_in_new,
                                            size: 11,
                                          ),
                                        ],
                                      ),
                                      if (preferences.showBalances == true)
                                        Row(
                                          children: [
                                            Text(
                                              NumberUtil.formatThousands(
                                                accountFungibleToken.amount!,
                                              ),
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W100Primary,
                                            ),
                                            const SizedBox(width: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  accountFungibleToken
                                                      .tokenInformation!
                                                      .symbol!,
                                                  style: ArchethicThemeStyles
                                                      .textStyleSize12W100Primary,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                VerifiedTokenIcon(
                                                  address: accountFungibleToken
                                                      .tokenInformation!
                                                      .address!,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      else
                                        Row(
                                          children: [
                                            Text(
                                              '···········',
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W100Primary60,
                                            ),
                                            const SizedBox(width: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  accountFungibleToken
                                                      .tokenInformation!
                                                      .symbol!,
                                                  style: ArchethicThemeStyles
                                                      .textStyleSize12W100Primary,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                VerifiedTokenIcon(
                                                  address: accountFungibleToken
                                                      .tokenInformation!
                                                      .address!,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      if (kTokenFordiddenName.contains(
                                            accountFungibleToken
                                                .tokenInformation!.name!
                                                .toUpperCase(),
                                          ) ||
                                          kTokenFordiddenName.contains(
                                            accountFungibleToken
                                                .tokenInformation!.symbol!
                                                .toUpperCase(),
                                          ))
                                        Row(
                                          children: [
                                            const Icon(
                                              Symbols.warning,
                                              size: 10,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              localizations
                                                  .notOfficialUCOWarning,
                                              style: ArchethicThemeStyles
                                                  .textStyleSize10W100Primary,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
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
        ),
      ],
    );
  }
}
