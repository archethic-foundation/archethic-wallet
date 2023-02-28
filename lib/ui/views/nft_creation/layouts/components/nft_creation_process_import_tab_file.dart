/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

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
        final result = await FilePicker.platform.pickFiles();

        if (result != null) {
          nftCreationNotifier.setContentProperties(
            context,
            File(result.files.single.path!),
            FileImportType.file,
          );
        } else {
          // User canceled the picker
        }
      },
      text: localizations.nftAddImportFile,
      background: Image.asset('assets/images/category_nft_art.jpg'),
    );
  }
}
