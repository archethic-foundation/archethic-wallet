import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/chat_components.dart';
import 'package:aewallet/ui/views/messenger/layouts/discussion_details_page.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MessengerDiscussionPage extends ConsumerWidget
    implements SheetSkeletonInterface {
  const MessengerDiscussionPage({
    super.key,
    required this.discussionAddress,
  });

  static const routerPage = '/messenger_discussion';

  final String discussionAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
      resizeToAvoidBottomInset: true,
      menu: true,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final discussion =
        ref.watch(MessengerProviders.discussion(discussionAddress));
    return SheetAppBar(
      title: discussion.maybeMap(
        data: (data) {
          final displayName = ref.watch(
            MessengerProviders.discussionDisplayName(data.value),
          );

          return displayName;
        },
        orElse: () => '',
      ),
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
      widgetRight: IconButton(
        icon: const Icon(
          Symbols.info,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () {
          context.push(
            DiscussionDetailsPage.routerPage,
            extra: discussionAddress,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ArchethicTheme.backgroundSmall,
          ),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
          opacity: 0.7,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: MessagesList(
              discussionAddress: discussionAddress,
            ),
          ),
          _buildSendFormConditional(context, ref),
        ],
      ),
    );
  }

  Widget _buildSendFormConditional(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    final discussion =
        ref.watch(MessengerProviders.discussion(discussionAddress));

    if (discussion.valueOrNull != null &&
        discussion.value!.membersPubKeys.any(
          (element) => element == selectedAccount?.publicKey,
        )) {
      return MessageSendForm(
        discussionAddress: discussionAddress,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
