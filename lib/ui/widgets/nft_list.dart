import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/transfer/transfer_nft_sheet.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';

class NftListWidget {
  static Widget buildNftList(BuildContext context) {
    return Stack(
      children: [
        StateContainer.of(context).wallet == null ||
                StateContainer.of(context).wallet.accountBalance == null ||
                StateContainer.of(context).wallet.accountBalance.nftList == null
            ? SizedBox()
            : SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    height: StateContainer.of(context)
                            .wallet
                            .accountBalance
                            .nftList!
                            .length *
                        60,
                    padding: EdgeInsets.only(
                        top: 23.5, left: 3.5, right: 3.5, bottom: 3.5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.background,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDark,
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 6, right: 6, top: 6, bottom: 6),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemCount: StateContainer.of(context)
                            .wallet
                            .accountBalance
                            .nftList!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return displayNftDetail(
                              context,
                              StateContainer.of(context)
                                  .wallet
                                  .accountBalance
                                  .nftList![index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              padding: EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.backgroundDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(5.0, 5.0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NFT", style: AppStyles.textStyleAddressText60(context)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {
                  Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: TransferNftSheet(
                        contactsRef: StateContainer.of(context).contactsRef,
                        title: AppLocalization.of(context).transferNFT,
                        actionButtonTitle:
                            AppLocalization.of(context).transferNFT,
                      ));
                },
                child: Icon(FontAwesome5.arrow_circle_up,
                    color: StateContainer.of(context).curTheme.primary),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 40),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {},
                child: Icon(FontAwesome5.plus_circle,
                    color: StateContainer.of(context).curTheme.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static displayNftDetail(BuildContext context, BalanceNft balanceNft) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Sheets.showAppHeightNineSheet(
                        context: context,
                        widget: TransferNftSheet(
                          contactsRef: StateContainer.of(context).contactsRef,
                          title: AppLocalization.of(context)
                              .transferNFTName
                              .replaceAll("%1", balanceNft.name!),
                          actionButtonTitle:
                              AppLocalization.of(context).transferNFT,
                          address: balanceNft.address,
                        ));
                  },
                  child: Icon(FontAwesome5.arrow_circle_up,
                      color: StateContainer.of(context).curTheme.primary),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(balanceNft.name!,
                        style: AppStyles.textStyleAddressText90(context)),
                    Text(Address(balanceNft.address!).getShortString3(),
                        style: AppStyles.textStyleTiny(context))
                  ],
                ),
              ],
            ),
            Text(balanceNft.amount!.toString(),
                style: AppStyles.textStyleAddressText90(context)),
          ],
        ),
        SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        SizedBox(height: 6),
      ],
    );
  }
}
