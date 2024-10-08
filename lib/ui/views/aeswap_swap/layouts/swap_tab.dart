import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_confirm_sheet.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_info.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_settings.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_textfield_token_swapped_amount.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapTab extends ConsumerStatefulWidget {
  const SwapTab({
    this.tokenToSwap,
    this.tokenSwapped,
    this.from,
    this.to,
    this.value,
    super.key,
  });

  final DexToken? tokenToSwap;
  final DexToken? tokenSwapped;
  final String? from;
  final String? to;
  final double? value;

  @override
  ConsumerState<SwapTab> createState() => SwapTabState();
}

class SwapTabState extends ConsumerState<SwapTab> {
  @override
  void initState() {
    Future(() async {
      try {
        if (widget.value != null) {
          ref.read(swapFormNotifierProvider.notifier)
            ..setTokenFormSelected(1)
            ..setTokenToSwapAmountWithoutCalculation(widget.value!);
        }

        if (widget.from != null) {
          DexToken? _tokenToSwap;
          if (widget.from != 'UCO') {
            _tokenToSwap = await ref.read(
              DexTokensProviders.getTokenFromAddress(widget.from).future,
            );
          } else {
            _tokenToSwap = DexToken.uco();
          }
          if (_tokenToSwap != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenToSwap(_tokenToSwap);
          }
        } else {
          if (widget.tokenToSwap != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenToSwap(widget.tokenToSwap!);
          }
        }

        if (widget.to != null) {
          DexToken? _tokenSwapped;
          if (widget.to != 'UCO') {
            _tokenSwapped = await ref.read(
              DexTokensProviders.getTokenFromAddress(widget.to).future,
            );
          } else {
            _tokenSwapped = DexToken.uco();
          }
          if (_tokenSwapped != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenSwapped(_tokenSwapped);
          }
        } else {
          if (widget.tokenSwapped != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenSwapped(widget.tokenSwapped!);
          }
        }

        if (widget.value != null) {
          ref.read(swapFormNotifierProvider.notifier).setTokenFormSelected(2);
        }
        // ignore: empty_catches
      } catch (e) {}
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final swap = ref.watch(swapFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ArchethicScrollbar(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10,
                        bottom: 80,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SwapTokenToSwapAmount(),
                                const SwapTokenSwappedAmount(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          SwapTokenIconInfo(),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SelectableText(
                                            '${AppLocalizations.of(context)!.slippage_tolerance} ${swap.slippageTolerance}%',
                                            style: AppTextStyles.bodyMedium(
                                              context,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Align(
                                            alignment: Alignment.centerRight,
                                            child: SwapTokenIconSettings(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (swap.messageMaxHalfUCO)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: SizedBox(
                                      child: aedappfm.InfoBanner(
                                        AppLocalizations.of(context)!
                                            .swapMessageMaxHalfUCO
                                            .replaceFirst(
                                              '%1',
                                              swap.feesEstimatedUCO
                                                  .formatNumber(precision: 8),
                                            ),
                                        aedappfm.InfoBannerType.request,
                                      ),
                                    ),
                                  ),
                                aedappfm.ErrorMessage(
                                  failure: swap.failure,
                                  failureMessage: FailureMessage(
                                    context: context,
                                    failure: swap.failure,
                                  ).getMessage(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.btn_swap,
                    Dimens.buttonBottomDimens,
                    key: const Key('swap'),
                    onPressed: () async {
                      final controlOk = await ref
                          .read(
                            swapFormNotifierProvider.notifier,
                          )
                          .validateForm(AppLocalizations.of(context)!);

                      if (controlOk) {
                        await context.push(SwapConfirmFormSheet.routerPage);
                      }
                    },
                    disabled: !swap.isControlsOk,
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
