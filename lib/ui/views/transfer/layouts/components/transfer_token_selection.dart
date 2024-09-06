/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_tokens_list.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TransferTokenSelection extends ConsumerWidget {
  const TransferTokenSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final preferences = ref.watch(SettingsProviders.settings);

    return Container(
      width: aedappfm.Responsive.isMobile(context) ? 100 : 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          aedappfm.sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );

          final tokenSelected = await showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.black.withOpacity(0.1),
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.85,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            aedappfm.sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                          },
                          child: Text(
                            localizations.selectTokenTitle,
                            style:
                                ArchethicThemeStyles.textStyleSize16W600Primary,
                          ),
                        ),
                      ),
                      const TransferTokensList(),
                    ],
                  ),
                ),
              );
            },
          );
          ref
              .read(TransferFormProvider.transferForm.notifier)
              .setAEToken(context, tokenSelected);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                if (transfer.aeToken == null)
                  Text(
                    AppLocalizations.of(context)!.btn_selectToken,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: SizedBox(
                      width: 90,
                      child: Row(
                        children: [
                          if (transfer.aeToken!.isLpToken == false)
                            if (transfer.aeToken!.icon != null)
                              SvgPicture.asset(
                                'assets/bc-logos/${transfer.aeToken!.icon}',
                                width: 20,
                                height: 20,
                              ),
                          if (transfer.aeToken!.isLpToken == false)
                            const SizedBox(
                              width: 10,
                            ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                transfer.aeToken!.isLpToken == false
                                    ? transfer.aeToken!.symbol
                                    : '${transfer.aeToken!.lpTokenPair!.token1.symbol.reduceSymbol()}/${transfer.aeToken!.lpTokenPair!.token2.symbol.reduceSymbol()}',
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
