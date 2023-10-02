import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
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
    final accounts = ref.watch(AccountProviders.accounts).valueOrNull;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 2,
        color: theme.text15,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 80,
        bottom: MediaQuery.of(context).padding.bottom + 40,
      ),
      itemCount: contactsList.length,
      itemBuilder: (BuildContext context, int index) {
        // Build contact
        return SingleContact(
          contact: contactsList[index],
          accountBalance: getAsyncAccountBalance(
            contactsList[index],
            accounts,
            ref,
          ),
        )
            .animate(delay: (100 * index).ms)
            .fadeIn(duration: 900.ms, delay: 200.ms)
            .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
      },
    );
  }

  AsyncValue<AccountBalance> getAsyncAccountBalance(
    Contact contact,
    List<Account>? accounts,
    WidgetRef ref,
  ) {
    final account = accounts
        ?.where(
          (element) => element.lastAddress == contact.address,
        )
        .firstOrNull;

    if (contact.type == ContactType.keychainService.name && account != null) {
      return AsyncValue.data(account.balance!);
    } else {
      return ref.watch(
        ContactProviders.getBalance(address: contact.address),
      );
    }
  }
}
