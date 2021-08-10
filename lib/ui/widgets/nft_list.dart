// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show NftBalance;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_nft_sheet.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';

class NftListWidget {
  static Widget buildNftList(BuildContext context) {
    return StateContainer.of(context).wallet.transactionChainLoading == true
        ? const Center(child: CircularProgressIndicator())
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
            Text(AppLocalization.of(context)!.nftHeader,
                style: AppStyles.textStyleSize14W600BackgroundDarkest(context)),
            Stack(
              children: <Widget>[
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.only(
                          top: 23.5, left: 3.5, right: 3.5, bottom: 3.5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 6, bottom: 6),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: StateContainer.of(context)
                              .wallet
                              .accountBalance
                              .nft!
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return displayNftDetail(
                                context,
                                StateContainer.of(context)
                                    .wallet
                                    .accountBalance
                                    .nft![index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]);
  }

  static Column displayNftDetail(BuildContext context, NftBalance nftBalance) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Sheets.showAppHeightNineSheet(
                        context: context,
                        widget: TransferNftSheet(
                          contactsRef: StateContainer.of(context).contactsRef,
                          title: AppLocalization.of(context)!
                              .transferNFTName
                              .replaceAll('%1', nftBalance.address!),
                          actionButtonTitle:
                              AppLocalization.of(context)!.transferNFT,
                          address: nftBalance.address,
                        ));
                  },
                  child: FaIcon(FontAwesomeIcons.arrowCircleUp,
                      color: StateContainer.of(context).curTheme.primary),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(Address(nftBalance.address!).getShortString3(),
                        style: AppStyles.textStyleSize14W100Primary(context)),
                  ],
                ),
              ],
            ),
            Text(nftBalance.amount!.toString(),
                style: AppStyles.textStyleSize14W100Primary(context)),
          ],
        ),
        const SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        const SizedBox(height: 6),
      ],
    );
  }
}
