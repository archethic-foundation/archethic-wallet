import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/add_public_key_textfield_pk.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateDiscussionContactSheet extends ConsumerStatefulWidget {
  const CreateDiscussionContactSheet({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  ConsumerState<CreateDiscussionContactSheet> createState() =>
      _CreateDiscussionContactSheetState();
}

class _CreateDiscussionContactSheetState
    extends ConsumerState<CreateDiscussionContactSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(MessengerProviders.discussionContactCreationForm.notifier)
          .setName(widget.contact.format);
      final member = AddPublicKeyTextFieldValue.contact(contact: widget.contact)
          .toAccessRecipient!;
      ref
          .read(MessengerProviders.discussionContactCreationForm.notifier)
          .addMember(member);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final formNotifier =
        ref.watch(MessengerProviders.discussionContactCreationForm.notifier);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Column(
              children: [
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
              ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localizations.aboutToCreateADiscussion,
                        style: theme.textStyleSize14W600Primary,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.contact.format,
                            style: theme.textStyleSize16W700Primary,
                          ),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            onPressed: () {
                              Sheets.showAppHeightNineSheet(
                                context: context,
                                ref: ref,
                                widget: ContactDetail(
                                  contact: widget.contact,
                                  editMode: false,
                                ),
                              );
                            },
                            icon: const Icon(Icons.info_outline),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.createDiscussion,
                  Dimens.buttonBottomDimens,
                  key: const Key('addMessengerDiscussion'),
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
                    final result = await formNotifier.createDiscussion();
                    Navigator.of(context).pop(); // wait popup

                    result.map(
                      success: (success) {
                        Navigator.of(context).pop(); // new contact sheet
                        Navigator.of(context).pop(); // new discussion sheet
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
          ],
        ),
      ),
    );
  }
}
