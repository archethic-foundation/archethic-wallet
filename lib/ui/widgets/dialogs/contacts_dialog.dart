/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsDialog {
  static Future<Contact?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final searchNameFocusNode = FocusNode();
    final searchNameController = TextEditingController();

    final pickerItemsList = List<PickerItem>.empty(growable: true);
    var contacts = await StateContainer.of(context).getContacts();
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));

    for (final contact in contacts) {
      if (contact.name!.toLowerCase().replaceFirst('@', '') !=
          accountSelected!.name!.toLowerCase()) {
        pickerItemsList.add(
          PickerItem(
            contact.name!.substring(1),
            null,
            null,
            null,
            contact,
            true,
          ),
        );
      }
    }
    return showDialog<Contact>(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalization.of(context)!;
        final theme = ref.watch(ThemeProviders.selectedTheme);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.only(
                top: 100,
                bottom: 100,
                left: 20,
                right: 20,
              ),
              alignment: Alignment.topCenter,
              title: Column(
                children: [
                  Text(
                    localizations.addressBookHeader,
                    style: theme.textStyleSize24W700EquinoxPrimary,
                  ),
                  AppTextField(
                    focusNode: searchNameFocusNode,
                    controller: searchNameController,
                    autofocus: true,
                    autocorrect: false,
                    labelText: localizations.searchField,
                    keyboardType: TextInputType.text,
                    style: theme.textStyleSize16W600Primary,
                    onChanged: (text) async {
                      contacts = await StateContainer.of(context).getContacts();
                      setState(
                        () {
                          contacts = contacts.where((Contact contact) {
                            final contactName = contact.name!.toLowerCase();
                            return contactName.contains(text);
                          }).toList();
                          pickerItemsList.clear();
                          for (final contact in contacts) {
                            pickerItemsList.add(
                              PickerItem(
                                contact.name!.substring(1),
                                null,
                                null,
                                null,
                                contact,
                                true,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                side: BorderSide(
                  color: theme.text45!,
                ),
              ),
              content: SingleChildScrollView(
                child: PickerWidget(
                  pickerItems: pickerItemsList,
                  onSelected: (value) {
                    Navigator.pop(context, value.value);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
