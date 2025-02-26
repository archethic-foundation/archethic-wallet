import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class DepositAddressBloc extends ConsumerWidget {
  const DepositAddressBloc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final poolMaxAmount = ref.watch(onrampMaxAmountProvider).valueOrNull;
    final address = ref.watch(onrampDepositAddressProvider).valueOrNull;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.onrampWithCryptoDepositAddressTitle,
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: aedappfm.AppThemeBase.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: address == null
                    ? null
                    : () async {
                        await Clipboard.setData(
                          ClipboardData(text: address),
                        );
                        UIUtil.showSnackbar(
                          localizations.addressCopied,
                          context,
                          ref,
                          ArchethicTheme.text,
                          ArchethicTheme.snackBarShadow,
                          icon: Symbols.info,
                        );
                      },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          address ?? '0x---',
                          style: AppTextStyles.bodyMedium(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Symbols.copy_all,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                style: AppTextStyles.bodyMedium(context)
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: localizations.onrampWithCryptoPoolAmount1,
                  ),
                  TextSpan(
                    text: '$poolMaxAmount ETH ',
                    style: TextStyle(
                      color: aedappfm.AppThemeBase.secondaryColor,
                    ),
                  ),
                  TextSpan(
                    text: localizations.onrampWithCryptoPoolAmount2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        localizations.onrampWithCryptoTreatmentDelayDisclaimer1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        localizations.onrampWithCryptoTreatmentDelayDisclaimer2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
