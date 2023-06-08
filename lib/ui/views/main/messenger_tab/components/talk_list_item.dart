import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TalkListItem extends ConsumerWidget {
  const TalkListItem({super.key});

  const factory TalkListItem.autoLoad({
    Key? key,
    required String talkId,
  }) = _AutoloadTalkListItem;

  const factory TalkListItem.loaded({
    Key? key,
    required Talk talk,
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
  });

  final String talkId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTalk = ref.watch(MessengerProviders.talk(talkId));
    return asyncTalk.map(
      error: (_) => const TalkListItem.loading(),
      loading: (_) => const TalkListItem.loading(),
      data: (talk) => TalkListItem.loaded(talk: talk.value),
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
    )
        .animate(
          delay: animationDelay ?? Duration.zero,
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          blendMode: BlendMode.srcOver,
          delay: 1000.ms,
          angle: 0.5,
        );
  }
}

class _LoadedTalkListItem extends TalkListItem {
  const _LoadedTalkListItem({
    super.key,
    required this.talk,
  });

  final Talk talk;

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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: theme.backgroundAccountsListCard,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AutoSizeText(
                talk.name,
                style: theme.textStyleSize12W600Primary,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                '${talk.members.length} members',
                style: theme.textStyleSize10W100Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
