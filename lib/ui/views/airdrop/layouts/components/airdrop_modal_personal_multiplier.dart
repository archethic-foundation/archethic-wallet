import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_step_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropModalPersonalMultiplier extends ConsumerWidget {
  const AirdropModalPersonalMultiplier({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return Stack(
      children: [
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () async {
              context.pop();
            },
            icon: const Icon(
              Symbols.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ArchethicScrollbar(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: 120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizations.airdropPersonalMultiplierTableTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeightTelegraf.fontWeightBold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      localizations.airdropPersonalMultiplierTableDesc,
                      style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                    ),
                    const SizedBox(height: 30),
                    aedappfm.BlockInfo(
                      width: MediaQuery.of(context).size.width,
                      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
                      paddingEdgeInsetsInfo: const EdgeInsets.all(10),
                      blockInfoColor: aedappfm.BlockInfoColor.neutral,
                      info: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localizations.airdropPersonalMultiplierTableLPValue,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '\$${airdropForm.actualLPFiatValue.formatNumber(precision: 2)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeightTelegraf.fontWeightBold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    aedappfm.BlockInfo(
                      width: MediaQuery.of(context).size.width,
                      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
                      paddingEdgeInsetsInfo: const EdgeInsets.all(10),
                      blockInfoColor: aedappfm.BlockInfoColor.neutral,
                      info: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localizations
                                .airdropPersonalMultiplierTableYourLPValue,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            '${airdropForm.personalLP.formatNumber(precision: 2)}\n${_lpIndollarsCalculation(airdropForm.actualLPFiatValue, airdropForm.personalLP)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeightTelegraf.fontWeightBold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AirdropPersonalStepTab(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: BtnFooterPrimary(
              buttonText: localizations.airdropPersonalMultiplierTableHeaderBtn,
              onTap: () async {
                await ref
                    .read(SettingsProviders.settings.notifier)
                    .setMainScreenCurrentPage(3);
                ref.read(mainTabControllerProvider)!.animateTo(
                      3,
                      duration: Duration.zero,
                    );
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }

  String _lpIndollarsCalculation(double lpValue, double amount) {
    return '(\$${(Decimal.parse(amount.toString()) * Decimal.parse(lpValue.toString())).toDouble().formatNumber(precision: 2)})';
  }
}
