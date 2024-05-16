import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/infrastructure/datasources/preferences.hive.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityManager {
  factory SecurityManager() {
    return _singleton;
  }

  SecurityManager._internal();

  bool _checkPlatform() {
    return UniversalPlatform.isMobile;
  }

  static final SecurityManager _singleton = SecurityManager._internal();

  Future<bool> isDeviceJailbroken() async {
    return FlutterJailbreakDetection.jailbroken;
  }

  Future<bool> isDeviceDeveloperMode() async {
    return FlutterJailbreakDetection.developerMode;
  }

  Future<bool> isDeviceSecured() async {
    if (_checkPlatform() == false) {
      return true;
    }
    return await SecurityManager().isDeviceJailbroken() == false &&
        await SecurityManager().isDeviceDeveloperMode() == false;
  }

  Future checkDeviceSecurity(WidgetRef ref, BuildContext context) async {
    if (_checkPlatform() == false) {
      return;
    }

    final preferences = await PreferencesHiveDatasource.getInstance();
    if (await isDeviceSecured()) {
      // user will see a popup next time his device is jailbroken or in dev mode
      await preferences.setHasShownRootWarning(false);
      return;
    }

    final localizations = AppLocalizations.of(context)!;

    // User never saw the error saying his device is unsafe, we will let him know that there is a mistake via a popup
    // Next time he will launch the app he will only see a snack bar
    if (preferences.getHasSeenRootWarning() == false) {
      final language = ref.read(
        LanguageProviders.selectedLanguage,
      );
      AppDialogs.showInfoDialog(
        context,
        ref,
        CaseChange.toUpperCase(
          localizations.warning,
          language.getLocaleString(),
        ),
        localizations.rootWarning,
        buttonLabel:
            AppLocalizations.of(context)!.iUnderstandTheRisks.toUpperCase(),
        onPressed: () async {
          await preferences.setHasShownRootWarning(true);
        },
      );
    } else {
      UIUtil.showSnackbar(
        localizations.rootWarning,
        context,
        ref,
        ArchethicTheme.text,
        ArchethicTheme.snackBarShadow,
        duration: const Duration(seconds: 10),
      );
    }
  }
}
