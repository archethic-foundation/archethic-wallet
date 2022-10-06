/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class _NFTCreationProcessPropertiesTab extends StatelessWidget {
  const _NFTCreationProcessPropertiesTab();

  @override
  Widget build(BuildContext context) {
    // TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
/*
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    if (tabActiveIndex != 2) {
      return const SizedBox();
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'You can add additional properties to define, characterize or specify the use of your NFT. Name and value are free.',
                  style: AppStyles.textStyleSize12W100Primary(context),
                  textAlign: TextAlign.justify,
                ),
              ),
              getCategoryTemplateForm(context, widget.currentNftCategoryIndex!),
              AppTextField(
                focusNode: nftPropertyNameFocusNode,
                controller: nftPropertyNameController,
                cursorColor: StateContainer.of(context).curTheme.text,
                textInputAction: TextInputAction.next,
                labelText: AppLocalization.of(context)!.nftPropertyNameHint,
                autocorrect: false,
                keyboardType: TextInputType.text,
                onChanged: (_) {
                  setState(() {});
                },
                style: AppStyles.textStyleSize16W600Primary(context),
                inputFormatters: <LengthLimitingTextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                suffixButton:
                    kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
                        ? TextFieldButton(
                            icon: FontAwesomeIcons.qrcode,
                            onPressed: () async {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    StateContainer.of(context).activeVibrations,
                                  );
                              UIUtil.cancelLockEvent();
                              final scanResult = await UserDataUtil.getQRData(
                                DataType.raw,
                                context,
                              );
                              if (scanResult == null) {
                                UIUtil.showSnackbar(
                                  AppLocalization.of(context)!.qrInvalidAddress,
                                  context,
                                  StateContainer.of(context).curTheme.text!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .snackBarShadow!,
                                );
                              } else if (QRScanErrs.errorList
                                  .contains(scanResult)) {
                                UIUtil.showSnackbar(
                                  scanResult,
                                  context,
                                  StateContainer.of(context).curTheme.text!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .snackBarShadow!,
                                );
                                return;
                              } else {
                                setState(() {
                                  nftPropertyNameController!.text = scanResult;
                                });
                              }
                            },
                          )
                        : null,
              ),
              AppTextField(
                focusNode: nftPropertyValueFocusNode,
                controller: nftPropertyValueController,
                cursorColor: StateContainer.of(context).curTheme.text,
                textInputAction: TextInputAction.next,
                labelText: AppLocalization.of(context)!.nftPropertyValueHint,
                autocorrect: false,
                keyboardType: TextInputType.text,
                onChanged: (_) {
                  setState(() {});
                },
                style: AppStyles.textStyleSize16W600Primary(context),
                inputFormatters: <LengthLimitingTextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                suffixButton:
                    kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
                        ? TextFieldButton(
                            icon: FontAwesomeIcons.qrcode,
                            onPressed: () async {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    StateContainer.of(context).activeVibrations,
                                  );
                              UIUtil.cancelLockEvent();
                              final scanResult = await UserDataUtil.getQRData(
                                DataType.raw,
                                context,
                              );
                              if (scanResult == null) {
                                UIUtil.showSnackbar(
                                  AppLocalization.of(context)!.qrInvalidAddress,
                                  context,
                                  StateContainer.of(context).curTheme.text!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .snackBarShadow!,
                                );
                              } else if (QRScanErrs.errorList
                                  .contains(scanResult)) {
                                UIUtil.showSnackbar(
                                  scanResult,
                                  context,
                                  StateContainer.of(context).curTheme.text!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .snackBarShadow!,
                                );
                                return;
                              } else {
                                setState(() {
                                  nftPropertyValueController!.text = scanResult;
                                });
                              }
                            },
                          )
                        : null,
              ),
              Align(
                child: Text(
                  addNFTPropertyMessage,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleSize12W100Primary(context),
                ),
              ),
              Row(
                children: <Widget>[
                  if (nftPropertyNameController!.text.isNotEmpty &&
                      nftPropertyValueController!.text.isNotEmpty)
                    AppButton.buildAppButtonTiny(
                      const Key('addNFTProperty'),
                      context,
                      AppButtonType.primary,
                      AppLocalization.of(context)!.addNFTProperty,
                      Dimens.buttonBottomDimens,
                      onPressed: () async {
                        if (validateAddNFTProperty() == true) {
                          tokenPropertyWithAccessInfosList.sort(
                            (
                              TokenPropertyWithAccessInfos a,
                              TokenPropertyWithAccessInfos b,
                            ) =>
                                a.tokenProperty!.keys.first
                                    .toLowerCase()
                                    .compareTo(
                                      b.tokenProperty!.keys.first.toLowerCase(),
                                    ),
                          );

                          tokenPropertyWithAccessInfosList.add(
                            TokenPropertyWithAccessInfos(
                              tokenProperty: <String, dynamic>{
                                nftPropertyNameController!.text:
                                    nftPropertyValueController!.text
                              },
                            ),
                          );
                          nftPropertyNameController!.text = '';
                          nftPropertyValueController!.text = '';
                          FocusScope.of(context)
                              .requestFocus(nftPropertyNameFocusNode);
                          setState(() {});
                        }
                      },
                    )
                  else
                    AppButton.buildAppButtonTiny(
                      const Key('addNFTProperty'),
                      context,
                      AppButtonType.primaryOutline,
                      AppLocalization.of(context)!.addNFTProperty,
                      Dimens.buttonBottomDimens,
                      onPressed: () {},
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: AppTextField(
                  controller: nftPropertySearchController,
                  autocorrect: false,
                  labelText: AppLocalization.of(context)!.searchField,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  onChanged: (_) async {
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
    }
  }*/
  