/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    return InkWell(
      onTap: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result != null && result.files.isNotEmpty) {
          if (kIsWeb) {
            // TODO(reddwarf03): Fix Web uploading
            final uploadfile = result.files.single.bytes;
            await nftCreationNotifier.setContentProperties(
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
            // use for phone
            await nftCreationNotifier.setContentProperties(
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
      child: SizedBox(
        height: 50,
        child: SheetDetailCard(
          children: [
            const Icon(
              Symbols.description,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
              size: 18,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizations.nftAddImportFile,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
