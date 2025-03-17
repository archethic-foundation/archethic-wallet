import 'package:aewallet/application/app_version_update_info.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppUpdateButton extends ConsumerWidget {
  const AppUpdateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (UniversalPlatform.isWeb ||
        UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux) {
      return const SizedBox.shrink();
    }

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return const SizedBox.shrink();
    }

    final localizations = AppLocalizations.of(context)!;
    final appVersionInfo = ref.watch(AppVersionInfoProviders.getAppVersionInfo);

    return appVersionInfo.map(
      data: (data) {
        return data.value.canUpdate
            ? IconButton(
                icon: const Icon(
                  aedappfm.Iconsax.info_circle,
                  size: 18,
                  color: Color(0xFFFF8400),
                ),
                onPressed: () async {
                  await AppDialogs.showInfoDialog(
                    context,
                    ref,
                    localizations.updateAvailableTitle,
                    localizations.updateAvailableDesc
                        .replaceFirst('%1', data.value.storeVersion),
                  );
                },
              )
            : const SizedBox.shrink();
      },
      error: (error) => const SizedBox(),
      loading: (lading) => const SizedBox(),
    );
  }
}
