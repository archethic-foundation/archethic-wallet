/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/nft_category_menu.dart';
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
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: false,
                          stretch: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          expandedHeight: 260.0,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                            ],
                            background: Stack(
                              children: [
                                DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: <Color>[
                                        StateContainer.of(context)
                                            .curTheme
                                            .background!,
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/nft-create-new.jpg',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 250, left: 20, right: 20),
                                  child: Text(
                                    AppLocalization.of(context)!
                                        .nftTabDescriptionHeader,
                                    style: AppStyles.textStyleSize12W600Primary(
                                        context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const NftCategoryMenu(),
                      ],
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
