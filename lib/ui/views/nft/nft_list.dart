// Flutter imports:
import 'dart:convert';

import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:aewallet/ui/views/nft/add_nft_file.dart';
import 'package:aewallet/ui/views/nft/nft_card2.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';

class NFTListWidget extends StatefulWidget {
  final AppWallet? appWallet;
  const NFTListWidget({super.key, this.appWallet});

  @override
  State<NFTListWidget> createState() => _NFTListWidgetState();
}

class _NFTListWidgetState extends State<NFTListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 180,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: widget.appWallet!.appKeychain!
                        .getAccountSelected()!
                        .accountNFT!
                        .length,
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    itemBuilder: (context, index) {
                      TokenInformations tokenInformations = widget
                          .appWallet!.appKeychain!
                          .getAccountSelected()!
                          .accountNFT![index]
                          .tokenInformations!;

                      return NFTCard2(
                        name: tokenInformations.name!,
                        description: tokenInformations.tokenProperties![0]
                            .where((element) => element.name == 'description')
                            .first
                            .value!,
                        imageBase64: tokenInformations.tokenProperties![0]
                            .where((element) => element.name == 'file')
                            .first
                            .value!,
                        heroTag: tokenInformations.name!,
                        onTap: (() {
                          Sheets.showAppHeightEightSheet(
                            context: context,
                            builder: (BuildContext context) {
                              List<TokenProperty> tokenProperties =
                                  List<TokenProperty>.empty(growable: true);
                              for (TokenInformationsProperty tokenInformationsProperty
                                  in tokenInformations.tokenProperties![0]) {
                                TokenProperty tokenProperty = TokenProperty(
                                    name: tokenInformationsProperty.name,
                                    value: tokenInformationsProperty.value);
                                tokenProperties.add(tokenProperty);
                              }

                              return NFTPreviewWidget(
                                  nftName: tokenInformations.name,
                                  nftDescription: tokenInformations
                                      .tokenProperties![0]
                                      .where((element) =>
                                          element.name == 'description')
                                      .first
                                      .value,
                                  nftFile: base64Decode(tokenInformations
                                      .tokenProperties![0]
                                      .where(
                                          (element) => element.name == 'file')
                                      .first
                                      .value!),
                                  nftProperties: tokenProperties,
                                  nftPropertiesDeleteAction: false);
                            },
                          );
                        }),
                      );
                    }),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButton.buildAppButton(
                  const Key('createNFT'),
                  context,
                  AppButtonType.primary,
                  AppLocalization.of(context)!.createNFT,
                  Dimens.buttonBottomDimens, onPressed: () {
                Sheets.showAppHeightNineSheet(
                  context: context,
                  widget: AddNFTFile(
                    process: AddNFTFileProcess.single,
                    primaryCurrency:
                        StateContainer.of(context).curPrimaryCurrency,
                  ),
                );
              }),
            ],
          ),
          /*Row(
            children: <Widget>[
              AppButton.buildAppButtonTiny(
                  const Key('createNFTCollection'),
                  context,
                  AppButtonType.primary,
                  AppLocalization.of(context)!.createNFTCollection,
                  Dimens.buttonBottomDimens, onPressed: () {
                Sheets.showAppHeightNineSheet(
                    context: context,
                    widget: AddNFTCollection(
                      primaryCurrency:
                          StateContainer.of(context).curPrimaryCurrency,
                    ));
              }),
            ],
          ),*/
        ],
      ),
    );
  }
}
