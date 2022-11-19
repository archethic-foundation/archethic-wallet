import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/single_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key, required this.contactsList});

  final List<Contact> contactsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              return SingleContact(
                contact: contactsList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
