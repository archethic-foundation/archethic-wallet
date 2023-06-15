import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/talk_list_item.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_talk_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    final asyncTalks = ref.watch(MessengerProviders.sortedTalks);
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            theme.background1Small!,
          ),
          fit: BoxFit.fitHeight,
          opacity: 0.7,
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
              Expanded(
                child: asyncTalks.map(
                  loading: (_) => Container(),
                  error: (_) => Container(),
                  data: (talks) => ListView.builder(
                    itemCount: talks.value.length,
                    itemBuilder: (context, index) {
                      final talk = talks.value[index];
                      return TalkListItem.loaded(
                        key: Key(talk.address),
                        onTap: () => Navigator.of(context).pushNamed(
                          '/messenger_talk',
                          arguments: talk.address,
                        ),
                        talk: talk,
                      )
                          .animate(delay: (100 * index).ms)
                          .fadeIn(duration: 300.ms, delay: 30.ms)
                          .shimmer(
                              blendMode: BlendMode.srcOver,
                              color: Colors.white12)
                          .move(
                            begin: const Offset(-16, 0),
                            curve: Curves.easeOutQuad,
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
      ),
    );
  }
}
