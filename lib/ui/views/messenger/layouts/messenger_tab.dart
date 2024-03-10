import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/discussion_list_item.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/discussion_search_bar.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_discussion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MessengerTab extends ConsumerWidget {
  const MessengerTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MessengerBody();
  }
}

class MessengerBody extends ConsumerWidget {
  const MessengerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDiscussions = ref.watch(MessengerProviders.sortedDiscussions);

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ArchethicTheme.backgroundSmall,
          ),
          fit: MediaQuery.of(context).size.width >= 370
              ? BoxFit.fitWidth
              : BoxFit.fitHeight,
          alignment: Alignment.centerRight,
          opacity: 0.5,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              const DiscussionSearchBar(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: asyncDiscussions.map(
                  loading: (_) => Container(),
                  error: (_) => Container(),
                  data: (discussions) => ListView.builder(
                    itemCount: discussions.value.length,
                    itemBuilder: (context, index) {
                      final discussion = discussions.value[index];
                      return DiscussionListItem.loaded(
                        key: Key(discussion.address),
                        onTap: () => context.go(
                          MessengerDiscussionPage.routerPage,
                          extra: discussion.address,
                        ),
                        discussion: discussion,
                      )
                          .animate(delay: (100 * index).ms)
                          .fadeIn(duration: 300.ms, delay: 30.ms)
                          .shimmer(
                            blendMode: BlendMode.srcOver,
                            color: Colors.white12,
                          )
                          .move(
                            begin: const Offset(-16, 0),
                            curve: Curves.easeOutQuad,
                          );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
