/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRCodeWithOptions extends ConsumerWidget {
  const QRCodeWithOptions({
    required this.infoQRCode,
    required this.size,
    required this.messageCopied,
    this.displayShareButton = true,
    this.displayCopyButton = true,
    this.displayDisplayButton = true,
    super.key,
  });

  final String infoQRCode;
  final double size;
  final String messageCopied;
  final bool displayShareButton;
  final bool displayCopyButton;
  final bool displayDisplayButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    if (infoQRCode.isEmpty) {
      return Container(
        width: 150,
        height: 225,
        alignment: Alignment.center,
        child: const Text('No data'),
      );
    }
    return Container(
      width: size + 100,
      height: size + 70,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          QrImageView(
            eyeStyle: QrEyeStyle(color: ArchethicTheme.text),
            dataModuleStyle: QrDataModuleStyle(color: ArchethicTheme.text),
            data: infoQRCode,
            size: size,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (displayShareButton == true)
                  ClipOval(
                    child: Material(
                      color: ArchethicTheme.text,
                      child: InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                preferences.activeVibrations,
                              );
                          final box = context.findRenderObject() as RenderBox?;
                          Share.share(
                            infoQRCode,
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 1),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Symbols.share,
                              color: ArchethicTheme.background,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (displayDisplayButton == true)
                  ClipOval(
                    child: Material(
                      color: ArchethicTheme.text,
                      child: InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                preferences.activeVibrations,
                              );
                          RawInfoPopup.getPopup(
                            context,
                            ref,
                            const LongPressEndDetails(),
                            infoQRCode,
                          );
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Icon(
                              Symbols.visibility,
                              color: ArchethicTheme.background,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (displayCopyButton == true)
                  ClipOval(
                    child: Material(
                      color: ArchethicTheme.text,
                      child: InkWell(
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
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Symbols.content_paste,
                            color: ArchethicTheme.background,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
