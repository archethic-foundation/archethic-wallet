/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/refresh_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/nft_category_menu.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class NFTTab extends StatefulWidget {
  const NFTTab({super.key});

  @override
  State<NFTTab> createState() => _NFTTabState();
}

class _NFTTabState extends State<NFTTab> {
  StreamSubscription<RefreshEvent>? _refreshSub;

  @override
  void initState() {
    _registerBus();
    super.initState();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _registerBus() {
    _refreshSub = EventTaxiImpl.singleton()
        .registerTo<RefreshEvent>()
        .listen((RefreshEvent event) {
      setState(() {});
    });
  }

  void _destroyBus() {
    _refreshSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    StateContainer.of(context).activeVibrations,
                  );
              await StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .updateNFT();
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
                        image: AssetImage(
                          StateContainer.of(context).curTheme.background3Small!,
                        ),
                        fit: BoxFit.fitHeight,
                        opacity: 0.7,
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          stretch: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          expandedHeight: 260,
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
                                    top: 250,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    AppLocalization.of(context)!
                                        .nftTabDescriptionHeader,
                                    style: AppStyles.textStyleSize12W600Primary(
                                      context,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        NftCategoryMenu(
                          nftCategories: StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .getListNftCategory(context),
                        ),
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
