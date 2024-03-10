import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/public_key_line.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/section_title.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_page.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class DiscussionDetailsPage extends ConsumerStatefulWidget {
  const DiscussionDetailsPage({
    required this.discussionAddress,
    super.key,
  });

  final String discussionAddress;
  static const String routerPage = '/discussion_details';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DiscussionDetailsPageState();
}

class _DiscussionDetailsPageState extends ConsumerState<DiscussionDetailsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final discussion = await ref
          .read(MessengerProviders.discussion(widget.discussionAddress).future);
      ref
          .watch(MessengerProviders.discussionDetailsForm.notifier)
          .init(discussion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final settings = ref.watch(SettingsProviders.settings);
    final preferences = ref.watch(SettingsProviders.settings);
    final selectedContact =
        ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final discussion =
        ref.watch(MessengerProviders.discussion(widget.discussionAddress));

    final formNotifier =
        ref.watch(MessengerProviders.discussionDetailsForm.notifier);

    return discussion.maybeMap(
      data: (data) {
        return Scaffold(
          drawerEdgeDragWidth: 0,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          backgroundColor: ArchethicTheme.background,
          appBar: SheetAppBar(
            title: localizations.discussionInfo,
            widgetLeft: BackButton(
              key: const Key('back'),
              color: ArchethicTheme.text,
              onPressed: () {
                context.pop();
              },
            ),
            widgetRight: (selectedContact != null &&
                    data.value.adminsPubKeys.contains(
                      AccessRecipient.contact(contact: selectedContact)
                          .publicKey,
                    ))
                ? TextButton(
                    onPressed: () => context.push(
                      UpdateDiscussionPage.routerPage,
                      extra: data.value,
                    ),
                    child: Text(
                      localizations.modify,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                  )
                : null,
          ),
          body: Container(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
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
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    ref.watch(
                      MessengerProviders.discussionDisplayName(
                        data.value,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: ArchethicThemeStyles.textStyleSize28W700Primary,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(text: widget.discussionAddress),
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
                    child: Row(
                      children: [
                        Icon(
                          Symbols.content_copy,
                          color: ArchethicTheme.text,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          localizations.addressCopy,
                          style:
                              ArchethicThemeStyles.textStyleSize14W700Primary,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ArchethicScrollbar(
                      child: ExpansionTile(
                        shape: const Border(),
                        initiallyExpanded: true,
                        title: SectionTitle(
                          text: localizations.messengerDiscussionMembersCount(
                            data.value.membersPubKeys.length,
                          ),
                        ),
                        children: [
                          Column(
                            children: data.value.membersPubKeys.map((pubKey) {
                              final accessRecipient = ref.watch(
                                MessengerProviders.accessRecipientWithPublicKey(
                                  pubKey,
                                ),
                              );

                              return PublicKeyLine(
                                listAdmins: data.value.adminsPubKeys,
                                pubKey: pubKey,
                                onInfoTap: accessRecipient.maybeMap(
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
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (discussion.value != null &&
                      discussion.value!.membersPubKeys.any(
                        (element) => element == selectedContact?.publicKey,
                      ))
                    TextButton(
                      onPressed: () {
                        final language = ref.read(
                          LanguageProviders.selectedLanguage,
                        );

                        AppDialogs.showConfirmDialog(
                          context,
                          ref,
                          CaseChange.toUpperCase(
                            localizations.leaveDiscussion,
                            language.getLocaleString(),
                          ),
                          localizations.areYouSureLeaveDiscussion,
                          localizations.yes,
                          () async {
                            final auth = await AuthFactory.authenticate(
                              context,
                              ref,
                              activeVibrations: ref
                                  .read(SettingsProviders.settings)
                                  .activeVibrations,
                            );
                            if (auth == false) {
                              return;
                            }

                            ShowSendingAnimation.build(
                              context,
                            );
                            final result = await formNotifier.leaveDiscussion();

                            context.pop(); // wait popup

                            result.map(
                              success: (_) {
                                context.pop(); // Going back to discussion page
                              },
                              failure: (failure) {
                                UIUtil.showSnackbar(
                                  localizations.updateDiscussionFailure,
                                  context,
                                  ref,
                                  ArchethicTheme.text,
                                  ArchethicTheme.snackBarShadow,
                                  duration: const Duration(seconds: 5),
                                );
                              },
                            );
                          },
                          cancelText: localizations.no,
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Symbols.logout,
                            color: ArchethicThemeStyles
                                .textStyleSize14W600PrimaryRed.color,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            localizations.leaveDiscussion,
                            style: ArchethicThemeStyles
                                .textStyleSize14W600PrimaryRed,
                          ),
                        ],
                      ),
                    )
                  else
                    Text(
                      localizations.youAreNoLongPartOfDiscussion,
                      textAlign: TextAlign.center,
                      style: ArchethicThemeStyles.textStyleSize14W200Primary,
                    ),
                ],
              ),
            ),
          ),
        );
      },
      orElse: () => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
