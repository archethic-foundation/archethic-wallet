/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class PasteIcon extends TextFieldButton {
  const PasteIcon({
    super.key,
    required this.onPaste,
    this.onDataNull,
  });

  final Function(String value) onPaste;
  final Function()? onDataNull;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return TextFieldButton(
      icon: Symbols.content_copy,
      onPressed: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        Clipboard.getData('text/plain').then((ClipboardData? data) async {
          if (data == null || data.text == null) {
            onDataNull?.call();
            return;
          }
          onPaste(data.text!);
        });
      },
    );
  }
}
