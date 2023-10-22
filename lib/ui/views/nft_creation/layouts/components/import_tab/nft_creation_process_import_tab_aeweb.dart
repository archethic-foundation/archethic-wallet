/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

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

    return InkWell(
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
      child: SizedBox(
        height: 50,
        child: SheetDetailCard(
          children: [
            const Icon(UiIcons.archethic_icon, size: 18),
            const SizedBox(width: 5),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizations.nftAddImportAEWeb,
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
