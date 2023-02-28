/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabIPFS extends ConsumerWidget {
  const NFTCreationProcessImportTabIPFS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return CardCategoryWithText(
      onTap: () async {
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: const NFTCreationProcessImportTabIPFSForm(),
        );
      },
      text: localizations.nftAddImportPhoto,
      background: Image.asset('assets/images/category_nft_art.jpg'),
    );
  }
}
