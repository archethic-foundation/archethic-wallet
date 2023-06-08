import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MessengerTalkPage extends ConsumerWidget {
  const MessengerTalkPage({
    super.key,
    required this.talkId,
  });

  final String talkId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final talk = ref.watch(MessengerProviders.talk(talkId));

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            theme.background3Small!,
          ),
          fit: BoxFit.fitHeight,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[theme.backgroundDark!, theme.background!],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: talk.maybeMap(
            data: (data) => Text(data.value.name),
            orElse: () => const Text('           ')
                .animate(
                  onComplete: (controller) =>
                      controller.repeat(period: 1.seconds),
                )
                .shimmer(),
          ),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _MessagesList(),
            ),
            _MessageSendForm(),
          ],
        ),
      ),
    );
  }
}

class _MessageSendForm extends ConsumerWidget {
  const _MessageSendForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: TextField()),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: theme.text,
                ),
                label: Container(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Price : 12UCO',
            style: theme.textStyleSize10W100Primary,
          ),
        ],
      ),
    );
  }
}

class _MessagesList extends ConsumerStatefulWidget {
  const _MessagesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __MessagesListState();
}

class __MessagesListState extends ConsumerState<_MessagesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final other = AccessRecipient.contact(
      contact: Contact(
        name: 'Toto',
        address: 'wertyu',
        publicKey: 'pubKey',
        type: 'weret',
      ),
    );
    final me = AccessRecipient.contact(
      contact: ref.watch(ContactProviders.getSelectedContact).valueOrNull!,
    );

    final messages = [
      TalkMessage(
        id: '1',
        sender: other,
        message: 'Salut',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '2',
        sender: other,
        message: 'ca va ?',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '3',
        sender: me,
        message: 'ouais la peche',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '4',
        sender: other,
        message: "t'as pas 100 balles et un mars ?",
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '5',
        sender: me,
        message:
            'ca dépend, tu me pretes ton bike pour que je fasse des tricks ?',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '6',
        sender: me,
        message: 'et des trucs ?',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '7',
        sender: other,
        message: 'ouais, enfin evite les trucs.',
        date: DateTime.now(),
      ),
      TalkMessage(
        id: '8',
        sender: other,
        message: "Tiens t'en aux tricks",
        date: DateTime.now(),
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        final message = messages.reversed.elementAt(index);
        final isSentByMe = message.sender == me;

        if (isSentByMe) {
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 42, right: 8, bottom: 8),
              child: _MessageItem(
                key: Key(message.id),
                color: theme.background!,
                message: message,
                showSender: false,
              ),
            ),
          );
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 42, bottom: 8),
            child: _MessageItem(
              key: Key(message.id),
              color: theme.iconDataWidgetIconBackground!,
              message: message,
              showSender: true,
            ),
          ),
        );
      },
    );
  }
}

class _MessageItem extends ConsumerWidget {
  const _MessageItem({
    required this.message,
    required this.color,
    required this.showSender,
    super.key,
  });

  final TalkMessage message;
  final Color color;
  final bool showSender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(SettingsProviders.settings).language.getLocale();
    final dateFormatter = DateFormat.Hm(locale);
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender)
              Text(
                message.sender.map(
                  publicKey: (publicKey) => publicKey.publicKey.publicKey,
                  contact: (contact) => contact.contact.name,
                ),
                style: theme.textStyleSize12W600Primary,
              ),
            const SizedBox(height: 3),
            Text(
              message.message,
              style: theme.textStyleSize12W400Primary,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                dateFormatter.format(message.date),
                style: theme.textStyleSize10W100Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
