/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTabHTTP extends ConsumerWidget {
  const NFTCreationProcessImportTabHTTP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    return InkWell(
      onTap: () async {
        context.go(
          NFTCreationProcessImportTabHTTPForm.routerPage,
          extra: (uri) {
            nftCreationNotifier.setContentHTTPProperties(
              context,
              uri,
            );
          },
        );
      },
      child: SizedBox(
        height: 50,
        child: SheetDetailCard(
          children: [
            const Icon(
              Symbols.link,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
              size: 18,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizations.nftAddImportUrl,
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
