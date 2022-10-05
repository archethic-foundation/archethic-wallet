/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class _NFTCreationProcessInfosTab extends StatelessWidget {
  const _NFTCreationProcessInfosTab();

  @override
  Widget build(BuildContext context) {
    // TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
  /*
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    if (tabActiveIndex != 1) {
      return const SizedBox();
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Add to your NFT a name and a human readable description.',
                style: AppStyles.textStyleSize12W100Primary(context),
                textAlign: TextAlign.justify,
              ),
            ),
            AppTextField(
              focusNode: nftNameFocusNode,
              controller: nftNameController,
              cursorColor: StateContainer.of(context).curTheme.text,
              textInputAction: TextInputAction.next,
              labelText: AppLocalization.of(context)!.nftNameHint,
              autocorrect: false,
              keyboardType: TextInputType.text,
              style: AppStyles.textStyleSize16W600Primary(context),
              inputFormatters: <LengthLimitingTextInputFormatter>[
                LengthLimitingTextInputFormatter(30),
              ],
              onChanged: (text) {
                tokenPropertyWithAccessInfosList.removeWhere(
                  (element) => element.tokenProperty!.keys.first == 'name',
                );
                tokenPropertyWithAccessInfosList.add(
                  TokenPropertyWithAccessInfos(
                    tokenProperty: <String, String>{
                      'name': nftNameController!.text
                    },
                  ),
                );
              },
              suffixButton: kIsWeb == false &&
                      (Platform.isIOS || Platform.isAndroid)
                  ? TextFieldButton(
                      icon: FontAwesomeIcons.qrcode,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              StateContainer.of(context).activeVibrations,
                            );
                        UIUtil.cancelLockEvent();
                        final scanResult =
                            await UserDataUtil.getQRData(DataType.raw, context);
                        if (scanResult == null) {
                          UIUtil.showSnackbar(
                            AppLocalization.of(context)!.qrInvalidAddress,
                            context,
                            StateContainer.of(context).curTheme.text!,
                            StateContainer.of(context).curTheme.snackBarShadow!,
                          );
                        } else if (QRScanErrs.errorList.contains(scanResult)) {
                          UIUtil.showSnackbar(
                            scanResult,
                            context,
                            StateContainer.of(context).curTheme.text!,
                            StateContainer.of(context).curTheme.snackBarShadow!,
                          );
                          return;
                        } else {
                          setState(() {
                            nftNameController!.text = scanResult;
                          });
                        }
                      },
                    )
                  : null,
            ),
            AppTextField(
              focusNode: nftDescriptionFocusNode,
              controller: nftDescriptionController,
              cursorColor: StateContainer.of(context).curTheme.text,
              textInputAction: TextInputAction.next,
              labelText: AppLocalization.of(context)!.nftDescriptionHint,
              autocorrect: false,
              keyboardType: TextInputType.text,
              style: AppStyles.textStyleSize16W600Primary(context),
              inputFormatters: <LengthLimitingTextInputFormatter>[
                LengthLimitingTextInputFormatter(40),
              ],
              onChanged: (text) {
                tokenPropertyWithAccessInfosList.removeWhere(
                  (element) =>
                      element.tokenProperty!.keys.first == 'description',
                );
                tokenPropertyWithAccessInfosList.add(
                  TokenPropertyWithAccessInfos(
                    tokenProperty: <String, String>{
                      'description': nftDescriptionController!.text
                    },
                  ),
                );
              },
              suffixButton: kIsWeb == false &&
                      (Platform.isIOS || Platform.isAndroid)
                  ? TextFieldButton(
                      icon: FontAwesomeIcons.qrcode,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              StateContainer.of(context).activeVibrations,
                            );
                        UIUtil.cancelLockEvent();
                        final scanResult =
                            await UserDataUtil.getQRData(DataType.raw, context);
                        if (scanResult == null) {
                          UIUtil.showSnackbar(
                            AppLocalization.of(context)!.qrInvalidAddress,
                            context,
                            StateContainer.of(context).curTheme.text!,
                            StateContainer.of(context).curTheme.snackBarShadow!,
                          );
                        } else if (QRScanErrs.errorList.contains(scanResult)) {
                          UIUtil.showSnackbar(
                            scanResult,
                            context,
                            StateContainer.of(context).curTheme.text!,
                            StateContainer.of(context).curTheme.snackBarShadow!,
                          );
                          return;
                        } else {
                          setState(() {
                            nftDescriptionController!.text = scanResult;
                          });
                        }
                      },
                    )
                  : null,
            ),
          ],
        ),
      );
    }
  }
*/