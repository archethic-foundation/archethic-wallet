/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTab extends ConsumerWidget {
  const NFTCreationProcessInfosTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: MediaQuery.of(context).size.height,
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
          const NFTCreationProcessInfosTabTextFieldName(),
          const SizedBox(
            height: 30,
          ),
          const NFTCreationProcessInfosTabTextFieldDescription(),
        ],
      ),
    );
  }
}
