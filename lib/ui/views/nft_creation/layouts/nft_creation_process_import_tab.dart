/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class NFTCreationProcessImportTab extends ConsumerStatefulWidget {
  const NFTCreationProcessImportTab({
    super.key,
    required this.tabActiveIndex,
    required this.currentNftCategoryIndex,
  });

  final int tabActiveIndex;
  final int currentNftCategoryIndex;

  @override
  ConsumerState<NFTCreationProcessImportTab> createState() =>
      _NFTCreationProcessImportTabState();
}

class _NFTCreationProcessImportTabState
    extends ConsumerState<NFTCreationProcessImportTab> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationProvider.nftCreation);

    return SingleChildScrollView(
      physics: nftCreation.file == null
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height + 250,
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  ref.read(
                    NftCategoryProviders.getDescriptionHeader(
                      context: context,
                      id: widget.currentNftCategoryIndex,
                    ),
                  ),
                  style: theme.textStyleSize12W100Primary,
                  textAlign: TextAlign.justify,
                ),
              ),
              const NFTCreationProcessImportTabFile(),
              const NFTCreationProcessImportTabImage(),
              const NFTCreationProcessImportTabCamera(),
              const NFTCreationProcessFileAccess(),
              const NFTCreationProcessFilePreview()
            ],
          ),
        ),
      ),
    );
  }
}
