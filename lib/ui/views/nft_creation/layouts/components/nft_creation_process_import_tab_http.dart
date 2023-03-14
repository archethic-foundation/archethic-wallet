/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabHTTP extends ConsumerWidget {
  const NFTCreationProcessImportTabHTTP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    final nftCreationArgs = ref.watch(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return CardCategoryWithText(
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
      text: localizations.nftAddImportUrl,
      background: Image.asset('assets/images/category_nft_art.jpg'),
    );
  }
}
