/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContactsDialog {
  static Future<Contact?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // TODO(reddwarf03): manage dispose // do a dedicated widget (2)
    final searchNameFocusNode = FocusNode();
    final searchNameController = TextEditingController();

    final pickerItemsList = List<PickerItem>.empty(growable: true);
    var contacts = await ref.read(ContactProviders.fetchContacts().future);
    final accountSelected = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    for (final contact in contacts) {
      if (contact.format.toUpperCase() !=
          accountSelected!.nameDisplayed.toUpperCase()) {
        pickerItemsList.add(
          PickerItem(
            contact.format,
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
        final localizations = AppLocalizations.of(context)!;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: ArchethicTheme.backgroundPopupColor,
              elevation: 0,
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
                    style: ArchethicThemeStyles.textStyleSize24W700Primary,
                  ),
                  AppTextField(
                    focusNode: searchNameFocusNode,
                    controller: searchNameController,
                    autofocus: true,
                    autocorrect: false,
                    labelText: localizations.searchField,
                    keyboardType: TextInputType.text,
                    style: ArchethicThemeStyles.textStyleSize16W600Primary,
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(20),
                    ],
                    onChanged: (text) async {
                      contacts = await ref.read(
                        ContactProviders.fetchContacts().future,
                      )
                        ..removeWhere(
                          (element) =>
                              element.format.toUpperCase() ==
                              accountSelected!.nameDisplayed.toUpperCase(),
                        );
                      setState(
                        () {
                          contacts = contacts.where((Contact contact) {
                            final contactName = contact.format.toUpperCase();
                            return contactName.contains(text.toUpperCase());
                          }).toList();
                          pickerItemsList.clear();
                          for (final contact in contacts) {
                            if (contact.format.toUpperCase() !=
                                accountSelected!.nameDisplayed.toUpperCase()) {
                              pickerItemsList.add(
                                PickerItem(
                                  contact.format,
                                  null,
                                  null,
                                  null,
                                  contact,
                                  true,
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              content: SingleChildScrollView(
                child: PickerWidget(
                  pickerItems: pickerItemsList,
                  onSelected: (value) {
                    context.pop(value.value);
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
