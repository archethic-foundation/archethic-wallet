import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceIndicatorWidget extends ConsumerWidget {
  const BalanceIndicatorWidget({
    super.key,
    this.displayLabel = true,
  });

  final bool displayLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;

    return preferences.showBalances
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (displayLabel)
                    Text(
                      '${localizations.ucoBalance}: ',
                      style: ArchethicThemeStyles.textStyleSize14W200Primary,
                    ),
                ],
              ),
              Row(
                children: [
                  const _BalanceIndicatorNative(
                    primary: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      '/',
                      style: ArchethicThemeStyles.textStyleSize14W200Primary,
                    ),
                  ),
                  const _BalanceIndicatorFiat(
                    primary: false,
                  ),
                ],
              ),
            ],
          )
        : const SizedBox();
  }
}

class _BalanceIndicatorFiat extends ConsumerWidget {
  const _BalanceIndicatorFiat({
    required this.primary,
  });

  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archethicOracleUCO = ref
        .watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO)
        .valueOrNull;

    final balanceUCO =
        ref.watch(getBalanceProvider(kUCOAddress)).valueOrNull ?? 0.0;

    final fiatValue = archethicOracleUCO?.usd ?? 0 * balanceUCO;

    return Text(
      NumberUtil.formatThousandsStr(
        CurrencyUtil.format(
          fiatValue,
        ),
      ),
      style: ArchethicThemeStyles.textStyleSize14W200Primary,
    );
  }
}

class _BalanceIndicatorNative extends ConsumerWidget {
  const _BalanceIndicatorNative({
    required this.primary,
  });

  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceUCO =
        ref.watch(getBalanceProvider(kUCOAddress)).valueOrNull ?? 0.0;

    return Text(
      '${balanceUCO.formatNumber(precision: balanceUCO < 1 ? 8 : 2)} ${aedappfm.ucoToken.symbol}',
      style: ArchethicThemeStyles.textStyleSize14W200Primary,
    );
  }
}
