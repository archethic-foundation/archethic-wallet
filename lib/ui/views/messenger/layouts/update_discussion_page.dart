import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/access_recipient_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/public_key_line.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/section_title.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_add_members.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class UpdateDiscussionPage extends ConsumerStatefulWidget {
  const UpdateDiscussionPage({required this.discussion, super.key});

  final Discussion discussion;
  static const routerPage = '/update_discussion';

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
    final localizations = AppLocalizations.of(context)!;
    final settings = ref.watch(SettingsProviders.settings);

    final formNotifier =
        ref.watch(MessengerProviders.updateDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.updateDiscussionForm);

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.discussionModifying,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
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
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
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
                      Divider(color: ArchethicTheme.text),
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
                              ArchethicTheme.text,
                              ArchethicTheme.snackBarShadow,
                            );
                            return;
                          }
                          context.go(
                            UpdateDiscussionAddMembers.routerPage,
                            extra: {
                              'listMembers': formState.listMembers,
                              'onDisposed': formNotifier.removeAllMembersToAdd,
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Symbols.group_add,
                              color: ArchethicTheme.text,
                              weight: IconSize.weightM,
                              opticalSize: IconSize.opticalSizeM,
                              grade: IconSize.gradeM,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              localizations.addMembers,
                              style: ArchethicThemeStyles
                                  .textStyleSize14W700Primary,
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
                                                style: ArchethicThemeStyles
                                                    .textStyleSize16W700Primary,
                                              ),
                                              Divider(
                                                color: ArchethicTheme.text,
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
                                                                .add_moderator,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Text(
                                                            localizations
                                                                .addAdmin,
                                                            style: ArchethicThemeStyles
                                                                .textStyleSize14W700Primary,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        formNotifier
                                                            .addAdmin(pubKey);
                                                        context.pop();
                                                      },
                                                    )
                                                  else
                                                    IconButton(
                                                      icon: Row(
                                                        children: [
                                                          const Icon(
                                                            Symbols
                                                                .remove_moderator,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Text(
                                                            localizations
                                                                .removeAdmin,
                                                            style: ArchethicThemeStyles
                                                                .textStyleSize14W700Primary,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        formNotifier
                                                            .removeAdmin(
                                                          pubKey,
                                                        );
                                                        context.pop();
                                                      },
                                                    ),
                                                  IconButton(
                                                    icon: Row(
                                                      children: [
                                                        const Icon(
                                                          Symbols.person_remove,
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          localizations
                                                              .removeDiscussion,
                                                          style: ArchethicThemeStyles
                                                              .textStyleSize14W700Primary,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      formNotifier.removeMember(
                                                        pubKey,
                                                      );
                                                      context.pop();
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
                                  context.push(
                                    ContactDetail.routerPage,
                                    extra: ContactDetailsRouteParams(
                                      contactAddress: contact.contact.address,
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
              Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.save,
                    Dimens.buttonBottomDimens,
                    key: const Key('modifyDiscussion'),
                    onPressed: () async {
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
                      final result =
                          await formNotifier.updateDiscussion(ref, context);

                      context.pop(); // wait popup

                      result.map(
                        success: (errorMessage) {
                          if (errorMessage != null) {
                            UIUtil.showSnackbar(
                              errorMessage,
                              context,
                              ref,
                              ArchethicTheme.text,
                              ArchethicTheme.snackBarShadow,
                            );
                            return;
                          }

                          context.pop(); // Going back to discussion details
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
