import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TalkListItem extends ConsumerWidget {
  const TalkListItem({super.key});

  const factory TalkListItem.autoLoad({
    Key? key,
    required String talkId,
    required VoidCallback onTap,
  }) = _AutoloadTalkListItem;

  const factory TalkListItem.loaded({
    Key? key,
    required Talk talk,
    required VoidCallback onTap,
  }) = _LoadedTalkListItem;

  const factory TalkListItem.loading({
    Key? key,
    Duration? animationDelay,
  }) = _LoadingTalkListItem;
}

class _AutoloadTalkListItem extends TalkListItem {
  const _AutoloadTalkListItem({
    super.key,
    required this.talkId,
    required this.onTap,
  });

  final String talkId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTalk = ref.watch(MessengerProviders.talk(talkId));
    return asyncTalk.map(
      error: (_) => const TalkListItem.loading(),
      loading: (_) => const TalkListItem.loading(),
      data: (talk) => TalkListItem.loaded(onTap: onTap, talk: talk.value),
    );
  }
}

class _LoadingTalkListItem extends TalkListItem {
  const _LoadingTalkListItem({
    super.key,
    this.animationDelay,
  });

  final Duration? animationDelay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.backgroundAccountsListCardSelected!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: theme.backgroundAccountsListCardSelected,
      child: const SizedBox(height: 48),
    );
  }
}

class _LoadedTalkListItem extends TalkListItem {
  const _LoadedTalkListItem({
    super.key,
    required this.talk,
    required this.onTap,
  });

  final Talk talk;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final displayName = ref.watch(MessengerProviders.talkDisplayName(talk));
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.backgroundAccountsListCardSelected!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: theme.backgroundAccountsListCardSelected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      displayName,
                      style: theme.textStyleSize12W600Primary,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    talk.updateDate.format(context),
                    style: theme.textStyleSize12W100Primary,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              if (talk.lastMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _LastMessagePreview(message: talk.lastMessage!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LastMessagePreview extends ConsumerWidget {
  const _LastMessagePreview({
    required this.message,
  });

  final TalkMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final contactName = ref
        .watch(
          ContactProviders.getContactWithGenesisPublicKey(
            message.senderGenesisPublicKey,
          ),
        )
        .maybeMap(
          orElse: () => message.senderGenesisPublicKey,
          data: (contact) => contact.value?.format,
        );

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: (contactName?.startsWith('@') ?? false)
                ? '${contactName?.substring(1)} : '
                : '$contactName : ',
            style: theme.textStyleSize10W600Primary,
          ),
          TextSpan(
            text: message.content,
            style: theme.textStyleSize10W400Primary,
          ),
        ],
      ),
    );
  }
}
