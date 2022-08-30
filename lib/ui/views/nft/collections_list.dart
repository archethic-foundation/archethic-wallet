// Flutter imports:
import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection.dart';
import 'package:aewallet/ui/views/nft/add_nft_file.dart';
import 'package:aewallet/ui/views/nft/nft_card.dart';
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

class CollectionsListWidget extends StatefulWidget {
  final AppWallet? appWallet;
  const CollectionsListWidget({super.key, this.appWallet});

  @override
  State<CollectionsListWidget> createState() => _CollectionsListWidgetState();
}

class _CollectionsListWidgetState extends State<CollectionsListWidget> {
  List<AccountToken> nftList = List<AccountToken>.empty(growable: true);

  @override
  void initState() {
    nftList = widget.appWallet!.appKeychain!.getAccountSelected()!.accountNFT!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: nftList.length,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      TokenInformations tokenInformations =
                          nftList[index].tokenInformations!;

                      Uint8List file = base64Decode(tokenInformations
                          .tokenProperties![0]
                          .where((element) => element.name == 'file')
                          .first
                          .value!);

                      return NFTCard(
                        name: tokenInformations.name!,
                        description: tokenInformations.tokenProperties![0]
                            .where((element) => element.name == 'description')
                            .first
                            .value!,
                        image: file,
                        heroTag: tokenInformations.name!,
                        onTap: (() {
                          Sheets.showAppHeightNineSheet(
                            context: context,
                            widget: NFTPreviewWidget(
                                nftName: tokenInformations.name,
                                nftDescription: tokenInformations
                                    .tokenProperties![0]
                                    .where((element) =>
                                        element.name == 'description')
                                    .first
                                    .value,
                                nftFile: file,
                                nftProperties:
                                    List<TokenProperty>.empty(growable: true)),
                          );
                        }),
                      );
                    }),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButton.buildAppButtonTiny(
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
                    ));
              }),
            ],
          ),
          Row(
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
          ),
        ],
      ),
    );
  }
}
