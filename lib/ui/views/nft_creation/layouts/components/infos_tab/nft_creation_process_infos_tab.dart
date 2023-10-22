/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTab extends ConsumerWidget {
  const NFTCreationProcessInfosTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return ArchethicScrollbar(
      child: Container(
        padding:
            EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom + 80),
        height: MediaQuery.of(context).size.height + 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                localizations.nftInfosDescription,
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    Symbols.warning,
                    color: theme.warning,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.nftInfosWarning,
                  style: theme.textStyleSize12W100PrimaryWarning,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                localizations.nftInfosWarningDesc,
                style: theme.textStyleSize12W100PrimaryWarning,
                textAlign: TextAlign.justify,
              ),
            ),
            const NFTCreationProcessInfosTabTextFieldName(),
            const SizedBox(
              height: 10,
            ),
            const NFTCreationProcessInfosTabTextFieldSymbol(),
            const SizedBox(
              height: 10,
            ),
            const NFTCreationProcessInfosTabTextFieldDescription(),
          ],
        ),
      ),
    );
  }
}
