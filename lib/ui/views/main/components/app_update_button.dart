import 'dart:io';

import 'package:aewallet/application/app_version_update_info.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AppUpdateButton extends ConsumerWidget {
  const AppUpdateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb || Platform.isWindows || Platform.isLinux) {
      return const SizedBox();
    }

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return const SizedBox();
    }

    final localizations = AppLocalization.of(context)!;
    final appVersionInfo = ref.watch(AppVersionInfoProviders.getAppVersionInfo);
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return appVersionInfo.map(
      data: (data) {
        return data.value.canUpdate
            ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height - 120,
                  left: MediaQuery.of(context).size.width - 60,
                ),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: theme.background,
                      foregroundColor: theme.textFieldIcon,
                      splashColor: theme.textFieldIcon,
                      onPressed: () {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        AppDialogs.showInfoDialog(
                          context,
                          ref,
                          localizations.updateAvailableTitle,
                          localizations.updateAvailableDesc
                              .replaceFirst('%1', data.value.storeVersion),
                        );
                      },
                      child: const Icon(
                        UiIcons.warning,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
      error: (error) => const SizedBox(),
      loading: (lading) => const SizedBox(),
    );
  }
}
