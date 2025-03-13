/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/onramp/banxa.dart';
import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/buy/bloc/buy_with_fiat_form_provider.dart';
import 'package:aewallet/ui/views/buy/layouts/components/banxa_on_ramp_sheet.dart';
import 'package:aewallet/ui/views/buy/layouts/components/checkbox_confirm.dart';
import 'package:aewallet/ui/views/buy/layouts/components/transaction_history.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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
    final onrampFavoriteSetup =
        ref.watch(onrampProviderFavoriteSetupProvider('banxa')).valueOrNull;

    final isWebviewSupported = ref.watch(isBanxaWebviewSupportedProvider);

    return BtnFooterPrimary(
      buttonText: localizations.onrampWithFiatBuyNowButton,
      key: const Key('buyNow'),
      isLocked: onrampFavoriteSetup == null ||
          depositAddress == null ||
          !ref.watch(buyWithFiatFormProvider).disclaimerAcknowledged,
      showProgressIndicator: onrampFavoriteSetup == null,
      onTap: () async => switch (onrampFavoriteSetup) {
        null => null,
        final setup => _goToBanxa(
            context: context,
            ref: ref,
            isWebviewSupported: isWebviewSupported,
            depositAddress: depositAddress!,
            chainId: setup.chainId,
            tokenId: setup.tokenId,
          )
      },
    );
  }

  Future<void> _goToBanxa({
    required BuildContext context,
    required WidgetRef ref,
    required bool isWebviewSupported,
    required String depositAddress,
    required String chainId,
    required String tokenId,
  }) async {
    if (isWebviewSupported) {
      return context.push<void>(
        BanxaOnRampSheet.routerPage,
        extra: {
          'depositAddress': depositAddress,
          'tokenId': tokenId,
          'chainId': chainId,
        },
      );
    }

    await launchUrl(
      ref.read(
        banxaWebpageUriProvider(
          tokenId: tokenId,
          chainId: chainId,
          depositAddress: depositAddress,
        ),
      ),
    );
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
    final form = ref.watch(buyWithFiatFormProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ArchethicScrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.onrampWithFiatHowDoesItWorkTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              const SizedBox(height: 10),
              Text(
                localizations.onrampWithFiatHowDoesItWorkBody,
                style: Theme.of(context).textTheme.bodyMediumWithOpacity,
              ),
              const SizedBox(height: 20),
              CheckboxConfirm(
                onChanged: ref
                    .read(buyWithFiatFormProvider.notifier)
                    .acknowledgeDisclaimer,
                value: form.disclaimerAcknowledged,
                text: localizations.onrampWithFiatDisclaimer,
              ),
              const SizedBox(height: 30),
              OnRampTransactionHistory(
                Text(
                  localizations.onrampFiatHistoryFooter1,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
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
