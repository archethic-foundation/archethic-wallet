import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/add_public_key_textfield_pk.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/public_key_item.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTalkSheet extends ConsumerWidget {
  const CreateTalkSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final formNotifier =
        ref.watch(MessengerProviders.talkCreationForm.notifier);
    final formState = ref.watch(MessengerProviders.talkCreationForm);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.addMessengerTalk,
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        localizations.introNewMessengerTalk,
                        style: theme.textStyleSize14W600Primary,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: AddMessengerTalkNameTextField(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          localizations.messengerTalkAccessDescription,
                          style: theme.textStyleSize12W100Primary,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AddPublicKeyTextFieldPk(
                              onChanged: (recipient) {
                                if (recipient == null) return;
                                formNotifier.setMemberAddFieldValue(recipient);
                              },
                            ),
                          ),
                          TextButton.icon(
                            onPressed: formState.memberAddFieldValue
                                        ?.isPublicKeyValid ??
                                    false
                                ? () {
                                    formNotifier.addMember(
                                      formState.memberAddFieldValue!,
                                    );
                                  }
                                : null,
                            style: TextButton.styleFrom(
                              iconColor: theme.text,
                              disabledIconColor: Colors.grey,
                            ),
                            icon: const Icon(Icons.add),
                            label: Container(),
                          ),
                        ],
                      ),
                      Column(
                        children: formState.members
                            .map(
                              (e) => PublicKeyLine(
                                accessRecipient: e,
                                onTapRemove: () => formNotifier.removeMember(e),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (formState.canSubmit)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.addMessengerTalk,
                        Dimens.buttonBottomDimens,
                        key: const Key('addMessengerTalk'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        onPressed: () async {
                          ShowSendingAnimation.build(
                            context,
                            theme,
                          );
                          final result = await formNotifier.createTalk();
                          Navigator.of(context).pop();

                          result.map(
                            success: (success) {
                              Navigator.of(context).pop();
                            },
                            failure: (failure) {
                              UIUtil.showSnackbar(
                                localizations.addMessengerTalkFailure,
                                context,
                                ref,
                                theme.text!,
                                theme.snackBarShadow!,
                                duration: const Duration(seconds: 5),
                              );
                            },
                          );
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.addMessengerTalk,
                        Dimens.buttonBottomDimens,
                        key: const Key('addMessengerTalk'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddMessengerTalkNameTextField extends ConsumerStatefulWidget {
  const AddMessengerTalkNameTextField({
    super.key,
  });

  @override
  ConsumerState<AddMessengerTalkNameTextField> createState() =>
      _AddMessengerTalkNameTextFieldState();
}

class _AddMessengerTalkNameTextFieldState
    extends ConsumerState<AddMessengerTalkNameTextField> {
  late TextEditingController nameController;
  late FocusNode nameFocusNode;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    nameController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final createTalkFormNotifier =
        ref.watch(MessengerProviders.talkCreationForm.notifier);

    return AppTextField(
      focusNode: nameFocusNode,
      controller: nameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: localizations.addMessengerGroupNameLabel,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(
          20,
        ),
        UpperCaseTextFormatter(),
      ],
      onChanged: (text) async {
        createTalkFormNotifier.setName(text);
      },
    );
  }
}
