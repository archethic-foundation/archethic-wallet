import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthentificationMethodDialogHelp {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;

        return aedappfm.PopupTemplate(
          popupContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ArchethicScrollbar(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildAuthMethodContent(context),
                ),
              ),
              const SizedBox(height: 20),
              BtnPrimary(
                key: const Key('closeButton'),
                buttonText: localizations.close,
                onTap: () => context.pop(),
                widthExpanded: true,
              ),
            ],
          ),
          popupTitle: localizations.information,
          displayCloseButton: false,
        );
      },
    );
  }

  static List<Widget> _buildAuthMethodContent(BuildContext context) {
    final authMethods = kIsWeb
        ? [AuthMethod.password]
        : [
            AuthMethod.pin,
            AuthMethod.password,
            AuthMethod.biometrics,
            AuthMethod.yubikeyWithYubicloud,
          ];

    return authMethods.map((method) {
      final authMethod = AuthenticationMethod(method);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            authMethod.getDisplayName(context),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeightTelegraf.fontWeightBold,
                ),
          ),
          Text(
            authMethod.getDescription(context),
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }
}
