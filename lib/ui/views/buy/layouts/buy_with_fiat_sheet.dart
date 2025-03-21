/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/numbered_list/numbered_list_item.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/buy/layouts/components/transaction_history.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyWithFiatSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const BuyWithFiatSheet({
    super.key,
  });
  static const String routerPage = '/buy_with_fiat';
  static const selectedProvider = OnRampProvider.transak;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final depositAddress = ref.watch(onrampDepositAddressProvider).valueOrNull;
    final onrampSelectedToken = ref
        .watch(onrampProviderFavoriteTokenProvider(selectedProvider))
        .valueOrNull;

    return BtnFooterPrimary(
      buttonText: localizations.onrampWithFiatBuyNowButton,
      key: const Key('buyNow'),
      isLocked: onrampSelectedToken == null || depositAddress == null,
      showProgressIndicator: onrampSelectedToken == null,
      onTap: () async => switch (onrampSelectedToken) {
        null => null,
        final token => _goToCheckout(
            context: context,
            ref: ref,
            depositAddress: depositAddress!,
            token: token,
          )
      },
    );
  }

  Future<void> _goToCheckout({
    required BuildContext context,
    required WidgetRef ref,
    required String depositAddress,
    required OnRampProviderToken token,
  }) async {
    final uri = ref
        .read(onrampProviderRepositoryProvider(selectedProvider))
        .checkoutUri(
          depositAddress: depositAddress,
          chainId: token.chain.providerChainId,
          tokenId: token.providerTokenId,
        );
    await launchUrl(uri);
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.onrampWithFiatTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final selectedToken = ref
        .watch(
          onrampProviderFavoriteTokenProvider(selectedProvider),
        )
        .valueOrNull;

    final feeRate = switch (selectedToken) {
      null => null,
      OnRampProviderToken _ => ref.watch(
          onrampEvmSetupProvider.select(
            (setup) => setup.valueOrNull
                ?.findChain(selectedToken.chain.chainId)
                ?.feeRate,
          ),
        )
    };

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ArchethicScrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.onrampWithFiatHowDoesItWorkTitle,
                style: textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              const SizedBox(height: 10),
              Text(
                localizations.onrampWithFiatHowDoesItWorkBody,
                style: textTheme.bodyMediumWithOpacity,
              ),
              const SizedBox(height: 30),
              NumberedListItem(
                index: 1,
                content: EasyRichText(
                  localizations.onrampWithFiatHowDoesItWork1,
                  defaultStyle: textTheme.bodyMediumWithOpacity,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'ETH',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              NumberedListItem(
                index: 2,
                content: EasyRichText(
                  localizations.onrampWithFiatHowDoesItWork2(
                    feeRate == null ? '--' : (feeRate * 100).round().toString(),
                  ),
                  defaultStyle: textTheme.bodyMediumWithOpacity,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'ETH',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    EasyRichTextPattern(
                      targetString: 'UCO',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              NumberedListItem(
                index: 3,
                content: EasyRichText(
                  localizations.onrampWithFiatHowDoesItWork3,
                  defaultStyle: textTheme.bodyMediumWithOpacity,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'UCO',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              OnRampTransactionHistory(
                Text(
                  localizations.onrampFiatHistoryFooter1,
                  style: textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
