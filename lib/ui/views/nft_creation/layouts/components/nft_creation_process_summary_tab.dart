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
    final localizations = AppLocalization.of(context)!;
    final accountSelected =
        StateContainer.of(context).appWallet!.appKeychain.getAccountSelected()!;
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    if (nftCreation.file != null) {
      return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FeeInfos(
                  feeEstimation: nftCreation.feeEstimation,
                  tokenPrice: accountSelected.balance!.tokenPrice!.amount ?? 0,
                  currencyName: currency.currency.name,
                  estimatedFeesNote: localizations.estimatedFeesAddNFTNote,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (nftCreation.canCreateNFT)
                          AppButton(
                            AppButtonType.primary,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            key: const Key('addNFTFile'),
                            onPressed: () async {
                              final isNameOk =
                                  nftCreationNotifier.controlName(context);
                              final isFileOk =
                                  nftCreationNotifier.controlFile(context);

                              if (isNameOk && isFileOk) {
                                nftCreationNotifier.setNftCreationProcessStep(
                                  NftCreationProcessStep.confirmation,
                                );
                              }
                            },
                          )
                        else
                          AppButton(
                            AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            key: const Key('addNFTFile'),
                            onPressed: () async {},
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const NFTCreationProcessFilePreview(),
              const NFTCreationProcessFileAccess(
                readOnly: true,
              ),
              const NFTCreationProcessPropertiesList(
                readOnly: true,
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
