/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';

class ContactsDialog {
  static Future<Contact?> getDialog(BuildContext context) async {
    final searchNameFocusNode = FocusNode();
    final searchNameController = TextEditingController();

    final pickerItemsList =
        List<PickerItem>.empty(growable: true);
    var contacts = await StateContainer.of(context).getContacts();
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
    return showDialog<Contact>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.only(top: 100, bottom: 100),
              alignment: Alignment.topCenter,
              title: Column(
                children: [
                  Text(
                    AppLocalization.of(context)!.addressBookHeader,
                    style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
                  ),
                  AppTextField(
                    focusNode: searchNameFocusNode,
                    controller: searchNameController,
                    autofocus: true,
                    autocorrect: false,
                    labelText: AppLocalization.of(context)!.searchField,
                    keyboardType: TextInputType.text,
                    style: AppStyles.textStyleSize16W600Primary(context),
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
                  color: StateContainer.of(context).curTheme.text45!,
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
