/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/qr_code_with_options.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class ContactDetailTab extends ConsumerWidget {
  const ContactDetailTab({
    required this.infoQRCode,
    required this.description,
    required this.messageCopied,
    this.warning,
    super.key,
  });

  final String infoQRCode;
  final String description;
  final String messageCopied;
  final String? warning;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Container(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 12,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ArchethicScrollbar(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(text: infoQRCode),
                      );
                      UIUtil.showSnackbar(
                        messageCopied,
                        context,
                        ref,
                        ArchethicTheme.text,
                        ArchethicTheme.snackBarShadow,
                        icon: Symbols.info,
                      );
                    },
                    onLongPressEnd: (details) {
                      RawInfoPopup.getPopup(
                        context,
                        ref,
                        details,
                        infoQRCode,
                      );
                    },
                    child: QRCodeWithOptions(
                      infoQRCode: infoQRCode,
                      size: 200,
                      messageCopied: messageCopied,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (warning != null)
                    AutoSizeText(
                      warning!,
                      textAlign: TextAlign.left,
                      style: ArchethicThemeStyles.textStyleSize12W300PrimaryRed,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    description,
                    textAlign: TextAlign.left,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
