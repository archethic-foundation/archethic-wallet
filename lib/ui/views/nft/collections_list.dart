// Flutter imports:
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection.dart';
import 'package:aewallet/ui/views/nft/add_nft_file.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .accountNFT !=
              null)
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
                      itemCount: StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .accountNFT!
                          .length,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context, index) {
                        TokenInformations tokenInformations =
                            StateContainer.of(context)
                                .appWallet!
                                .appKeychain!
                                .getAccountSelected()!
                                .accountNFT![index]
                                .tokenInformations!;
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundAccountsListCardSelected!,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundAccountsListCardSelected,
                          child: Align(
                            alignment: Alignment.center,
                            child: tokenInformations.supply == 100000000
                                ? AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.memory(
                                      tokenInformations.getImage()!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(
                                    tokenInformations.name!,
                                    style: AppStyles.textStyleSize16W600Primary(
                                        context),
                                  ),
                          ),
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
                    widget:
                        const AddNFTFile(process: AddNFTFileProcess.single));
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
