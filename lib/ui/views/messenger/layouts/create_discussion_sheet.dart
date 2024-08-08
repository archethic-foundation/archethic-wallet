import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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

class CreateDiscussionSheetState extends ConsumerState<CreateDiscussionSheet>
    implements SheetSkeletonInterface {
  final pickerItemsList = List<PickerItem>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final contactsList = await ref.read(
        ContactProviders.fetchContacts().future,
      );
      final selectedAccount =
          await ref.read(AccountProviders.accounts.future).selectedAccount;

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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
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
          context.go(HomePage.routerPage);
        },
      ),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(MessengerProviders.createDiscussionForm);
    final localizations = AppLocalizations.of(context)!;

    return AppButtonTinyConnectivity(
      localizations.next,
      Dimens.buttonBottomDimens,
      key: const Key('discussionNextButton'),
      onPressed: () {
        context.push(
          CreateDiscussionValidationSheet.routerPage,
          extra: {
            'fromRouterPage': CreateDiscussionSheet.routerPage,
          },
        );
      },
      disabled: formState.canGoNext == false,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final formNotifier =
        ref.watch(MessengerProviders.createDiscussionForm.notifier);

    return Column(
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
                style: ArchethicThemeStyles.textStyleSize14W700Primary,
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
          style: ArchethicThemeStyles.textStyleSize14W200Primary
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        if (pickerItemsList.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                localizations.noContacts,
                style: ArchethicThemeStyles.textStyleSize14W200Primary,
              ),
            ),
          )
        else
          PickerWidget(
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
            height: MediaQuery.of(context).size.height - 100,
            scrollable: true,
          ),
      ],
    );
  }
}
