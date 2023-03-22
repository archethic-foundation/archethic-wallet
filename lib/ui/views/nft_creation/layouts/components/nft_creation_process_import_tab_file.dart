/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return CardCategoryWithText(
      onTap: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result != null && result.files.isNotEmpty) {
          if (kIsWeb) {
            // TODO(reddwarf03): Fix Web uploading
            final uploadfile = result.files.single.bytes;
            nftCreationNotifier.setContentProperties(
              context,
              File.fromRawPath(uploadfile!).readAsBytesSync(),
              FileImportType.file,
              Mime.getTypesFromExtension(
                path
                    .extension(result.files.single.name)
                    .toLowerCase()
                    .replaceAll('.', ''),
              )![0],
            );
          } else {
            nftCreationNotifier.setContentProperties(
              context,
              File(result.files.single.path!).readAsBytesSync(),
              FileImportType.file,
              Mime.getTypesFromExtension(
                path
                    .extension(result.files.single.name)
                    .toLowerCase()
                    .replaceAll('.', ''),
              )![0],
            );
          }
        }
      },
      text: localizations.nftAddImportFile,
      background: Image.asset('assets/images/NFT_upload_photo.png'),
    );
  }
}
