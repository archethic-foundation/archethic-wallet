/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class _NFTCreationProcessConfirmationTab extends StatefulWidget {
  const _NFTCreationProcessConfirmationTab({
    required this.tabActiveIndex,
  });

  final int tabActiveIndex;

  @override
  State<_NFTCreationProcessConfirmationTab> createState() =>
      _NFTCreationProcessConfirmationTabState();
}

class _NFTCreationProcessConfirmationTabState
    extends State<_NFTCreationProcessConfirmationTab> {
  @override
  Widget build(BuildContext context) {
    // TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
/*
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);

    if (file != null && widget.tabActiveIndex == 3) {
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
                        if (isPressed == true)
                          AppButton.buildAppButton(
                            const Key('addNFTFile'),
                            context,
                            AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            onPressed: () async {},
                          )
                        else
                          AppButton.buildAppButton(
                            const Key('addNFTFile'),
                            context,
                            AppButtonType.primary,
                            AppLocalization.of(context)!.createNFT,
                            Dimens.buttonTopDimens,
                            onPressed: () async {
                              setState(() {
                                isPressed = true;
                              });

                              updateToken();
                              if (await validateAddNFT(context) == true) {
                                AppDialogs.showConfirmDialog(
                                  context,
                                  AppLocalization.of(context)!.createNFT,
                                  AppLocalization.of(context)!
                                      .createNFTConfirmation,
                                  AppLocalization.of(context)!.yes,
                                  () async {
                                    setState(() {
                                      isPressed = false;
                                    });
                                    // Authenticate
                                    final preferences =
                                        await Preferences.getInstance();
                                    final authMethod =
                                        preferences.getAuthMethod();
                                    final auth = await AuthFactory.authenticate(
                                      context,
                                      authMethod,
                                      activeVibrations:
                                          StateContainer.of(context)
                                              .activeVibrations,
                                    );
                                    if (auth) {
                                      EventTaxiImpl.singleton()
                                          .fire(AuthenticatedEvent());
                                    }
                                  },
                                  cancelText: AppLocalization.of(context)!.no,
                                  cancelAction: () {
                                    setState(() {
                                      isPressed = false;
                                    });
                                  },
                                );
                              } else {
                                UIUtil.showSnackbar(
                                  addNFTMessage,
                                  context,
                                  theme.text!,
                                  theme
                                      .snackBarShadow!,
                                );

                                setState(() {
                                  isPressed = false;
                                });
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
                  child: GestureDetector(
                    onTap: () async {},
                    onLongPress: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: tokenPropertyAsset!.publicKeysList != null &&
                                tokenPropertyAsset!.publicKeysList!.isNotEmpty
                            ? const BorderSide(
                                color: Colors.redAccent,
                                width: 2,
                              )
                            : BorderSide(
                                color: theme
                                    .backgroundAccountsListCardSelected!,
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      color: theme
                          .backgroundAccountsListCardSelected,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (tokenPropertyAsset!
                                                    .publicKeysList !=
                                                null &&
                                            tokenPropertyAsset!
                                                .publicKeysList!.isNotEmpty)
                                          tokenPropertyAsset!
                                                      .publicKeysList!.length ==
                                                  1
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: AutoSizeText(
                                                    'This asset is protected and accessible by ${tokenPropertyAsset!.publicKeysList!.length} public key',
                                                    style: AppStyles
                                                        .textStyleSize12W400Primary(
                                                      context,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: AutoSizeText(
                                                    'This asset is protected and accessible by ${tokenPropertyAsset!.publicKeysList!.length} public keys',
                                                    style: AppStyles
                                                        .textStyleSize12W400Primary(
                                                      context,
                                                    ),
                                                  ),
                                                )
                                        else
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                            ),
                                            child: AutoSizeText(
                                              'This asset is accessible by everyone',
                                              style: AppStyles
                                                  .textStyleSize12W400Primary(
                                                context,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (token.name != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    token.name!,
                    style: theme.textStyleSize14W600Primary,
                  ),
                ),
              if (nftDescriptionController!.text != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    nftDescriptionController!.text,
                    style: theme.textStyleSize12W400Primary,
                  ),
                ),
              if (file != null &&
                  (MimeUtil.isImage(typeMime) == true ||
                      MimeUtil.isPdf(typeMime) == true))
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.text,
                      border: Border.all(),
                    ),
                    child: Image.memory(
                      fileDecodedForPreview!,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    child: Text(
                      'Format: $typeMime',
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ),
                ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    child: Text(
                      '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(sizeFile)}',
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Wrap(
                  children:
                      tokenPropertyWithAccessInfosList.asMap().entries.map((
                    MapEntry<dynamic, TokenPropertyWithAccessInfos> entry,
                  ) {
                    return entry.value.tokenProperty!.keys.first != 'file' &&
                            entry.value.tokenProperty!.keys.first !=
                                'description' &&
                            entry.value.tokenProperty!.keys.first != 'name' &&
                            entry.value.tokenProperty!.keys.first !=
                                'type/mime' &&
                            (nftPropertySearchController!.text.isNotEmpty &&
                                    entry.value.tokenProperty!.keys.first
                                        .toLowerCase()
                                        .contains(
                                          nftPropertySearchController!.text
                                              .toLowerCase(),
                                        ) ||
                                nftPropertySearchController!.text.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: _buildTokenProperty(
                              context,
                              entry.value,
                              readOnly: true,
                            ),
                          )
                        : const SizedBox();
                  }).toList(),
                ),
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
*/
