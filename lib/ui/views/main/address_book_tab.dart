import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_list.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressBookTab extends ConsumerStatefulWidget {
  const AddressBookTab({super.key});

  @override
  ConsumerState<AddressBookTab> createState() => _AddressBookTabState();
}

class _AddressBookTabState extends ConsumerState<AddressBookTab> {
  late TextEditingController searchNameController;

  @override
  void initState() {
    searchNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final contactsList = ref.watch(
      ContactProviders.fetchContacts(
        search: searchNameController.text,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 83,
          left: 15,
          right: 15),
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: Column(
                children: <Widget>[
                  AppTextField(
                    inputFormatters: <UpperCaseTextFormatter>[
                      UpperCaseTextFormatter()
                    ],
                    controller: searchNameController,
                    autocorrect: false,
                    labelText: localizations.searchField,
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      ref.watch(
                        ContactProviders.fetchContacts(
                          search: text,
                        ),
                      );
                    },
                    style: theme.textStyleSize16W600Primary,
                  ),
                  contactsList.map(
                    data: (data) {
                      return ContactList(contactsList: data.value);
                    },
                    error: (error) => const SizedBox(),
                    loading: (loading) => const SizedBox(
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.addContact,
                  Dimens.buttonBottomDimens,
                  key: const Key('addContact'),
                  icon: Icon(
                    Icons.add,
                    color: theme.text,
                    size: 14,
                  ),
                  onPressed: () {
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const AddContactSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
