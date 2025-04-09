import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedapppfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateDiscussionValidationSheet extends ConsumerStatefulWidget {
  const CreateDiscussionValidationSheet({
    super.key,
    this.discussionCreationSuccess,
    this.fromRouterPage,
  });

  final Function? discussionCreationSuccess;
  final String? fromRouterPage;

  static const String routerPage = '/create_discussion_validation';

  @override
  ConsumerState<CreateDiscussionValidationSheet> createState() =>
      _CreateDiscussionValidationSheetState();
}

class _CreateDiscussionValidationSheetState
    extends ConsumerState<CreateDiscussionValidationSheet>
    implements SheetSkeletonInterface {
  TextEditingController nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void dispose() {
    if (widget.fromRouterPage == CreateDiscussionValidationSheet.routerPage) {
      ref
          .watch(MessengerProviders.createDiscussionForm.notifier)
          .removeAllMembers();
    }

    if (widget.fromRouterPage == CreateDiscussionSheet.routerPage) {
      ref
          .read(MessengerProviders.createDiscussionForm.notifier)
          .resetValidation();
    }
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();

    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

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

    return BtnFooterPrimary(
      buttonText: localizations.createDiscussion,
      key: const Key('addMessengerDiscussion'),
      isLocked: formState.canSubmit == false,
      onTap: () async {
        context.loadingOverlay.show();

        final result = await formNotifier.createDiscussion();

        context.loadingOverlay.hide();
        result.map(
          success: (success) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: formState.membersList.length > 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  AppLocalizations.of(context)!.discussionNameHint,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeightTelegraf.fontWeightBold,
                      ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _hasFocus ? Colors.black : null,
                      ),
                  autocorrect: false,
                  controller: nameController,
                  onChanged: formNotifier.setName,
                  focusNode: _focusNode,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _hasFocus
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.15),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                ),
              ),
            ],
          )
              .animate()
              .fade(duration: const Duration(milliseconds: 200))
              .scale(duration: const Duration(milliseconds: 200)),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          localizations.aboutToCreateADiscussion,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeightTelegraf.fontWeightBold,
              ),
        ),
        aedapppfm.BlockInfo(
          blockInfoColor: aedapppfm.BlockInfoColor.purple,
          paddingEdgeInsetsClipRRect: const EdgeInsets.only(
            top: 5,
          ),
          paddingEdgeInsetsInfo: const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          borderWidth: 0,
          width: MediaQuery.of(context).size.width,
          info: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: formState.membersList.map((member) {
                  return Row(
                    children: [
                      Text(
                        member.format,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightRegular,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          context.push(
                            ContactDetail.routerPage,
                            extra: ContactDetailsRouteParams(
                              contactAddress: member.genesisAddress!,
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
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
