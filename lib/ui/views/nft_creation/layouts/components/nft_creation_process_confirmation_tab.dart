/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessConfirmationTab extends ConsumerStatefulWidget {
  const NFTCreationProcessConfirmationTab({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessConfirmationTab> createState() =>
      _NFTCreationProcessConfirmationTabState();
}

class _NFTCreationProcessConfirmationTabState
    extends ConsumerState<NFTCreationProcessConfirmationTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final accountSelected =
        StateContainer.of(context).appWallet!.appKeychain.getAccountSelected()!;
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);

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
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: NFTCreationProcessFileAccess(
                  readOnly: true,
                ),
              ),
              if (nftCreation.properties.isNotEmpty)
                Wrap(
                  children:
                      List.generate(nftCreation.properties.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: NFTCreationProcessPropertyAccess(
                        propertyName:
                            nftCreation.properties[index].propertyName,
                        propertyValue:
                            nftCreation.properties[index].propertyValue,
                        publicKeys: nftCreation.properties[index].publicKeys,
                        propertiesHidden: const [
                          'file',
                          'type/mime',
                          'name',
                          'description'
                        ],
                        readOnly: true,
                      ),
                    );
                  }),
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
