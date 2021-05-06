// @dart=2.9

import 'dart:async';

import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/ui/contacts/add_contact.dart';
import 'package:uniris_mobile_wallet/ui/contacts/contact_details.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/ui/util/ui_util.dart';

class ContactsList extends StatefulWidget {
  final AnimationController contactsController;
  bool contactsOpen;

  ContactsList(this.contactsController, this.contactsOpen);

  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final Logger log = sl.get<Logger>();

  List<Contact> _contacts;
  String documentsDirectory;
  @override
  void initState() {
    super.initState();
    _registerBus();
    // Initial contacts list
    _contacts = List<Contact>.empty(growable: true);
    getApplicationDocumentsDirectory().then((directory) {
      documentsDirectory = directory.path;
      setState(() {
        documentsDirectory = directory.path;
      });
      _updateContacts();
    });
  }

  @override
  void dispose() {
    if (_contactAddedSub != null) {
      _contactAddedSub.cancel();
    }
    if (_contactRemovedSub != null) {
      _contactRemovedSub.cancel();
    }
    super.dispose();
  }

  StreamSubscription<ContactAddedEvent> _contactAddedSub;
  StreamSubscription<ContactRemovedEvent> _contactRemovedSub;

  void _registerBus() {
    // Contact added bus event
    _contactAddedSub = EventTaxiImpl.singleton()
        .registerTo<ContactAddedEvent>()
        .listen((event) {
      setState(() {
        _contacts.add(event.contact);
        //Sort by name
        _contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      });
      // Full update
      _updateContacts();
    });
    // Contact removed bus event
    _contactRemovedSub = EventTaxiImpl.singleton()
        .registerTo<ContactRemovedEvent>()
        .listen((event) {
      setState(() {
        _contacts.remove(event.contact);
      });
    });
  }

  void _updateContacts() {
    sl.get<DBHelper>().getContacts().then((contacts) {
      for (Contact c in contacts) {
        if (!_contacts.contains(c)) {
          setState(() {
            _contacts.add(c);
          });
        }
      }
      // Re-sort list
      setState(() {
        _contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: [
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30,
                offset: Offset(-5, 0),
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
              // Back button and Contacts Text
              Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //Back button
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.contactsOpen = false;
                                });
                                widget.contactsController.reverse();
                              },
                              child: Icon(AppIcons.back,
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  size: 24)),
                        ),
                        //Contacts Header Text
                        Text(
                          AppLocalization.of(context).addressBookHeader,
                          style: AppStyles.textStyleSettingsHeader(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Contacts list + top and bottom gradients
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Contacts list
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 15.0, bottom: 15),
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) {
                        // Build contact
                        return buildSingleContact(context, _contacts[index]);
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
                            colors: [
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00
                            ],
                            begin: AlignmentDirectional(0.5, -1.0),
                            end: AlignmentDirectional(0.5, 1.0),
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
                            colors: [
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                            ],
                            begin: AlignmentDirectional(0.5, -1.0),
                            end: AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).addContact,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: AddContactSheet());
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
        ContactDetailsSheet(contact, documentsDirectory)
            .mainBottomSheet(context);
      },
      child: Column(children: <Widget>[
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
        // Main Container
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: new EdgeInsetsDirectional.only(start: 12.0, end: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Contact info
              Expanded(
                child: Container(
                  height: 60,
                  margin: EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Contact name
                      Text(contact.name,
                          style: AppStyles.textStyleSettingItemHeader(context)),
                      //Contact address
                      Text(
                        Address(contact.address).getShortString(),
                        style: AppStyles.textStyleTransactionAddress(context),
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
