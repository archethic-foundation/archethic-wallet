import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroBackupSeedPassPopup extends ConsumerWidget {
  const IntroBackupSeedPassPopup(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return aedappfm.PopupTemplate(
      popupContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.backupSeedPassDesc1,
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: BtnPrimary(
                  buttonText: localizations.cancel,
                  onTap: () => context.pop(),
                  btnPrimaryType: BtnPrimaryType.outlinePrimary,
                  widthExpanded: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: BtnPrimary(
                  buttonText: localizations.confirm,
                  onTap: () async {
                    ref.read(
                      RecoveryPhraseSavedProvider.setRecoveryPhraseSaved(false),
                    );
                    await context.push(
                      IntroConfigureSecurity.routerPage,
                      extra: {
                        'name': name,
                        'isImportProfile': false,
                      },
                    );
                  },
                  widthExpanded: true,
                ),
              ),
            ],
          ),
        ],
      ),
      popupTitle: localizations.passBackupConfirmationDisclaimer,
      displayCloseButton: false,
    );
  }
}
