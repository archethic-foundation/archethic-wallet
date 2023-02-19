/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabCamera extends ConsumerWidget {
  const NFTCreationProcessImportTabCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb == true ||
        (Platform.isAndroid == false && Platform.isIOS == false)) {
      return const SizedBox();
    }

    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
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
                    path
                        .extension(pickedFile.path)
                        .toLowerCase()
                        .replaceAll('.', ''),
                  )![0],
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      child: FaIcon(
                        FontAwesomeIcons.cameraRetro,
                        size: 18,
                        color: theme.text,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      localizations.nftAddImportCamera,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    if (nftCreation.fileImportType == FileImportType.camera)
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 2,
          color: theme.text15,
        ),
      ],
    );
  }
}
