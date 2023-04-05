/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabAEWeb extends ConsumerWidget {
  const NFTCreationProcessImportTabAEWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreationArgs = ref.watch(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return CardCategoryWithText(
      onTap: () async {
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: NFTCreationProcessImportTabAEWebForm(
            onConfirm: (uri) {
              nftCreationNotifier.setContentAEWebProperties(
                context,
                uri,
              );
            },
          ),
        );
      },
      text: localizations.nftAddImportAEWeb,
      background: Image.asset('assets/images/NFT_upload_aeweb.png'),
    );
  }
}
