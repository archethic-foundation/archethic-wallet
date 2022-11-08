/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactDetailTab extends ConsumerStatefulWidget {
  const ContactDetailTab({
    required this.infoQRCode,
    required this.description,
    required this.messageCopied,
    super.key,
  });

  final String infoQRCode;
  final String description;
  final String messageCopied;

  @override
  ConsumerState<ContactDetailTab> createState() => _ContactDetailTabState();
}

class _ContactDetailTabState extends ConsumerState<ContactDetailTab> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        Clipboard.setData(
                          ClipboardData(text: widget.infoQRCode),
                        );
                        UIUtil.showSnackbar(
                          widget.messageCopied,
                          context,
                          ref,
                          theme.text!,
                          theme.snackBarShadow!,
                        );
                      },
                      onLongPressEnd: (details) {
                        RawInfoPopup.getPopup(
                          context,
                          ref,
                          details,
                          widget.infoQRCode,
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QrImage(
                          foregroundColor: theme.text,
                          data: widget.infoQRCode,
                          size: 150,
                          gapless: false,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        UiIcons.about,
                        color: theme.text,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      widget.description,
                      textAlign: TextAlign.left,
                      style: theme.textStyleSize12W100Primary,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
