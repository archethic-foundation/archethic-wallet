/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabCamera extends ConsumerWidget {
  const NFTCreationProcessImportTabCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return CardCategoryWithText(
      onTap: () async {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        if (pickedFile != null) {
          nftCreationNotifier.setContentProperties(
            context,
            File(pickedFile.path),
            FileImportType.camera,
          );
        }
      },
      text: localizations.nftAddImportCamera,
      background: Image.asset('assets/images/NFT_upload_photo.png'),
    );
  }
}
