import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class AuthentificationMethodDialogHelp {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final preferences = ref.watch(SettingsProviders.settings);
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ArchethicTheme.sheetBackground.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ArchethicTheme.sheetBorder,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.information,
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (kIsWeb)
                      ArchethicScrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.password,
                              ).getDisplayName(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.password,
                              ).getDescription(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                          ],
                        ),
                      )
                    else
                      ArchethicScrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.pin,
                              ).getDisplayName(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.pin,
                              ).getDescription(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.password,
                              ).getDisplayName(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.password,
                              ).getDescription(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.biometrics,
                              ).getDisplayName(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.biometrics,
                              ).getDescription(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.yubikeyWithYubicloud,
                              ).getDisplayName(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                            Text(
                              const AuthenticationMethod(
                                AuthMethod.yubikeyWithYubicloud,
                              ).getDescription(context),
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      key: const Key('closeButton'),
                      labelBtn: AppLocalizations.of(
                        context,
                      )!
                          .close,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
