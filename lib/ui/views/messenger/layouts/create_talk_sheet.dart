import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_group_sheet.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class CreateTalkSheet extends ConsumerWidget {
  const CreateTalkSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final contactsList = ref.watch(
      ContactProviders.fetchContacts(),
    );
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final pickerItemsList = List<PickerItem>.empty(growable: true);
    if ((contactsList.value ?? []).isNotEmpty) {
      for (final contact in contactsList.value!) {
        if (contact.format.toUpperCase() !=
            accountSelected?.nameDisplayed.toUpperCase()) {
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
    }

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.newTalk,
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextButton(
                            onPressed: () {
                              Sheets.showAppHeightNineSheet(
                                context: context,
                                ref: ref,
                                widget: const CreateGroupSheet(),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.group_add_outlined,
                                  color: theme.text,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  localizations.newGroup,
                                  style: theme.textStyleSize14W700Primary,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: theme.text,
                          ),
                          TextButton(
                            onPressed: () {
                              Sheets.showAppHeightNineSheet(
                                context: context,
                                ref: ref,
                                widget: const AddContactSheet(),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Iconsax.user_add,
                                  color: theme.text,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  localizations.newContact,
                                  style: theme.textStyleSize14W700Primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: theme.text),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        localizations.contactsHeader,
                        style: theme.textStyleSize14W200Primary
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: pickerItemsList.isEmpty,
                        child: Text(
                          localizations.noContacts,
                          style: theme.textStyleSize14W200Primary,
                        ),
                      ),
                      Visibility(
                        visible: pickerItemsList.isNotEmpty,
                        child: SingleChildScrollView(
                          child: PickerWidget(
                            pickerItems: pickerItemsList,
                            onSelected: (value) {
                              Navigator.pop(context, value.value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
