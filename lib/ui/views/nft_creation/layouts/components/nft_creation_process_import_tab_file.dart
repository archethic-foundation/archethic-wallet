/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
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
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                  child: FaIcon(
                    FontAwesomeIcons.file,
                    size: 18,
                    color: theme.text,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  localizations.nftAddImportFile,
                  style: theme.textStyleSize12W400Primary,
                ),
                const SizedBox(
                  width: 30,
                ),
                if (nftCreation.fileImportType == FileImportType.file)
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.green,
                  )
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
