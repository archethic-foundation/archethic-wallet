import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/util/access_recipient_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/public_key_line.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/section_title.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_add_members.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class UpdateDiscussionPage extends ConsumerStatefulWidget {
  const UpdateDiscussionPage({required this.discussion, super.key});

  final Discussion discussion;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateDiscussionPageState();
}

class _UpdateDiscussionPageState extends ConsumerState<UpdateDiscussionPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameController.text = widget.discussion.name ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(MessengerProviders.updateDiscussionForm.notifier)
          .localizations = AppLocalizations.of(context)!;
      ref
          .watch(MessengerProviders.updateDiscussionForm.notifier)
          .init(widget.discussion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final settings = ref.watch(SettingsProviders.settings);

    final formNotifier =
        ref.watch(MessengerProviders.updateDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.updateDiscussionForm);

    var index = 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            theme.background3Small!,
          ),
          fit: BoxFit.fitHeight,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[theme.backgroundDark!, theme.background!],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(localizations.discussionModifying),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          child: Column(
            children: [
              AppTextField(
                labelText: localizations.name,
                onChanged: (text) {
                  formNotifier.setName(text);
                },
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ArchethicScrollbar(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(color: theme.text),
                      TextButton(
                        onPressed: () async {
                          final updateDiscussionAddMembers =
                              UpdateDiscussionAddMembers(
                            listMembers: formState.listMembers,
                          );
                          if (await updateDiscussionAddMembers
                                  .canAddNewMembers(ref) ==
                              false) {
                            UIUtil.showSnackbar(
                              localizations.noContactsToAdd,
                              context,
                              ref,
                              theme.text!,
                              theme.snackBarShadow!,
                            );
                            return;
                          }

                          Sheets.showAppHeightNineSheet(
                            onDisposed: () {
                              formNotifier.removeAllMembersToAdd();
                            },
                            context: context,
                            ref: ref,
                            widget: updateDiscussionAddMembers,
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Symbols.group_add,
                              color: theme.text,
                              weight: IconSize.weightM,
                              opticalSize: IconSize.opticalSizeM,
                              grade: IconSize.gradeM,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              localizations.addMembers,
                              style: theme.textStyleSize14W700Primary,
                            ),
                          ],
                        ),
                      ),
                      SectionTitle(
                        text: localizations.messengerDiscussionMembersCount(
                          formState.numberOfMembers,
                        ),
                      ),
                      Column(
                        children: formState.listMembers.map((pubKey) {
                          index++;
                          final accessRecipient = ref.watch(
                            MessengerProviders.accessRecipientWithPublicKey(
                              pubKey,
                            ),
                          );

                          final addAdminAvailable = formState.listAdmins.any(
                                (adminPubKey) => adminPubKey == pubKey,
                              ) ==
                              false;

                          return PublicKeyLine(
                            listAdmins: formState.listAdmins,
                            pubKey: pubKey,
                            onTap: () {
                              showModalBottomSheet<void>(
                                showDragHandle: true,
                                context: context,
                                builder: (BuildContext context) {
                                  final accessRecipient = ref.watch(
                                    MessengerProviders
                                        .accessRecipientWithPublicKey(
                                      pubKey,
                                    ),
                                  );

                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: SizedBox(
                                      height: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                accessRecipient.maybeMap(
                                                  data: (data) => data.value
                                                      .format(localizations),
                                                  orElse: () => '...',
                                                ),
                                                style: theme
                                                    .textStyleSize16W700Primary,
                                              ),
                                              Divider(
                                                color: theme.text,
                                                thickness: 0.5,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  if (addAdminAvailable)
                                                    IconButton(
                                                      icon: Row(
                                                        children: [
                                                          const Icon(
                                                            Symbols
                                                                .shield_person,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Text(
                                                            localizations
                                                                .addAdmin,
                                                            style: theme
                                                                .textStyleSize14W700Primary,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        formNotifier
                                                            .addAdmin(pubKey);
                                                        Navigator.pop(
                                                          context,
                                                        );
                                                      },
                                                    )
                                                  else
                                                    IconButton(
                                                      icon: Row(
                                                        children: [
                                                          const Icon(
                                                            Symbols.remove,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Text(
                                                            localizations
                                                                .removeAdmin,
                                                            style: theme
                                                                .textStyleSize14W700Primary,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        formNotifier
                                                            .removeAdmin(
                                                          pubKey,
                                                        );
                                                        Navigator.pop(
                                                          context,
                                                        );
                                                      },
                                                    ),
                                                  IconButton(
                                                    icon: Row(
                                                      children: [
                                                        const Icon(
                                                          Symbols.unsubscribe,
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          localizations
                                                              .removeDiscussion,
                                                          style: theme
                                                              .textStyleSize14W700Primary,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      formNotifier.removeMember(
                                                        pubKey,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            onInfoTap: accessRecipient.maybeMap(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.save,
                    Dimens.buttonBottomDimens,
                    key: const Key('modifyDiscussion'),
                    onPressed: () async {
                      ShowSendingAnimation.build(
                        context,
                        theme,
                      );
                      final result = await formNotifier.updateDiscussion();

                      Navigator.of(context).pop(); // wait popup

                      result.map(
                        success: (errorMessage) {
                          if (errorMessage != null) {
                            UIUtil.showSnackbar(
                              errorMessage,
                              context,
                              ref,
                              theme.text!,
                              theme.snackBarShadow!,
                            );
                            return;
                          }

                          Navigator.of(context)
                              .pop(); // Going back to discussion details
                        },
                        failure: (failure) {
                          UIUtil.showSnackbar(
                            localizations.updateDiscussionFailure,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                            duration: const Duration(seconds: 5),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
