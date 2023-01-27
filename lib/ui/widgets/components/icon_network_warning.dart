import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/views/sheets/connectivity_warning.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class IconNetworkWarning extends ConsumerWidget {
  const IconNetworkWarning({
    super.key,
    this.alignment = Alignment.center,
  });

  final Alignment alignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Align(
      alignment: alignment,
      child: IconButton(
        icon: const Icon(UiIcons.network_warning, color: Colors.red, size: 25),
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: const ConnectivityWarning(),
          );
        },
      ),
    );
  }
}
