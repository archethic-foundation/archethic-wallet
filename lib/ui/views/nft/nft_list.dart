// Flutter imports:
import 'dart:typed_data';

import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection.dart';
import 'package:aewallet/ui/views/nft/add_nft_file.dart';
import 'package:aewallet/ui/views/nft/nft_card2.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nft_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTListWidget extends StatefulWidget {
  const NFTListWidget({Key? key, this.images}) : super(key: key);
  final List<Uint8List>? images;

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
          StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .accountNFT!
                  .isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 50, bottom: 30, right: 20),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        color:
                            StateContainer.of(context).curTheme.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              const BorderSide(color: Colors.white10, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/nft-create-new.jpg',
                          ),
                        ),
                      ),
                      Text(
                        AppLocalization.of(context)!.nftTabDescriptionHeader,
                        style: AppStyles.textStyleSize14W600Primary(context),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        color:
                            StateContainer.of(context).curTheme.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              const BorderSide(color: Colors.white10, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'assets/images/nft-create-new.jpg',
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  AppLocalization.of(context)!
                                      .nftTabDescriptionHeader,
                                  style: AppStyles.textStyleSize14W400TextDark(
                                      context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                primary: false,
                shrinkWrap: true,
                itemCount: StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .accountNFT!
                    .length,
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                itemBuilder: (context, index) {
                  TokenInformations tokenInformations =
                      StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .accountNFT![index]
                          .tokenInformations!;

                  return NFTCard2(
                    name: tokenInformations.name!,
                    fileDecrypted:
                        widget.images == null && widget.images!.length == 0
                            ? null
                            : widget.images![index],
                    address: tokenInformations.address!,
                    typeMime: tokenInformations.tokenProperties![0]
                        .where((element) => element.name == 'type/mime')
                        .first
                        .value!,
                    description: '',
                    onTap: (() {
                      List<TokenProperty> tokenProperties =
                          List<TokenProperty>.empty(growable: true);
                      for (TokenInformationsProperty tokenInformationsProperty
                          in tokenInformations.tokenProperties![0]) {
                        TokenProperty tokenProperty = TokenProperty(
                            name: tokenInformationsProperty.name,
                            value: tokenInformationsProperty.value);
                        tokenProperties.add(tokenProperty);
                      }

                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                side: BorderSide(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text45!)),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  NFTPreviewWidget(
                                      nftName: tokenInformations.name,
                                      nftAddress: tokenInformations.address,
                                      context: context,
                                      nftDescription: tokenInformations
                                          .tokenProperties![0]
                                          .where((element) =>
                                              element.name == 'description')
                                          .first
                                          .value,
                                      nftTypeMime: tokenInformations
                                          .tokenProperties![0]
                                          .where((element) =>
                                              element.name == 'type/mime')
                                          .first
                                          .value,
                                      nftProperties: tokenProperties,
                                      nftPropertiesDeleteAction: false),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButtonTiny(
                                          const Key('sendNFT'),
                                          context,
                                          AppButtonType.primary,
                                          AppLocalization.of(context)!.send,
                                          Dimens.buttonTopDimens,
                                          onPressed: () async {
                                        sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            StateContainer.of(context)
                                                .activeVibrations);
                                        Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: TransferSheet(
                                              accountToken:
                                                  StateContainer.of(context)
                                                      .appWallet!
                                                      .appKeychain!
                                                      .getAccountSelected()!
                                                      .accountNFT![index],
                                              primaryCurrency:
                                                  StateContainer.of(context)
                                                      .curPrimaryCurrency,
                                              title:
                                                  AppLocalization.of(context)!
                                                      .transferNFT,
                                              localCurrency:
                                                  StateContainer.of(context)
                                                      .curCurrency),
                                        );
                                      }),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButtonTiny(
                                          const Key('viewExplorer'),
                                          context,
                                          AppButtonType.primary,
                                          AppLocalization.of(context)!
                                              .viewExplorer,
                                          Dimens.buttonTopDimens,
                                          icon: Icon(
                                            Icons.more_horiz,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .text,
                                          ), onPressed: () async {
                                        UIUtil.showWebview(
                                            context,
                                            '${await StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${tokenInformations.address}',
                                            '');
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      /* Sheets.showAppHeightEightSheet(
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
                          );*/
                    }),
                  );
                }),
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
