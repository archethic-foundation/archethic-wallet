import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
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
    required String talkId,
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
      data: (talk) => Card(
        child: SizedBox(
          height: 48,
          child: Text(talk.value.name),
        ),
      ),
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
  Widget build(BuildContext context, WidgetRef ref) => const Card(
        child: SizedBox(height: 48),
      )
          .animate(
            delay: animationDelay ?? Duration.zero,
            onPlay: (controller) => controller.repeat(),
          )
          .shimmer(delay: 1000.ms, angle: 0.5);
}

class _LoadedTalkListItem extends TalkListItem {
  const _LoadedTalkListItem({
    super.key,
    required this.talkId,
  });

  final String talkId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
        key: Key(talkId),
        child: SizedBox(
          height: 48,
          child: Text(talkId),
        ),
      );
}
