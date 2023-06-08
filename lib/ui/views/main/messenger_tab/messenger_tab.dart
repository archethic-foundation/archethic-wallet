import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/create_talk_sheet.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/talk_list_item.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final asyncTalkIds = ref.watch(MessengerProviders.talkIds);
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 20,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Expanded(
              child: asyncTalkIds.map(
                loading: (_) => Container(),
                error: (_) => Container(),
                data: (talkIds) => ListView.builder(
                  itemCount: talkIds.value.length,
                  itemBuilder: (context, index) {
                    final talkId = talkIds.value[index];
                    return TalkListItem.autoLoad(
                      key: Key(talkId),
                      onTap: () => Navigator.of(context).pushNamed(
                        '/messenger_talk',
                        arguments: talkId,
                      ),
                      talkId: talkId,
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.addMessengerGroup,
                  Dimens.buttonBottomDimens,
                  key: const Key('addMessengerGroup'),
                  icon: Icon(
                    Icons.add,
                    color: theme.mainButtonLabel,
                    size: 14,
                  ),
                  onPressed: () async {
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const CreateTalkSheet(),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
