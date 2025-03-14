import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_modal_invitation.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AirdropBlocInvitation extends ConsumerWidget {
  const AirdropBlocInvitation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Stack(
            children: [
              aedappfm.BlockInfo(
                borderWidth: 0,
                paddingEdgeInsetsClipRRect: EdgeInsets.zero,
                paddingEdgeInsetsInfo: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                info: Stack(
                  children: [
                    _buildBackgroundImage(),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            localizations.airdropDashboardBlocInvitationTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeightTelegraf.fontWeightBold,
                                ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            localizations.airdropDashboardBlocInvitationDesc1,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.center,
                            localizations.airdropDashboardBlocInvitationDesc2,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmallWithOpacity
                                .copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          const SizedBox(height: 20),
                          BtnPrimary(
                            buttonText:
                                localizations.airdropDashboardBlocInvitationBtn,
                            onTap: () async {
                              await CupertinoScaffold
                                  .showCupertinoModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return FractionallySizedBox(
                                    heightFactor: 1,
                                    child: Scaffold(
                                      backgroundColor: aedappfm
                                          .AppThemeBase.sheetBackground
                                          .withValues(alpha: 0.2),
                                      body: const AirdropModalInvitation(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      top: -100,
      left: -400,
      child: Transform.rotate(
        angle: -10 * 3.14 / 180,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/themes/archethic/logo_crystal.png',
            ),
          ),
        ),
      ),
    );
  }
}
