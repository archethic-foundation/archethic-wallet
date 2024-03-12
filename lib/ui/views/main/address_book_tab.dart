import 'package:aewallet/application/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_list.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

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
    final localizations = AppLocalizations.of(context)!;
    final contactsList = ref.watch(
      ContactProviders.fetchContacts(
        search: searchNameController.text,
      ),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: contactsList.map(
                data: (data) {
                  return ContactList(contactsList: data.value);
                },
                error: (error) => const SizedBox(),
                loading: (loading) => Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: ArchethicTheme.text,
                      strokeWidth: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 15,
                right: 15,
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Symbols.search,
                    color: ArchethicTheme.text,
                    size: 18,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                  suffixIcon: const SizedBox(
                    width: 26,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: ArchethicThemeStyles.textStyleSize12W100Primary,
                  filled: true,
                  //fillColor: ArchethicTheme.text30,
                  hintText: localizations.searchField,
                ),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
                textAlign: TextAlign.left,
                controller: searchNameController,
                autocorrect: false,
                cursorColor: ArchethicTheme.text,
                inputFormatters: <TextInputFormatter>[
                  UpperCaseTextFormatter(),
                  LengthLimitingTextInputFormatter(20),
                ],
                onChanged: (text) {
                  ref.watch(
                    ContactProviders.fetchContacts(
                      search: text,
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 70,
              ),
              child: Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.addContact,
                    Dimens.buttonBottomDimens,
                    key: const Key('addContact'),
                    onPressed: () {
                      context.push(AddContactSheet.routerPage);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
