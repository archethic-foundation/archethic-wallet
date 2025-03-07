/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/buy/layouts/buy_with_crypto_sheet.dart';
import 'package:aewallet/ui/views/buy/layouts/buy_with_fiat_sheet.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySheet extends ConsumerWidget implements SheetSkeletonInterface {
  const BuySheet({super.key});

  static const String routerPage = '/buy';

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
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: AppLocalizations.of(context)!.ucoBuyTitle,
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
    final isMainnet = ref.watch(
      environmentProvider.select(
        (value) => value == aedappfm.Environment.mainnet,
      ),
    );

    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _BuyFromWalletSection(),
        if (isMainnet) const _BuyFromCEXSection(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.ucoBuyOnDexTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: localizations.ucoBuyOnDexSubtitle,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          style: AppTextStyles.bodyLarge(context),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final itemWidth = (maxWidth - 20) / 2;
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton(
                    image: Image.asset(
                      'assets/exchanges/archethic.png',
                      height: 70,
                    ),
                    text: 'Archethic Chain',
                    onTap: () async {
                      ref.read(mainTabControllerProvider)!.animateTo(
                            2,
                            duration: Duration.zero,
                          );
                      await ref
                          .read(SettingsProviders.settings.notifier)
                          .setMainScreenCurrentPage(2);

                      context.pop();
                    },
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton.url(
                    image: Image.asset(
                      'assets/exchanges/polygon.png',
                      height: 70,
                    ),
                    text: 'Polygon Chain',
                    url:
                        'https://swap.defillama.com/?chain=polygon&from=0x3c499c542cef5e3811e1192ce70d8cc03d5c3359&tab=swap&to=0xaa53B93608C88EE55fAD8db4C504Fa20E52642aD',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton.url(
                    image: Image.asset(
                      'assets/exchanges/ethereum.png',
                      height: 70,
                    ),
                    text: 'Ethereum Chain',
                    url:
                        'https://swap.defillama.com/?chain=ethereum&from=0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48&tab=swap&to=0x1A688D3d294ee7BcC1f59011DE93d608Dc21c377',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton.url(
                    image: Image.asset(
                      'assets/exchanges/bsc.png',
                      height: 70,
                    ),
                    text: 'Binance Chain',
                    url:
                        'https://swap.defillama.com/?chain=bsc&from=0x55d398326f99059ff775485246999027b3197955&tab=swap&to=0xf1e5bbd997501a8439619266A09a54b2b499eAA3',
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BuyFromWalletSection extends ConsumerWidget {
  const _BuyFromWalletSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const onrampFeatureFlag = (fromFiat: true, fromCrypto: true);
    // final onrampFeatureFlag = ref.watch(onrampFeatureFlagProvider);
    final localizations = AppLocalizations.of(context)!;
    final environment = ref.watch(environmentProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.ucoBuyInAeWalletTitle,
          style: AppTextStyles.bodyLarge(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final itemWidth = (maxWidth - 20) / 2;
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                if (onrampFeatureFlag.fromFiat)
                  SizedBox(
                    width: itemWidth,
                    child: _ExchangeButton(
                      image: Image.asset(
                        'assets/exchanges/aewallet_fiat.png',
                        height: 70,
                      ),
                      text: localizations.ucoBuyInAeWalletWithFiat,
                      onTap: () {
                        context.push(BuyWithFiatSheet.routerPage);
                      },
                    ),
                  )
                else if (environment == aedappfm.Environment.testnet)
                  SizedBox(
                    width: itemWidth,
                    child: _ExchangeButton(
                      image: Icon(
                        Symbols.call_received,
                        opticalSize: 10,
                        color: aedappfm.AppThemeBase.secondaryColor,
                        size: 70,
                      ),
                      text: localizations.faucet,
                      onTap: () async {
                        await launchUrl(
                          Uri.parse(
                            '${ref.read(environmentProvider).endpoint}/faucet',
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                if (onrampFeatureFlag.fromCrypto)
                  SizedBox(
                    width: itemWidth,
                    child: _ExchangeButton(
                      image: Image.asset(
                        'assets/exchanges/aewallet_crypto.png',
                        height: 70,
                      ),
                      text: localizations.ucoBuyInAeWalletWithCrypto,
                      onTap: () {
                        context.push(BuyWithCryptoSheet.routerPage);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _BuyFromCEXSection extends ConsumerWidget {
  const _BuyFromCEXSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.ucoBuyOnCexTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: localizations.ucoBuyOnCexSubtitle,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          style: AppTextStyles.bodyLarge(context),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final itemWidth = (maxWidth - 20) / 2;
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton.url(
                    image: Image.asset(
                      'assets/exchanges/mexc.png',
                      height: 70,
                    ),
                    text: 'MEXC Exchange',
                    url:
                        'https://www.mexc.com/exchange/UCO_USDT?_from=search_spot_trade',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ExchangeButton.url(
                    image: SvgPicture.asset(
                      'assets/exchanges/probit.svg',
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4231C8),
                        BlendMode.srcIn,
                      ),
                      height: 70,
                    ),
                    text: 'ProBit Exchange',
                    url: 'https://www.probit.com/app/exchange/UCO-USDT',
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _ExchangeButton extends StatelessWidget {
  const _ExchangeButton({
    required this.image,
    required this.text,
    required this.onTap,
  });

  factory _ExchangeButton.url({
    required Widget image,
    required String text,
    required String url,
  }) =>
      _ExchangeButton(
        image: image,
        text: text,
        onTap: () {
          launchUrl(Uri.parse(url));
        },
      );

  final Widget image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ArchethicTheme.backgroundRecentTxListCardTransferOutput,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ArchethicTheme.backgroundRecentTxListCardTokenCreation
                    .withOpacity(0.3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image,
                const SizedBox(height: 8),
                Text(
                  text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
