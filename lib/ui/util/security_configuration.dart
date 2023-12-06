import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin SecurityConfigurationMixin {
  Future<bool> launchSecurityConfiguration(
    BuildContext context,
    WidgetRef ref,
    String seed,
    String fromPage,
  ) async {
    final biometricsAvalaible = await sl.get<BiometricUtil>().hasBiometrics();

    var accessModes = <PickerItem>[];
    if (kIsWeb) {
      accessModes = <PickerItem>[
        PickerItem(
          const AuthenticationMethod(AuthMethod.password)
              .getDisplayName(context),
          null,
          AuthenticationMethod.getIcon(AuthMethod.password),
          ArchethicTheme.pickerItemIconEnabled,
          AuthMethod.password,
          true,
          key: const Key('accessModePassword'),
        ),
      ];
    } else {
      accessModes = <PickerItem>[
        PickerItem(
          const AuthenticationMethod(AuthMethod.pin).getDisplayName(context),
          null,
          AuthenticationMethod.getIcon(AuthMethod.pin),
          ArchethicTheme.pickerItemIconEnabled,
          AuthMethod.pin,
          true,
          key: const Key('accessModePIN'),
        ),
        PickerItem(
          const AuthenticationMethod(AuthMethod.password)
              .getDisplayName(context),
          null,
          AuthenticationMethod.getIcon(AuthMethod.password),
          ArchethicTheme.pickerItemIconEnabled,
          AuthMethod.password,
          true,
          key: const Key('accessModePassword'),
        ),
      ];
      if (biometricsAvalaible) {
        accessModes.add(
          PickerItem(
            const AuthenticationMethod(AuthMethod.biometrics)
                .getDisplayName(context),
            null,
            AuthenticationMethod.getIcon(AuthMethod.biometrics),
            ArchethicTheme.pickerItemIconEnabled,
            AuthMethod.biometrics,
            true,
          ),
        );
      }
      accessModes
        ..add(
          PickerItem(
            const AuthenticationMethod(AuthMethod.biometricsUniris)
                .getDisplayName(context),
            null,
            AuthenticationMethod.getIcon(AuthMethod.biometricsUniris),
            ArchethicTheme.pickerItemIconEnabled,
            AuthMethod.biometricsUniris,
            false,
          ),
        )
        ..add(
          PickerItem(
            const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
                .getDisplayName(context),
            null,
            AuthenticationMethod.getIcon(AuthMethod.yubikeyWithYubicloud),
            ArchethicTheme.pickerItemIconEnabled,
            AuthMethod.yubikeyWithYubicloud,
            true,
          ),
        );
    }

    // TODO(reddwarf03): GoRouter
    final bool securityConfiguration = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return IntroConfigureSecurity(
            accessModes: accessModes,
            seed: seed,
            fromPage: fromPage,
          );
        },
      ),
    );

    return securityConfiguration;
  }
}
