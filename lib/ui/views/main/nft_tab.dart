import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nft_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTTab extends StatefulWidget {
  const NFTTab({Key? key}) : super(key: key);

  @override
  State<NFTTab> createState() => NFTTabState();
}

class NFTTabState extends State<NFTTab> {
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

              setState(() {});
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /// NFT
                            NFTListWidget(
                                images: StateContainer.of(context).imagesNFT!)
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
}
