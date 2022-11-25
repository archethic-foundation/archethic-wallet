/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    if (infoQRCode.isEmpty) {
      return Container(
        width: 150,
        height: 185,
        alignment: Alignment.center,
        child: const Text('No data'),
      );
    }
    return Container(
      width: size,
      height: size + 20,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          QrImage(
            foregroundColor: theme.text,
            data: infoQRCode,
            size: size,
            gapless: false,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (displayShareButton == true)
                  ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
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
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.share,
                              color: theme.background,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (displayDisplayButton == true)
                  ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
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
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Icon(
                              UiIcons.eye,
                              color: theme.background,
                              size: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (displayCopyButton == true)
                  ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
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
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            FontAwesomeIcons.paste,
                            color: theme.background,
                            size: 14,
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
