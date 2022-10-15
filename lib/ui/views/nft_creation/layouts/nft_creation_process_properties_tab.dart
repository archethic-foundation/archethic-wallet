/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class NFTCreationProcessPropertiesTab extends ConsumerWidget {
  const NFTCreationProcessPropertiesTab(
    this.currentNftCategoryIndex, {
    super.key,
  });

  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(preferenceProvider);

    final nftPropertyNameFocusNode = FocusNode();
    final nftPropertyValueFocusNode = FocusNode();
    final nftPropertySearchController = TextEditingController();
    final nftPropertyNameController = TextEditingController();
    final nftPropertyValueController = TextEditingController();
    var addNFTPropertyMessage = '';

    final nftCreation = ref.watch(NftCreationProvider.nftCreation);
    final nftCreationNotifier =
        ref.watch(NftCreationProvider.nftCreation.notifier);

    bool validateAddNFTProperty() {
      addNFTPropertyMessage = '';

      if (nftPropertyNameController.text.isEmpty) {
        addNFTPropertyMessage = localizations.nftPropertyNameEmpty;
        return false;
      }

      if (nftPropertyValueController.text.isEmpty) {
        addNFTPropertyMessage = localizations.nftPropertyValueEmpty;
        return false;
      }

      // TODO(reddwarf03): Add control
      /* if (nftCreation.properties.where(element) =>
          element.propertyName!.compareTo(nftPropertyNameController.text)) {
        addNFTPropertyMessage = localizations.nftPropertyExists;
        return false;
      }*/

      return true;
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                localizations.nftPropertyExplanation,
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
            CategoryTemplateForm(
              currentNftCategoryIndex: currentNftCategoryIndex,
            ),
            AppTextField(
              focusNode: nftPropertyNameFocusNode,
              controller: nftPropertyNameController,
              cursorColor: theme.text,
              textInputAction: TextInputAction.next,
              labelText: AppLocalization.of(context)!.nftPropertyNameHint,
              autocorrect: false,
              keyboardType: TextInputType.text,
              style: theme.textStyleSize16W600Primary,
              inputFormatters: <LengthLimitingTextInputFormatter>[
                LengthLimitingTextInputFormatter(20),
              ],
              onChanged: (text) {
                /* nftCreationNotifier.canAddProperty(
                  text,
                  nftPropertyValueController.text,
                );*/
              },
              suffixButton: kIsWeb == false &&
                      (Platform.isIOS || Platform.isAndroid)
                  ? TextFieldButton(
                      icon: FontAwesomeIcons.qrcode,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        UIUtil.cancelLockEvent();
                        final scanResult = await UserDataUtil.getQRData(
                          DataType.raw,
                          context,
                          ref,
                        );
                        if (scanResult == null) {
                          UIUtil.showSnackbar(
                            AppLocalization.of(context)!.qrInvalidAddress,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                        } else if (QRScanErrs.errorList.contains(scanResult)) {
                          UIUtil.showSnackbar(
                            scanResult,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                          return;
                        } else {
                          nftPropertyNameController.text = scanResult;
                        }
                      },
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            AppTextField(
              focusNode: nftPropertyValueFocusNode,
              controller: nftPropertyValueController,
              cursorColor: theme.text,
              textInputAction: TextInputAction.next,
              labelText: AppLocalization.of(context)!.nftPropertyValueHint,
              autocorrect: false,
              keyboardType: TextInputType.text,
              style: theme.textStyleSize16W600Primary,
              inputFormatters: <LengthLimitingTextInputFormatter>[
                LengthLimitingTextInputFormatter(20),
              ],
              onChanged: (text) {
                /*    nftCreationNotifier.canAddProperty(
                  nftPropertyNameController.text,
                  text,
                );*/
              },
              suffixButton: kIsWeb == false &&
                      (Platform.isIOS || Platform.isAndroid)
                  ? TextFieldButton(
                      icon: FontAwesomeIcons.qrcode,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        UIUtil.cancelLockEvent();
                        final scanResult = await UserDataUtil.getQRData(
                          DataType.raw,
                          context,
                          ref,
                        );
                        if (scanResult == null) {
                          UIUtil.showSnackbar(
                            AppLocalization.of(context)!.qrInvalidAddress,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                        } else if (QRScanErrs.errorList.contains(scanResult)) {
                          UIUtil.showSnackbar(
                            scanResult,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                          return;
                        } else {
                          nftPropertyValueController.text = scanResult;
                        }
                      },
                    )
                  : null,
            ),
            Align(
              child: Text(
                addNFTPropertyMessage,
                textAlign: TextAlign.center,
                style: theme.textStyleSize12W100Primary,
              ),
            ),
            Row(
              children: <Widget>[
                //   if (nftCreation.canAddProperty)
                AppButton.buildAppButtonTiny(
                  const Key('addNFTProperty'),
                  context,
                  ref,
                  AppButtonType.primary,
                  AppLocalization.of(context)!.addNFTProperty,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    if (validateAddNFTProperty() == true) {
                      nftCreationNotifier.setProperty(
                        nftPropertyNameController.text,
                        nftPropertyValueController.text,
                      );
                      nftPropertyNameController.text = '';
                      nftPropertyValueController.text = '';
                    }
                  },
                )
                /*  else
                  AppButton.buildAppButtonTiny(
                    const Key('addNFTProperty'),
                    context,
                    ref,
                    AppButtonType.primaryOutline,
                    AppLocalization.of(context)!.addNFTProperty,
                    Dimens.buttonBottomDimens,
                    onPressed: () {},
                  ),*/
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AppTextField(
                controller: nftPropertySearchController,
                autocorrect: false,
                labelText: AppLocalization.of(context)!.searchField,
                keyboardType: TextInputType.text,
                style: theme.textStyleSize16W600Primary,
              ),
            ),
            if (nftCreation.properties.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(
                  children:
                      List.generate(nftCreation.properties.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
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
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
