import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/single_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
              top: 15,
              bottom: 15,
            ),
            itemCount: contactsList.length,
            itemBuilder: (BuildContext context, int index) {
              // Build contact
              return SingleContact(
                contact: contactsList[index],
              )
                  .animate(delay: (100 * index).ms)
                  .fadeIn(duration: 900.ms, delay: 200.ms)
                  .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
                  .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
            },
          ),
        ],
      ),
    );
  }
}
