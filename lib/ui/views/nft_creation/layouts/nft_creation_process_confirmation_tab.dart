/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class NFTCreationProcessConfirmationTab extends ConsumerStatefulWidget {
  const NFTCreationProcessConfirmationTab({
    super.key,
    required this.tabActiveIndex,
  });

  final int tabActiveIndex;

  @override
  ConsumerState<NFTCreationProcessConfirmationTab> createState() =>
      _NFTCreationProcessConfirmationTabState();
}

class _NFTCreationProcessConfirmationTabState
    extends ConsumerState<NFTCreationProcessConfirmationTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationProvider.nftCreation);
    final nftCreationNotifier =
        ref.watch(NftCreationProvider.nftCreation.notifier);
    const feeEstimation = 0.0;
    var addNFTMessage = '';

    Future<bool> validateAddNFT(BuildContext context) async {
      final nftCreation = ref.watch(NftCreationProvider.nftCreation);
      var isValid = true;

      addNFTMessage = '';

      if (nftCreation.file == null && nftCreation.file!.keys.isEmpty) {
        addNFTMessage = localizations.nftAddConfirmationFileEmpty;
        isValid = false;
      } else {
        if (nftCreation.name.isEmpty) {
          addNFTMessage = localizations.nftNameEmpty;
          isValid = false;
        } else {
          if (MimeUtil.isImage(nftCreation.fileTypeMime) == false &&
              MimeUtil.isPdf(nftCreation.fileTypeMime) == false) {
            addNFTMessage = localizations.nftFormatNotSupportedEmpty;
            isValid = false;
          } else {
            if (nftCreation.fileSize! > 2500000) {
              addNFTMessage = localizations.nftSizeExceed;
              isValid = false;
            } else {
              // Estimation of fees
              //feeEstimation = await getFee(context);
              if (feeEstimation >
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .nativeTokenValue!) {
                isValid = false;

                addNFTMessage =
                    AppLocalization.of(context)!.insufficientBalance.replaceAll(
                          '%1',
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel(),
                        );
              }
            }
          }
        }
      }

      return isValid;
    }

    if (nftCreation.file != null) {
      return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              if (feeEstimation > 0)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    '${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                    style: theme.textStyleSize12W100Primary,
                    textAlign: TextAlign.justify,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    AppLocalization.of(context)!.estimatedFeesAddNFTNote,
                    style: theme.textStyleSize12W100Primary,
                    textAlign: TextAlign.justify,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (nftCreation.canCreateNFT == true)
                          AppButton(
                            AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            key: const Key('addNFTFile'),
                            onPressed: () async {},
                          )
                        else
                          AppButton(
                            AppButtonType.primary,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            key: const Key('addNFTFile'),
                            onPressed: () async {
                              if (await validateAddNFT(context) == true) {
                                AppDialogs.showConfirmDialog(
                                  context,
                                  ref,
                                  AppLocalization.of(context)!.createNFT,
                                  AppLocalization.of(context)!
                                      .createNFTConfirmation,
                                  AppLocalization.of(context)!.yes,
                                  () async {
                                    nftCreationNotifier
                                        .changeStateCreateNFTButton(false);

                                    // Authenticate
                                    final preferences =
                                        await Preferences.getInstance();
                                    final authMethod =
                                        preferences.getAuthMethod();
                                    final auth = await AuthFactory.authenticate(
                                      context,
                                      ref,
                                      authMethod: authMethod,
                                      activeVibrations: ref
                                          .watch(SettingsProviders.settings)
                                          .activeVibrations,
                                    );
                                    if (auth) {
                                      EventTaxiImpl.singleton()
                                          .fire(AuthenticatedEvent());
                                    }
                                    nftCreationNotifier
                                        .changeStateCreateNFTButton(true);
                                  },
                                  cancelText: AppLocalization.of(context)!.no,
                                  cancelAction: () {
                                    nftCreationNotifier
                                        .changeStateCreateNFTButton(false);
                                  },
                                );
                              } else {
                                UIUtil.showSnackbar(
                                  addNFTMessage,
                                  context,
                                  ref,
                                  theme.text!,
                                  theme.snackBarShadow!,
                                );
                                nftCreationNotifier
                                    .changeStateCreateNFTButton(false);
                              }
                            },
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
