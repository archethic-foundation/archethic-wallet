/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessImportTab extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTab({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessImportTab> createState() =>
      _NFTCreationProcessImportTabState();
}

class _NFTCreationProcessImportTabState
    extends ConsumerState<NFTCreationProcessImportTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return ArchethicScrollbar(
      child: Container(
        padding:
            EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom + 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Symbols.warning,
                      color: ArchethicTheme.warning,
                      size: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localizations.nftInfosImportWarning,
                      style: ArchethicThemeStyles
                          .textStyleSize12W100PrimaryWarning,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            const NFTCreationProcessFilePreview(
              displayNFTInfo: false,
            ),
            Text(
              localizations.nftChooseSource,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
            const Column(
              children: [
                NFTCreationProcessImportTabFile(),
                NFTCreationProcessImportTabImage(),
                NFTCreationProcessImportTabCamera(),
                NFTCreationProcessImportTabIPFS(),
                NFTCreationProcessImportTabHTTP(),
                NFTCreationProcessImportTabAEWeb(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
