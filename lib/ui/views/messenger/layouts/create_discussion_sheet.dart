import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateDiscussionSheet extends ConsumerStatefulWidget {
  const CreateDiscussionSheet({super.key});

  static const routerPage = '/create_discussion';

  @override
  ConsumerState<CreateDiscussionSheet> createState() =>
      CreateDiscussionSheetState();
}

class CreateDiscussionSheetState extends ConsumerState<CreateDiscussionSheet> {
  final pickerItemsList = List<PickerItem>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final contactsList = await ref.read(
        ContactProviders.fetchContacts().future,
      );
      final selectedAccount =
          await ref.read(AccountProviders.selectedAccount.future);

      if (contactsList.isNotEmpty) {
        for (final contact in contactsList) {
          if (contact.format.toUpperCase() !=
              selectedAccount?.nameDisplayed.toUpperCase()) {
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
        ref.watch(MessengerProviders.createDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.createDiscussionForm);

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.newDiscussion,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
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
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: <Widget>[
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
                                  TextButton(
                                    onPressed: () {
                                      context.push(AddContactSheet.routerPage);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Symbols.person_add,
                                          color: ArchethicTheme.text,
                                          weight: IconSize.weightM,
                                          opticalSize: IconSize.opticalSizeM,
                                          grade: IconSize.gradeM,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          localizations.newContact,
                                          style: ArchethicThemeStyles
                                              .textStyleSize14W700Primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(color: ArchethicTheme.text),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    localizations.contactsHeader,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W200Primary
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
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
                                          formNotifier.addMember(
                                            member.value as Contact,
                                          );
                                        },
                                        onUnselected: (member) {
                                          formNotifier.removeMember(
                                            member.value as Contact,
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
                                            localizations.next,
                                            const [0, 0, 0, 0],
                                            key: const Key(
                                              'discussionNextButton',
                                            ),
                                            onPressed: () {
                                              context.go(
                                                CreateDiscussionValidationSheet
                                                    .routerPage,
                                                extra: {
                                                  'onDispose': formNotifier
                                                      .resetValidation,
                                                },
                                              );
                                            },
                                            disabled:
                                                formState.canGoNext == false,
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
      ),
    );
  }
}
