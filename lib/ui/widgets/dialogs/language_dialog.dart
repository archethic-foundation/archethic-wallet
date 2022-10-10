/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/language.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageDialog {
  static Future<AvailableLanguage?> getDialog(BuildContext context, WidgetRef ref) async {
    final preferences = await Preferences.getInstance();
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AvailableLanguage.values) {
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
        final theme = ref.read(ThemeProviders.theme);
        final selectedLanguage = ref.read(LanguageProviders.selectedLanguage);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.language,
              style: theme.textStyleSize24W700EquinoxPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: selectedLanguage.language.index,
            onSelected: (value) {
              ref.read(LanguageProviders.selectLanguage(language: value.value as AvailableLanguage));
              Navigator.pop(context, value.value);
            },
          ),
        );
      },
    );
  }
}
