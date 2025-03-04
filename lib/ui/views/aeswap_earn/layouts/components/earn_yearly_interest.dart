import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EarnYearlyInterest extends ConsumerWidget {
  const EarnYearlyInterest({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;

    return BoxDark(
      textWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (farmLock != null && farmLock.apr3years > 0)
            Text(
              '${(farmLock.apr3years * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            )
          else
            Text(
              '__%',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            ),
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 10),
            child: GradientIcon(
              icon: Icon(
                Symbols.info,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      additionalWidget: Text(
        localizations.earnTotalYearlyInterest,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
        textAlign: TextAlign.center,
      ),
      onTap: () async {
        await CupertinoScaffold.showCupertinoModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 1,
              child: Scaffold(
                backgroundColor:
                    aedappfm.AppThemeBase.sheetBackground.withOpacity(0.2),
                body: const FarmLockDetailsInfo(),
              ),
            );
          },
        );
      },
    );
  }
}
