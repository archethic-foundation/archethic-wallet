import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexPriceImpact extends StatelessWidget {
  const DexPriceImpact({
    required this.priceImpact,
    this.withLabel = true,
    this.withOpacity = true,
    this.textStyle,
    super.key,
  });

  final double priceImpact;
  final bool? withLabel;
  final TextStyle? textStyle;
  final bool withOpacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: withOpacity ? AppTextStyles.kOpacityText : 1,
      child: Row(
        children: [
          if (withLabel!)
            SelectableText(
              '${AppLocalizations.of(context)!.priceImpact} ${priceImpact.formatNumber()}%',
              style: priceImpact > 5
                  ? textStyle?.copyWith(
                        color: aedappfm.ArchethicThemeBase.systemDanger500,
                      ) ??
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: aedappfm.ArchethicThemeBase.systemDanger500,
                          )
                  : priceImpact > 1
                      ? textStyle?.copyWith(
                            color: aedappfm.ArchethicThemeBase.systemWarning600,
                          ) ??
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: aedappfm
                                    .ArchethicThemeBase.systemWarning600,
                              )
                      : textStyle ?? AppTextStyles.bodyLarge(context),
            )
          else
            SelectableText(
              '${priceImpact.formatNumber()}%',
              style: priceImpact > 5
                  ? textStyle?.copyWith(
                        color: aedappfm.ArchethicThemeBase.systemDanger500,
                      ) ??
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: aedappfm.ArchethicThemeBase.systemDanger500,
                          )
                  : priceImpact > 1
                      ? textStyle?.copyWith(
                            color: aedappfm.ArchethicThemeBase.systemWarning600,
                          ) ??
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: aedappfm
                                    .ArchethicThemeBase.systemWarning600,
                              )
                      : textStyle ?? AppTextStyles.bodyLarge(context),
            ),
          if (priceImpact > 1)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Tooltip(
                message: AppLocalizations.of(context)!.priceImpactHighTooltip,
                child: Icon(
                  Icons.warning,
                  color: priceImpact > 5
                      ? aedappfm.ArchethicThemeBase.systemDanger500
                      : aedappfm.ArchethicThemeBase.systemWarning600,
                  size: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
