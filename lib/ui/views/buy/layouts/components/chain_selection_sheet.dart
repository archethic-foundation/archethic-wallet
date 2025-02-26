import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/buy/bloc/buy_with_crypto_form_provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ChainSelectionSheet extends ConsumerWidget {
  const ChainSelectionSheet({
    super.key,
    required this.onSelect,
    required this.selectedToken,
  });

  final void Function(OnRampChain? chain) onSelect;
  final OnRampTokenDisplayData selectedToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final chains = ref
        .watch(onrampChainsForTokenProvider(selectedToken.symbol))
        .valueOrNull;

    if (chains == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              localizations.onrampWithCryptoSelectChainTitle,
              style: AppTextStyles.bodyLarge(context)
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            spacing: 10,
            children: chains.map((token) {
              return _ChainSelector(
                key: ValueKey(token),
                chain: token,
                onTap: () {
                  onSelect(token);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ChainSelector extends StatelessWidget {
  const _ChainSelector({
    super.key,
    required this.chain,
    required this.onTap,
  });

  final OnRampChain chain;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: 150,
      height: 35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.4),
            aedappfm.AppThemeBase.sheetBackgroundTertiary,
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              aedappfm.AppThemeBase.sheetBorderTertiary.withOpacity(0.4),
              aedappfm.AppThemeBase.sheetBorderTertiary,
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            if (chain.iconUrl != '')
              Image.network(
                chain.iconUrl,
                width: 20,
              )
            else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    chain.name,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
