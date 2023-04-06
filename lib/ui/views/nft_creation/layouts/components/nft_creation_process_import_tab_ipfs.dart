/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabIPFS extends ConsumerWidget {
  const NFTCreationProcessImportTabIPFS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
      child: SheetDetailCard(
        children: [
          const Icon(Iconsax.link, size: 18),
          Text(
            localizations.nftAddImportIPFS,
            style: theme.textStyleSize12W400Primary,
          ),
        ],
      ),
    );
  }
}
