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
    final textStyle = Theme.of(context).textTheme.bodySmallWithOpacity;
    final boldTextStyle = textStyle.copyWith(
      fontWeight: FontWeightTelegraf.fontWeightBold,
    );

    return aedappfm.PopupTemplate(
      popupContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRichText(
            localizations.backupSeedPassDesc1,
            localizations.backupSeedPassDesc2,
            localizations.backupSeedPassDesc3,
            textStyle,
            boldTextStyle,
          ),
          const SizedBox(height: 10),
          _buildRichText(
            localizations.backupSeedPassDesc4,
            localizations.backupSeedPassDesc5,
            null,
            boldTextStyle,
            textStyle,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BtnPrimary(
                buttonText: localizations.cancel,
                onTap: () => context.pop(),
                btnPrimaryType: BtnPrimaryType.outlinePrimary,
              ),
              BtnPrimary(
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
              ),
            ],
          ),
        ],
      ),
      popupTitle: localizations.passBackupConfirmationDisclaimer,
      displayCloseButton: false,
    );
  }

  Widget _buildRichText(
    String text1,
    String text2,
    String? text3,
    TextStyle textStyle,
    TextStyle boldTextStyle,
  ) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text1, style: textStyle),
          TextSpan(text: text2, style: boldTextStyle),
          if (text3 != null) TextSpan(text: text3, style: textStyle),
        ],
      ),
    );
  }
}
