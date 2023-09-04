import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/util/access_recipient_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_provider.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AddDiscussionSheet extends ConsumerWidget {
  const AddDiscussionSheet({
    required this.discussion,
    super.key,
  });

  final Discussion discussion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final settings = ref.watch(SettingsProviders.settings);

    var index = 0;
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      settings.activeVibrations,
                    );
                Clipboard.setData(
                  ClipboardData(
                    text: discussion.address.toUpperCase(),
                  ),
                );
                UIUtil.showSnackbar(
                  localizations.addressCopied,
                  context,
                  ref,
                  theme.text!,
                  theme.snackBarShadow!,
                );
              },
              child: SheetHeader(
                title: ref.watch(
                    MessengerProviders.discussionDisplayName(discussion)),
              ),
            ),
            _SectionTitle(
              text: localizations.messengerDiscussionMembersCount(
                  discussion.membersPubKeys.length),
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: discussion.membersPubKeys.map((publicKey) {
                      index++;
                      final accessRecipient = ref.watch(
                        MessengerProviders.accessRecipientWithPublicKey(
                          publicKey,
                        ),
                      );

                      return PublicKeyLine(
                        discussion: discussion,
                        pubKey: publicKey,
                        onTap: accessRecipient.maybeMap(
                          orElse: () => null,
                          data: (recipient) => recipient.value.map(
                            contact: (contact) => () {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    settings.activeVibrations,
                                  );

                              Sheets.showAppHeightNineSheet(
                                context: context,
                                ref: ref,
                                widget: ContactDetail(
                                  contact: contact.contact,
                                ),
                              );
                            },
                            publicKey: (_) => null,
                          ),
                        ),
                      )
                          .animate(delay: (100 * index).ms)
                          .fadeIn(duration: 900.ms, delay: 200.ms)
                          .shimmer(
                            blendMode: BlendMode.srcOver,
                            color: Colors.white12,
                          )
                          .move(
                            begin: const Offset(-16, 0),
                            curve: Curves.easeOutQuad,
                          );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.addRemoteMessengerGroup,
                  Dimens.buttonBottomDimens,
                  key: const Key('addRemoteMessengerGroup'),
                  icon: Icon(
                    Icons.add,
                    color: theme.mainButtonLabel,
                    size: 14,
                  ),
                  onPressed: () async {
                    await ref
                        .read(MessengerProviders.discussions.notifier)
                        .addRemoteDiscussion(discussion);
                    ref
                        .read(
                          DiscussionSearchBarProvider
                              .discussionSearchBar.notifier,
                        )
                        .reset();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends ConsumerWidget {
  const _SectionTitle({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 6,
          top: 24,
        ),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: theme.textStyleSize14W600Primary,
        ),
      ),
    );
  }
}

class PublicKeyLine extends ConsumerWidget {
  const PublicKeyLine({
    super.key,
    required this.pubKey,
    required this.discussion,
    this.onTap,
  });

  final Discussion discussion;
  final String pubKey;
  final VoidCallback? onTap;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final accessRecipient = ref.watch(
      MessengerProviders.accessRecipientWithPublicKey(
        pubKey,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.backgroundAccountsListCardSelected!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.backgroundAccountsListCardSelected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          color: theme.backgroundAccountsListCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutoSizeText(
                  accessRecipient.maybeMap(
                    data: (data) => data.value.format(localizations),
                    orElse: () => '...',
                  ),
                  style: theme.textStyleSize12W600Primary,
                ),
              ),
              _MemberRole(
                discussion: discussion,
                memberPubKey: pubKey,
              ),
              if (onTap != null)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberRole extends ConsumerWidget {
  const _MemberRole({
    required this.memberPubKey,
    required this.discussion,
  });

  final String memberPubKey;
  final Discussion discussion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final isAdmin = discussion.adminsPubKeys.any(
      (adminPubKey) => adminPubKey == memberPubKey,
    );

    if (isAdmin) {
      return Text(
        'Admin',
        style: theme.textStyleSize12W100Primary,
      );
    }

    return Container();
  }
}
