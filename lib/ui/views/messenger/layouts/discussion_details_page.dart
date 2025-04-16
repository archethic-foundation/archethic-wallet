import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/public_key_line.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_page.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _DiscussionDetailsPageState extends ConsumerState<DiscussionDetailsPage>
    implements SheetSkeletonInterface {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final formNotifier =
        ref.watch(MessengerProviders.discussionDetailsForm.notifier);
    final localizations = AppLocalizations.of(context)!;
    final discussion =
        ref.watch(MessengerProviders.discussion(widget.discussionAddress));
    final selectedAccount = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;

    if (discussion.value != null &&
        discussion.value!.membersPubKeys.any(
          (element) => element == selectedAccount?.publicKey,
        )) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnFooterPrimary(
            buttonText: localizations.addressCopy,
            onTap: () {
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
          ),
          const SizedBox(
            height: 10,
          ),
          BtnFooterPrimary(
            buttonText: localizations.leaveDiscussion,
            onTap: () {
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
                  context.loadingOverlay.show();
                  final result = await formNotifier.leaveDiscussion();

                  context.loadingOverlay.hide();
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
          ),
        ],
      );
    }

    return BtnFooterPrimary(
      buttonText: localizations.youAreNoLongPartOfDiscussion,
      onTap: null,
      isLocked: true,
      lockedIcon: true,
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final selectedAccount = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;
    final discussion =
        ref.watch(MessengerProviders.discussion(widget.discussionAddress));

    return SheetAppBar(
      title: localizations.discussionInfo,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
      widgetRight: discussion.maybeMap(
        data: (data) {
          return (selectedAccount != null &&
                  data.value.adminsPubKeys.contains(
                    AccessRecipient.account(account: selectedAccount).name,
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
              : const SizedBox.shrink();
        },
        orElse: () {
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final discussion =
        ref.watch(MessengerProviders.discussion(widget.discussionAddress));

    return discussion.maybeMap(
      data: (data) {
        return Column(
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
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Expanded(
                child: ArchethicScrollbar(
                  child: ExpansionTile(
                    shape: const Border(),
                    initiallyExpanded: true,
                    title: Text(
                      localizations.messengerDiscussionMembersCount(
                        data.value.membersPubKeys.length,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    children: [
                      Column(
                        children: data.value.membersPubKeys.map((pubKey) {
                          return PublicKeyLine(
                            listAdmins: data.value.adminsPubKeys,
                            pubKey: pubKey,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
