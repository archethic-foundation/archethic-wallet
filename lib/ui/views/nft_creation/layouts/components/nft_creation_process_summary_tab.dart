/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessSummaryTab extends ConsumerStatefulWidget {
  const NFTCreationProcessSummaryTab({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessSummaryTab> createState() =>
      _NFTCreationProcessSummaryTabState();
}

class _NFTCreationProcessSummaryTabState
    extends ConsumerState<NFTCreationProcessSummaryTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    if (accountSelected == null) return const SizedBox();

    if (nftCreation.file != null || nftCreation.fileURL != null) {
      return ArchethicScrollbar(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom / 2),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: FeeInfos(
                    asyncFeeEstimation: nftCreation.feeEstimation,
                    estimatedFeesNote: localizations.estimatedFeesAddNFTNote,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AppButtonTinyConnectivity(
                            AppLocalizations.of(context)!.createTheNFT,
                            Dimens.buttonTopDimens,
                            key: const Key('createTheNFT'),
                            icon: Symbols.diamond,
                            onPressed: () async {
                              final isFileOk =
                                  nftCreationNotifier.controlFile(context);
                              final isUrlOk =
                                  nftCreationNotifier.controlURL(context);

                              if (isFileOk || isUrlOk) {
                                nftCreationNotifier.setNftCreationProcessStep(
                                  NftCreationProcessStep.confirmation,
                                );
                              }
                            },
                            disabled: !nftCreation.canCreateNFT,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const NFTCreationProcessFilePreview(),
                const NFTCreationProcessPropertiesList(
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
