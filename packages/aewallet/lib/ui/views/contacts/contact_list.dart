// ignore_for_file: cancel_subscriptions, must_be_immutable

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/bus/contact_added_event.dart';
import 'package:aewallet/bus/contact_removed_event.dart';
import 'package:aewallet/ui/views/contacts/add_contact.dart';
import 'package:aewallet/ui/views/contacts/contact_details.dart';

class ContactsList extends StatefulWidget {
  ContactsList(this.contactsController, this.contactsOpen, {super.key});

  final AnimationController contactsController;
  bool contactsOpen;

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact>? contacts;
  List<Contact>? contactsToDisplay = List<Contact>.empty(growable: true);
  TextEditingController? searchNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contacts = List<Contact>.empty(growable: true);
    _registerBus();
    // Initial contacts list
    _updateContacts();
  }

  @override
  void dispose() {
    if (contactAddedSub != null) {
      contactAddedSub!.cancel();
    }
    if (contactRemovedSub != null) {
      contactRemovedSub!.cancel();
    }
    super.dispose();
  }

  StreamSubscription<ContactAddedEvent>? contactAddedSub;
  StreamSubscription<ContactRemovedEvent>? contactRemovedSub;

  void _registerBus() {
    // Contact added bus event
    contactAddedSub = EventTaxiImpl.singleton()
        .registerTo<ContactAddedEvent>()
        .listen((ContactAddedEvent event) {
      setState(() {
        contacts!.add(event.contact!);
        //Sort by name
        contacts!.sort((Contact a, Contact b) =>
            a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      });
      // Full update
      _updateContacts();
    });
    // Contact removed bus event
    contactRemovedSub = EventTaxiImpl.singleton()
        .registerTo<ContactRemovedEvent>()
        .listen((ContactRemovedEvent event) {
      setState(() {
        contacts!.remove(event.contact);
      });
      // Full update
      _updateContacts();
    });
  }

  void _updateContacts() {
    sl.get<DBHelper>().getContacts().then((List<Contact> contacts) {
      for (Contact c in contacts) {
        if (!contacts.contains(c)) {
          setState(() {
            contacts.add(c);
          });
        }
      }
      // Re-sort list
      setState(() {
        contacts.sort((Contact a, Contact b) =>
            a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        contactsToDisplay = contacts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.text30!, width: 1),
          ),
          color: StateContainer.of(context).curTheme.drawerBackground,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30!,
                offset: const Offset(-5, 0),
                blurRadius: 20),
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
                margin: const EdgeInsets.only(bottom: 10.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: BackButton(
                        key: const Key('back'),
                        color: StateContainer.of(context).curTheme.text,
                        onPressed: () {
                          setState(() {
                            widget.contactsOpen = false;
                          });
                          widget.contactsController.reverse();
                        },
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        AppLocalization.of(context)!.addressBookHeader,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: AppTextField(
                  controller: searchNameController,
                  autofocus: false,
                  maxLines: 1,
                  autocorrect: false,
                  labelText: AppLocalization.of(context)!.searchField,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  onChanged: (text) async {
                    text = text.toLowerCase();
                    contactsToDisplay =
                        await StateContainer.of(context).getContacts();
                    setState(() {
                      contactsToDisplay =
                          contactsToDisplay!.where((Contact contact) {
                        var contactName = contact.name!.toLowerCase();
                        return contactName.contains(text);
                      }).toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Contacts list
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 15),
                      itemCount: contactsToDisplay!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Build contact
                        return buildSingleContact(
                            context, contactsToDisplay![index]);
                      },
                    ),
                    //List Top Gradient End
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 20.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              StateContainer.of(context)
                                  .curTheme
                                  .drawerBackground!,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00!
                            ],
                            begin: const AlignmentDirectional(0.5, -1.0),
                            end: const AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                    //List Bottom Gradient End
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 15.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00!,
                              StateContainer.of(context)
                                  .curTheme
                                  .drawerBackground!,
                            ],
                            begin: const AlignmentDirectional(0.5, -1.0),
                            end: const AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        AppLocalization.of(context)!.addContact,
                        Dimens.buttonBottomDimens, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const AddContactSheet());
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildSingleContact(BuildContext context, Contact contact) {
    return TextButton(
      onPressed: () {
        ContactDetailsSheet(contact).mainBottomSheet(context);
      },
      child: Column(children: <Widget>[
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
        // Main Container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          margin: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Contact info
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Contact name
                      Text(contact.name!,
                          style: AppStyles.textStyleSize16W600Primary(context)),
                      //Contact address
                      Text(
                        contact.address!,
                        style: AppStyles.textStyleSize12W100Text60(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
