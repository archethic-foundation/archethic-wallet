import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateDiscussionValidationSheet extends ConsumerStatefulWidget {
  const CreateDiscussionValidationSheet({
    super.key,
    this.discussionCreationSuccess,
    this.onDispose,
  });

  final Function? discussionCreationSuccess;
  final Function? onDispose;

  static const String routerPage = '/create_discussion_validation';

  @override
  ConsumerState<CreateDiscussionValidationSheet> createState() =>
      _CreateDiscussionValidationSheetState();
}

class _CreateDiscussionValidationSheetState
    extends ConsumerState<CreateDiscussionValidationSheet>
    implements SheetSkeletonInterface {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!;
    super.dispose();
  }

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
        await formNotifier.setName(discussionDefaultName);
        nameController.text = discussionDefaultName;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
    final formNotifier =
        ref.watch(MessengerProviders.createDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.createDiscussionForm);

    return Row(
      children: <Widget>[
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.createDiscussion,
          Dimens.none,
          key: const Key('addMessengerDiscussion'),
          disabled: formState.canSubmit == false,
          onPressed: () async {
            ShowSendingAnimation.build(
              context,
            );

            final result = await formNotifier.createDiscussion();
            context.pop(); // wait popup

            result.map(
              success: (success) {
                context
                  ..pop() // create discussion validation sheet
                  ..pop(); // create discussion sheet
                widget.discussionCreationSuccess?.call();
              },
              failure: (failure) {
                UIUtil.showSnackbar(
                  localizations.addMessengerDiscussionFailure,
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
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.newDiscussion,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final formNotifier =
        ref.watch(MessengerProviders.createDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.createDiscussionForm);

    return Column(
      children: <Widget>[
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
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
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
                    style: ArchethicThemeStyles.textStyleSize16W700Primary,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      context.push(
                        ContactDetail.routerPage,
                        extra: ContactDetailsRouteParams(
                          contactAddress:
                              formState.membersList[index].genesisAddress!,
                          readOnly: true,
                        ).toJson(),
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
      ],
    );
  }
}
