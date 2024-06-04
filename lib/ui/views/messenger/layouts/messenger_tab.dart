import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/discussion_list_item.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/discussion_search_bar.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_sheet.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_discussion_page.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MessengerTab extends ConsumerWidget {
  const MessengerTab({
    super.key,
  });

  static const String routerPage = '/messengerTab';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MessengerBody();
  }
}

class MessengerBody extends ConsumerWidget implements SheetSkeletonInterface {
  const MessengerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: AppLocalizations.of(context)!.messengerHeader,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(HomePage.routerPage);
        },
      ),
      widgetRight: IconButton(
        icon: const Icon(
          Symbols.edit_square,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () async {
          final preferences = ref.read(SettingsProviders.settings);
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          context.go(CreateDiscussionSheet.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final asyncDiscussions = ref.watch(MessengerProviders.sortedDiscussions);

    return Column(
      children: [
        const DiscussionSearchBar(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: asyncDiscussions.map(
            loading: (_) => Container(),
            error: (_) => Container(),
            data: (discussions) => ListView.builder(
              itemCount: discussions.value.length,
              itemBuilder: (context, index) {
                final discussion = discussions.value[index];
                return DiscussionListItem.loaded(
                  key: Key(discussion.address),
                  onTap: () => context.push(
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
    );
  }
}
