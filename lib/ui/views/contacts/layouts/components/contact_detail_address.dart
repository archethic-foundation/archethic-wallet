/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
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

class ContactDetailAddress extends ConsumerWidget {
  const ContactDetailAddress({
    required this.contact,
    super.key,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: 4,
        bottom: 12,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            Clipboard.setData(
                                ClipboardData(text: contact.address),);
                            UIUtil.showSnackbar(
                              localizations.addressCopied,
                              context,
                              ref,
                              theme.text!,
                              theme.snackBarShadow!,
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
                              data: contact.address,
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
                        if (contact.type == ContactType.keychainService.name)
                          AutoSizeText(
                            localizations.contactAddressInfoKeychainService,
                            textAlign: TextAlign.left,
                            style: theme.textStyleSize12W100Primary,
                          )
                        else
                          AutoSizeText(
                            localizations.contactAddressInfoExternalContact,
                            textAlign: TextAlign.left,
                            style: theme.textStyleSize12W100Primary,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
