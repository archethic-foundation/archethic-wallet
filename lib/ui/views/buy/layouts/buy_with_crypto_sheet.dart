/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/buy/bloc/buy_with_crypto_form_provider.dart';
import 'package:aewallet/ui/views/buy/layouts/components/chain_dropdown.dart';
import 'package:aewallet/ui/views/buy/layouts/components/deposit_address_bloc.dart';
import 'package:aewallet/ui/views/buy/layouts/components/token_dropdown.dart';
import 'package:aewallet/ui/views/buy/layouts/components/transaction_history.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BuyWithCryptoSheet extends ConsumerWidget {
  const BuyWithCryptoSheet({
    super.key,
  });
  static const String routerPage = '/buy_with_crypto';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.onrampWithCryptoTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final shouldShowDepositAddress = ref.watch(
      buyWithCryptoFormProvider.select((state) {
        return state.valueOrNull?.depositAddressVisible ?? false;
      }),
    );
    final canShowDepositAddress = ref.watch(
      buyWithCryptoFormProvider.select((state) {
        return state.valueOrNull?.canShowDepositAddress ?? false;
      }),
    );
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
              Text(
                localizations.onrampWithCryptoSelectTokenTitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeightTelegraf.fontWeightBold,
                    ),
              ),
              const SizedBox(height: 10),
              const TokenDropdown(),
              const SizedBox(height: 10),
              Text(
                localizations.onrampWithCryptoSelectChainTitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeightTelegraf.fontWeightBold,
                    ),
              ),
              const SizedBox(height: 10),
              const ChainDropdown(),
              const SizedBox(height: 30),
              switch (shouldShowDepositAddress) {
                false => BtnFooterPrimary(
                    buttonText:
                        localizations.onrampWithCryptoShowDepositAddress,
                    isLocked: !canShowDepositAddress,
                    onTap: () async {
                      ref
                          .read(buyWithCryptoFormProvider.notifier)
                          .showDepositAddress();
                    },
                  ),
                true => const DepositAddressBloc(),
              },
              const SizedBox(height: 30),
              const OnRampTransactionHistory(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
