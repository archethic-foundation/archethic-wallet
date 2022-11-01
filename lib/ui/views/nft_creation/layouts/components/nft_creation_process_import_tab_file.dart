/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              final result = await FilePicker.platform.pickFiles();

              if (result != null) {
                nftCreationNotifier.setFileProperties(
                  File(result.files.single.path!),
                  FileImportType.file,
                );
              } else {
                // User canceled the picker
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
