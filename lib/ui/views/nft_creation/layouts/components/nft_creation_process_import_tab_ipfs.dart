/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabIPFS extends ConsumerWidget {
  const NFTCreationProcessImportTabIPFS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

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
          widget: NFTCreationProcessImportTabIPFSForm(
            onConfirm: (uri) {
              nftCreationNotifier.setContentIPFSProperties(
                context,
                uri,
              );
            },
          ),
        );
      },
      text: localizations.nftAddImportIPFS,
      background: Image.asset('assets/images/NFT_upload_photo.png'),
    );
  }
}
