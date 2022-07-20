/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/model/data/contact.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';

class ContactsDialog {
  static Future<Contact?> getDialog(BuildContext context) async {
    FocusNode? searchNameFocusNode = FocusNode();
    TextEditingController? searchNameController = TextEditingController();

    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    List<Contact> contacts = await StateContainer.of(context).getContacts();
    for (var contact in contacts) {
      pickerItemsList.add(PickerItem(
          contact.name!, contact.address, null, null, contact, true));
    }
    return await showDialog<Contact>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
              alignment: Alignment.topCenter,
              title: Column(
                children: [
                  Text(
                    AppLocalization.of(context)!.addressBookHeader,
                    style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
                  ),
                  Container(
                    child: AppTextField(
                      focusNode: searchNameFocusNode,
                      controller: searchNameController,
                      autofocus: true,
                      maxLines: 1,
                      autocorrect: false,
                      labelText: AppLocalization.of(context)!.searchField,
                      keyboardType: TextInputType.text,
                      style: AppStyles.textStyleSize16W600Primary(context),
                      onChanged: (text) async {
                        contacts =
                            await StateContainer.of(context).getContacts();
                        setState(
                          () {
                            contacts = contacts.where((Contact contact) {
                              var contactName = contact.name!.toLowerCase();
                              return contactName.contains(text);
                            }).toList();
                            pickerItemsList.clear();
                            for (var contact in contacts) {
                              pickerItemsList.add(PickerItem(contact.name!,
                                  contact.address, null, null, contact, true));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  side: BorderSide(
                      color: StateContainer.of(context).curTheme.text45!)),
              content: SingleChildScrollView(
                child: PickerWidget(
                  pickerItems: pickerItemsList,
                  onSelected: (value) {
                    Navigator.pop(context, value.value);
                  },
                ),
              ),
            );
          });
        });
  }
}
