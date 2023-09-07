/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class ItemRemoveButton extends ConsumerWidget {
  const ItemRemoveButton({
    required this.onPressed,
    this.readOnly = false,
    super.key,
  });

  final Function onPressed;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (readOnly) {
      return const SizedBox();
    }
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.backgroundDark!.withOpacity(0.3),
          border: Border.all(
            color: theme.backgroundDarkest!.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Symbols.close,
            color: theme.backgroundDarkest,
            size: 21,
          ),
          onPressed: () {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  preferences.activeVibrations,
                );
            onPressed();
          },
        ),
      ),
    );
  }
}
