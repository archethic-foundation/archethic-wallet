import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDiscussionAddMembers extends ConsumerStatefulWidget {
  const UpdateDiscussionAddMembers({super.key, required this.listMembers});

  final List<String> listMembers;

  Future<bool> canAddNewMembers(WidgetRef ref) async {
    final contactsList = await ref.read(
      ContactProviders.fetchContacts().future,
    );

    var atLeastOneContactToAdd = false;
    for (final contact in contactsList) {
      if (listMembers.contains(contact.publicKey) == false &&
          PublicKey(contact.publicKey).isValid == true) {
        atLeastOneContactToAdd = true;
      }
    }

    return atLeastOneContactToAdd;
  }

  @override
  ConsumerState<UpdateDiscussionAddMembers> createState() =>
      UpdateDiscussionAddMembersState();
}

class UpdateDiscussionAddMembersState
    extends ConsumerState<UpdateDiscussionAddMembers> {
  final pickerItemsList = List<PickerItem>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final contactsList = await ref.read(
        ContactProviders.fetchContacts().future,
      );

      if (contactsList.isNotEmpty) {
        for (final contact in contactsList) {
          // We can only add contacts that are not members of the current discussion
          if (widget.listMembers.contains(contact.publicKey) == false &&
              PublicKey(contact.publicKey).isValid == true) {
            pickerItemsList.add(
              PickerItem(
                contact.format,
                null,
                null,
                null,
                contact,
                true,
              ),
            );
          }
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final formNotifier =
        ref.watch(MessengerProviders.updateDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.updateDiscussionForm);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.addMembers,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return ArchethicScrollbar(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Visibility(
                                  visible: pickerItemsList.isEmpty,
                                  child: Expanded(
                                    child: Text(
                                      localizations.noContacts,
                                      style: ArchethicThemeStyles
                                          .textStyleSize14W200Primary,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: pickerItemsList.isNotEmpty,
                                  child: Expanded(
                                    child: PickerWidget(
                                      multipleSelectionsAllowed: true,
                                      pickerItems: pickerItemsList,
                                      onSelected: (member) {
                                        formNotifier.addMemberToAdd(
                                          (member.value as Contact).publicKey,
                                        );
                                      },
                                      onUnselected: (member) {
                                        formNotifier.removeMemberToAdd(
                                          (member.value as Contact).publicKey,
                                        );
                                      },
                                      height:
                                          1, // fake height within an expanded widget, only way to make it work for our usage
                                      scrollable: true,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      children: <Widget>[
                                        AppButtonTinyConnectivity(
                                          localizations.add,
                                          const [0, 0, 0, 0],
                                          key: const Key('addMembers'),
                                          onPressed: () {
                                            formNotifier.addAllMembersToAdd();
                                            Navigator.of(context).pop();
                                          },
                                          disabled:
                                              formState.canAddMembers == false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
