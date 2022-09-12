import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/add_nft_file.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nft_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTTab extends StatelessWidget {
  const NFTTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(FeedbackType.light,
                  StateContainer.of(context).activeVibrations);
              await StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .updateNFT();

              StateContainer.of(context).imagesNFT =
                  await NFTUtil.getImagesFromTokenAddressList(
                      StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .accountNFT!);
            }),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: Column(
                children: <Widget>[
                  /// BACKGROUND IMAGE
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(StateContainer.of(context)
                              .curTheme
                              .background3Small!),
                          fit: BoxFit.fitHeight,
                          opacity: 0.7),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kToolbarHeight + kTextTabBarHeight,
                            bottom: 50),
                        child: StateContainer.of(context)
                                .appWallet!
                                .appKeychain!
                                .getAccountSelected()!
                                .accountNFT!
                                .isEmpty
                            ? Column(
                                children: <Widget>[
                                  getHeaderListEmpty(context),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButton(
                                          const Key('createNFT'),
                                          context,
                                          AppButtonType.primary,
                                          AppLocalization.of(context)!
                                              .createNFT,
                                          Dimens.buttonBottomDimens,
                                          onPressed: () {
                                        Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: AddNFTFile(
                                            process: AddNFTFileProcess.single,
                                            primaryCurrency:
                                                StateContainer.of(context)
                                                    .curPrimaryCurrency,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  getHeader(context),
                                  NFTListWidget(
                                      images: StateContainer.of(context)
                                          .imagesNFT!),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getHeaderListEmpty(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 150, bottom: 30, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            elevation: 5,
            shadowColor: Colors.black,
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            color: StateContainer.of(context).curTheme.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.white10, width: 1),
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
    );
  }

  Widget getHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            color: StateContainer.of(context).curTheme.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.white10, width: 1),
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
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      AppLocalization.of(context)!.nftTabDescriptionHeader,
                      style: AppStyles.textStyleSize12W400TextDark(context),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
