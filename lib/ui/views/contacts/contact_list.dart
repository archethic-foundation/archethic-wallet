/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/repository/contact_repository.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/add_contact.dart';
import 'package:aewallet/ui/views/contacts/contact_details.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_list.g.dart';

@riverpod
Future<List<Contact>> fetchContacts(
  FetchContactsRef ref, {
  String search = '',
}) async {
  if (search.isEmpty) {
    return ref.watch(contactRepositoryProvider).getAllContacts();
  }
  final searchedContacts =
      await ref.watch(contactRepositoryProvider).searchContacts(search: search);
  return searchedContacts;
}

class ContactsList extends ConsumerWidget {
  ContactsList(this.contactsController, this.contactsOpen, {super.key});

  final AnimationController contactsController;
  bool contactsOpen;

  TextEditingController? searchNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    final contactsList = ref.watch(
      FetchContactsProvider(
        search: searchNameController!.text,
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.drawerBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.overlay30!,
            offset: const Offset(-5, 0),
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: BackButton(
                      key: const Key('back'),
                      color: theme.text,
                      onPressed: () {
                        contactsOpen = false;
                        contactsController.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      localizations.addressBookHeader,
                      style: AppStyles.textStyleSize24W700EquinoxPrimary(
                        context,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AppTextField(
                controller: searchNameController,
                autocorrect: false,
                labelText: localizations.searchField,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  ref.watch(
                    FetchContactsProvider(
                      search: text,
                    ),
                  );
                },
                style: AppStyles.textStyleSize16W600Primary(context),
              ),
            ),
            contactsList.map(
              data: (data) {
                return _ContactList(contactsList: data.value);
              },
              error: (error) => const SizedBox(),
              loading: (loading) => const SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                    const Key('addContact'),
                    context,
                    AppButtonType.primary,
                    localizations.addContact,
                    Dimens.buttonBottomDimens,
                    onPressed: () {
                      Sheets.showAppHeightNineSheet(
                        context: context,
                        widget: const AddContactSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends ConsumerWidget {
  const _ContactList({required this.contactsList});

  final List<Contact> contactsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = StateContainer.of(context).curTheme;

    return Expanded(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
              bottom: 15,
            ),
            itemCount: contactsList.length,
            itemBuilder: (BuildContext context, int index) {
              // Build contact
              return _SingleContact(
                contact: contactsList[index],
              );
            },
          ),
          //List Top Gradient End
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    theme.drawerBackground!,
                    theme.backgroundDark00!
                  ],
                  begin: const AlignmentDirectional(0.5, -1),
                  end: const AlignmentDirectional(0.5, 1),
                ),
              ),
            ),
          ),
          //List Bottom Gradient End
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 15,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    theme.backgroundDark00!,
                    theme.drawerBackground!,
                  ],
                  begin: const AlignmentDirectional(0.5, -1),
                  end: const AlignmentDirectional(0.5, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleContact extends StatelessWidget {
  const _SingleContact({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;

    return TextButton(
      onPressed: () {
        Sheets.showAppHeightNineSheet(
          context: context,
          widget: ContactDetail(
            contact: contact,
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Divider(
            height: 2,
            color: theme.text15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 30,
                    margin: const EdgeInsetsDirectional.only(start: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            if (contact.type == 'keychainService')
                              FaIcon(
                                FontAwesomeIcons.keycdn,
                                color: theme.iconDrawer,
                                size: 16,
                              )
                            else
                              Icon(
                                Icons.person,
                                color: theme.iconDrawer,
                                size: 16,
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              contact.name!.replaceFirst('@', ''),
                              style: AppStyles.textStyleSize14W200Primary(
                                context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
