/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabCamera extends ConsumerWidget {
  const NFTCreationProcessImportTabCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb == true ||
        (Platform.isAndroid == false && Platform.isIOS == false)) {
      return const SizedBox();
    }

    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return InkWell(
      onTap: () async {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        if (pickedFile != null) {
          nftCreationNotifier.setContentProperties(
            context,
            File(pickedFile.path).readAsBytesSync(),
            FileImportType.camera,
            Mime.getTypesFromExtension(
              path.extension(pickedFile.path).toLowerCase().replaceAll('.', ''),
            )![0],
          );
        }
      },
      child: SizedBox(
        height: 50,
        child: SheetDetailCard(
          children: [
            const Icon(
              Symbols.photo_camera,
              size: 18,
              weight: 300,
              opticalSize: 48,
              grade: -25,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizations.nftAddImportCamera,
                  style: theme.textStyleSize12W100Primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
