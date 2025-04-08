import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DiscussionListItem extends ConsumerWidget {
  const DiscussionListItem({super.key});

  const factory DiscussionListItem.autoLoad({
    Key? key,
    required String discussionId,
    required VoidCallback onTap,
  }) = _AutoloadDiscussionListItem;

  const factory DiscussionListItem.loaded({
    Key? key,
    required Discussion discussion,
    required VoidCallback onTap,
  }) = _LoadedDiscussionListItem;

  const factory DiscussionListItem.loading({
    Key? key,
    Duration? animationDelay,
  }) = _LoadingDiscussionListItem;
}

class _AutoloadDiscussionListItem extends DiscussionListItem {
  const _AutoloadDiscussionListItem({
    super.key,
    required this.discussionId,
    required this.onTap,
  });

  final String discussionId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDiscussion =
        ref.watch(MessengerProviders.discussion(discussionId));
    return asyncDiscussion.map(
      error: (_) => const DiscussionListItem.loading(),
      loading: (_) => const DiscussionListItem.loading(),
      data: (discussion) =>
          DiscussionListItem.loaded(onTap: onTap, discussion: discussion.value),
    );
  }
}

class _LoadingDiscussionListItem extends DiscussionListItem {
  const _LoadingDiscussionListItem({
    super.key,
    this.animationDelay,
  });

  final Duration? animationDelay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ArchethicTheme.backgroundAccountsListCardSelected,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: ArchethicTheme.backgroundAccountsListCardSelected,
      child: const SizedBox(height: 48),
    );
  }
}

class _LoadedDiscussionListItem extends DiscussionListItem {
  const _LoadedDiscussionListItem({
    super.key,
    required this.discussion,
    required this.onTap,
  });

  final Discussion discussion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName =
        ref.watch(MessengerProviders.discussionDisplayName(discussion));
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ArchethicTheme.backgroundAccountsListCardSelected,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: ArchethicTheme.backgroundAccountsListCardSelected,
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
                      style: ArchethicThemeStyles.textStyleSize12W600Primary,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    discussion.updateDate.formatShort(context),
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              if (discussion.lastMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _LastMessagePreview(message: discussion.lastMessage!),
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

  final DiscussionMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Text.rich(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: (contactName?.startsWith('@') ?? false)
                ? '${contactName?.substring(1)} : '
                : '$contactName : ',
            style: ArchethicThemeStyles.textStyleSize10W600Primary,
          ),
          TextSpan(
            text: message.content,
            style: ArchethicThemeStyles.textStyleSize10W400Primary,
          ),
        ],
      ),
    );
  }
}
