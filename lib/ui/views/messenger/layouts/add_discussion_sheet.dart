import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/access_recipient_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_provider.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddDiscussionSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const AddDiscussionSheet({
    required this.discussion,
    super.key,
  });

  static const String routerPage = '/add_discussion';

  final Discussion discussion;

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
    final localizations = AppLocalizations.of(context)!;

    return AppButtonTiny(
      AppButtonTinyType.primary,
      localizations.addRemoteMessengerGroup,
      Dimens.buttonBottomDimens,
      key: const Key('addRemoteMessengerGroup'),
      onPressed: () async {
        await ref
            .read(MessengerProviders.discussions.notifier)
            .addRemoteDiscussion(discussion);
        ref
            .read(
              DiscussionSearchBarProvider.discussionSearchBar.notifier,
            )
            .reset();
        context.pop();
      },
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: ref.watch(
        MessengerProviders.discussionDisplayName(discussion),
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

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
                  ArchethicTheme.text,
                  ArchethicTheme.snackBarShadow,
                  icon: Symbols.info,
                );
              },
              child: SheetHeader(
                title: ref.watch(
                  MessengerProviders.discussionDisplayName(discussion),
                ),
              ),
            ),
            _SectionTitle(
              text: localizations.messengerDiscussionMembersCount(
                discussion.membersPubKeys.length,
              ),
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
                              context.push(
                                ContactDetail.routerPage,
                                extra: ContactDetailsRouteParams(
                                  contactAddress:
                                      contact.contact.genesisAddress!,
                                ).toJson(),
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
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
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
    final localizations = AppLocalizations.of(context)!;
    final accessRecipient = ref.watch(
      MessengerProviders.accessRecipientWithPublicKey(
        pubKey,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ArchethicTheme.backgroundAccountsListCardSelected,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: ArchethicTheme.backgroundAccountsListCardSelected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          color: ArchethicTheme.backgroundAccountsListCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutoSizeText(
                  accessRecipient.maybeMap(
                    data: (data) => data.value.format(localizations),
                    orElse: () => '...',
                  ),
                  style: ArchethicThemeStyles.textStyleSize12W600Primary,
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
                    Symbols.arrow_forward_ios,
                    size: 12,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
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
    final isAdmin = discussion.adminsPubKeys.any(
      (adminPubKey) => adminPubKey == memberPubKey,
    );

    if (isAdmin) {
      return Text(
        'Admin',
        style: ArchethicThemeStyles.textStyleSize12W100Primary,
      );
    }

    return Container();
  }
}
