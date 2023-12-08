/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LanguageDialog {
  static Future<AvailableLanguage?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AvailableLanguage.values) {
      if (value == AvailableLanguage.systemDefault) continue;
      pickerItemsList.add(
        PickerItem(
          LanguageSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }

    return showDialog<AvailableLanguage>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final selectedLanguage = ref.read(LanguageProviders.selectedLanguage);
        return AlertDialog(
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: ArchethicThemeStyles.textStyleSize24W700Primary,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndexes: [selectedLanguage.index - 1],
            onSelected: (value) {
              ref
                  .read(SettingsProviders.settings.notifier)
                  .selectLanguage(value.value as AvailableLanguage);
              context.pop(value.value);
            },
          ),
        );
      },
    );
  }
}
