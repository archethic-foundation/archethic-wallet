// Flutter imports:
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
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
          Text('Soon...'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  crossAxisCount: 2,
                  children: List.generate(5, (index) {
                    return Text('');
                  }),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButton.buildAppButtonTiny(
                  const Key('createNFTCollection'),
                  context,
                  AppButtonType.primaryOutline,
                  AppLocalization.of(context)!.createNFTCollection,
                  Dimens.buttonBottomDimens, onPressed: () {
                /* Sheets.showAppHeightNineSheet(
                    context: context,
                    widget: AddNFTCollection(
                      primaryCurrency:
                          StateContainer.of(context).curPrimaryCurrency,
                    ));*/
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsListItem(BuildContext context,
      AccountToken accountCollectionNFT, StateSetter setState) {
    return Text(accountCollectionNFT.tokenInformations!.name!);
  }
}
