/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabHTTP extends ConsumerWidget {
  const NFTCreationProcessImportTabHTTP({super.key});

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
          widget: NFTCreationProcessImportTabHTTPForm(
            onConfirm: (uri) {
              nftCreationNotifier.setContentHTTPProperties(
                context,
                uri,
              );
            },
          ),
        );
      },
      child: SheetDetailCard(
        children: [
          const Icon(Iconsax.code_circle, size: 18),
          Text(
            localizations.nftAddImportUrl,
            style: theme.textStyleSize12W400Primary,
          ),
        ],
      ),
    );
  }
}
