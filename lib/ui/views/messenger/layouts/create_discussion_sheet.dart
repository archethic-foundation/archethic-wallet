import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/account_formatters.dart';
import 'package:aewallet/util/pubkey_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedapppfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateDiscussionSheet extends ConsumerStatefulWidget {
  const CreateDiscussionSheet({super.key});

  static const routerPage = '/create_discussion';

  @override
  ConsumerState<CreateDiscussionSheet> createState() =>
      CreateDiscussionSheetState();
}

class CreateDiscussionSheetState extends ConsumerState<CreateDiscussionSheet>
    implements SheetSkeletonInterface {
  List<PickerItem> pickerItemsList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final apiService = ref.watch(apiServiceProvider);
      final selectedAccount = ref.watch(
        accountsNotifierProvider.select(
          (accounts) => accounts.valueOrNull?.selectedAccount,
        ),
      );

      await ref
          .read(accountsNotifierProvider.notifier)
          .fetchMissingGenesisPublicKeys();

      final contactsList = await ref.read(
        ContactProviders.fetchContacts().future,
      );
      for (final contact in contactsList) {
        if (contact.publicKey.isEmpty) {
          final contactPubKey = await PubKeyUtil.getGenesisPublicKey(
            contact.address,
            apiService,
          );
          if (contactPubKey != null) {
            contact.publicKey = contactPubKey;
            ref.read(ContactProviders.saveContact(contact: contact));
          }
        }
      }
      setState(() {
        pickerItemsList = [
          for (final contact in contactsList)
            if (contact.format.toUpperCase() !=
                selectedAccount?.nameDisplayed.toUpperCase())
              PickerItem(
                contact.format,
                null,
                null,
                null,
                contact,
                true,
              ),
        ];
      });
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
          context.go(Home.routerPage);
        },
      ),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(MessengerProviders.createDiscussionForm);
    final localizations = AppLocalizations.of(context)!;

    return BtnFooterPrimary(
      buttonText: localizations.next,
      key: const Key('discussionNextButton'),
      onTap: () {
        context.push(
          CreateDiscussionValidationSheet.routerPage,
          extra: {
            'fromRouterPage': CreateDiscussionSheet.routerPage,
          },
        );
      },
      isLocked: formState.canGoNext == false,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final formNotifier =
        ref.watch(MessengerProviders.createDiscussionForm.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        aedapppfm.BlockInfo(
          borderWidth: 0,
          blockInfoColor: aedapppfm.BlockInfoColor.purple,
          paddingEdgeInsetsInfo: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          info: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.newContactDesc,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeightTelegraf.fontWeightRegular,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              BtnPrimary(
                buttonText: localizations.newContact,
                onTap: () async {
                  await context.push(AddContactSheet.routerPage);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          localizations.contactsHeader,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeightTelegraf.fontWeightBold,
              ),
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
            paddingListView: EdgeInsets.zero,
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
