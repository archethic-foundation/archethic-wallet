/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
      height: size + 90,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: size + 10,
            height: size + 10,
            child: QrImageView(
              eyeStyle: const QrEyeStyle(color: Colors.black),
              dataModuleStyle: const QrDataModuleStyle(color: Colors.black),
              data: infoQRCode,
              size: size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (displayShareButton == true) _btnShare(context, ref),
                if (displayDisplayButton == true) _btnView(context, ref),
                if (displayCopyButton == true) _btnCopy(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnShare(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.share,
                  size: 20,
                ),
              ),
              onTap: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                final box = context.findRenderObject() as RenderBox?;
                await Share.share(
                  infoQRCode,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.share,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _btnView(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.visibility,
                  size: 20,
                ),
              ),
              onTap: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                await RawInfoPopup.getPopup(
                  context,
                  ref,
                  const LongPressEndDetails(),
                  infoQRCode,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.display,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _btnCopy(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.content_copy,
                  size: 20,
                ),
              ),
              onTap: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                await Clipboard.setData(
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
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.copy,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
