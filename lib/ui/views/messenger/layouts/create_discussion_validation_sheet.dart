import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateDiscussionValidationSheet extends ConsumerStatefulWidget {
  const CreateDiscussionValidationSheet({
    super.key,
  });

  @override
  ConsumerState<CreateDiscussionValidationSheet> createState() =>
      _CreateDiscussionValidationSheetState();
}

class _CreateDiscussionValidationSheetState
    extends ConsumerState<CreateDiscussionValidationSheet> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final formState = ref.read(MessengerProviders.createDiscussionForm);
      final formNotifier =
          ref.read(MessengerProviders.createDiscussionForm.notifier);

      // When the users selects only one contact, no need to ask him for the name of the discussion
      if (formState.membersList.length == 1) {
        final discussionDefaultName = formState.membersList.first.format;
        formNotifier.setName(discussionDefaultName);
        nameController.text = discussionDefaultName;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    final formNotifier =
        ref.watch(MessengerProviders.createDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.createDiscussionForm);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                height: 5,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  color: theme.text60,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Row(
                children: [
                  BackButton(
                    key: const Key('back'),
                    color: theme.text,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  AutoSizeText(
                    localizations.newDiscussion,
                    style: theme.textStyleSize24W700EquinoxPrimary,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    stepGranularity: 0.1,
                  ),
                ],
              ),
              Visibility(
                visible: formState.membersList.length > 1,
                child: AppTextField(
                  leftMargin: 0,
                  rightMargin: 0,
                  labelText: localizations.name,
                  onChanged: (text) {
                    formNotifier.setName(text);
                  },
                  controller: nameController,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                localizations.aboutToCreateADiscussion,
                style: theme.textStyleSize14W600Primary,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: formState.membersList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          formState.membersList[index].format,
                          style: theme.textStyleSize16W700Primary,
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {
                            Sheets.showAppHeightNineSheet(
                              context: context,
                              ref: ref,
                              widget: ContactDetail(
                                contact: formState.membersList[index],
                                readOnly: true,
                              ),
                            );
                          },
                          icon: const Icon(
                            Symbols.info,
                            weight: IconSize.weightM,
                            opticalSize: IconSize.opticalSizeM,
                            grade: IconSize.gradeM,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.createDiscussion,
                        Dimens.none,
                        key: const Key('addMessengerDiscussion'),
                        icon: Icon(
                          Symbols.add,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                          color: formState.canSubmit
                              ? theme.mainButtonLabel
                              : theme
                                  .textStyleSize18W600EquinoxMainButtonLabelDisabled
                                  .color,
                          size: 14,
                        ),
                        disabled: formState.canSubmit == false,
                        onPressed: () async {
                          ShowSendingAnimation.build(
                            context,
                            theme,
                          );

                          final result = await formNotifier.createDiscussion();
                          Navigator.of(context).pop(); // wait popup

                          result.map(
                            success: (success) {
                              Navigator.of(context)
                                  .pop(); // create discussion validation sheet
                              Navigator.of(context)
                                  .pop(); // create discussion sheet
                            },
                            failure: (failure) {
                              UIUtil.showSnackbar(
                                localizations.addMessengerDiscussionFailure,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
