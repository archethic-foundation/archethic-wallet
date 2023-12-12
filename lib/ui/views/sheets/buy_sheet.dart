/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BuySheet extends ConsumerWidget {
  const BuySheet({super.key});

  static const String routerPage = '/buy';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: AppLocalizations.of(context)!.transactionBuyHeader,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Center(
          child: ArchethicScrollbar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://app.uniswap.org/#/swap?outputCurrency=0x8a3d77e9d6968b780564936d15b09805827c21fa&use=V2',
                            'Uniswap',
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/buy/Ethereum.svg',
                              height: 40,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SvgPicture.asset(
                              'assets/buy/Uniswap.svg',
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://pancakeswap.finance/swap?inputCurrency=0xe9e7cea3dedca5984780bafc599bd69add087d56&outputCurrency=0xb001f1E7c8bda414aC7Cf7Ecba5469fE8d24B6de',
                            'PancakeSwap',
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/buy/BSC.svg',
                              height: 40,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              'assets/buy/Pancake.svg',
                              width: 55,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://info.quickswap.exchange/#/pair/0x25bae75f6760ac30554cc62f9282307c3038c3a0',
                            'Quick',
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/buy/Polygon.svg',
                              height: 40,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            SvgPicture.asset(
                              'assets/buy/Quickswap.svg',
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    height: 1,
                    color: ArchethicTheme.backgroundDarkest.withOpacity(0.1),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.probit.com/en-us/',
                            'Probit',
                          );
                        },
                        child: Image.asset(
                          'assets/buy/Probit.png',
                          color: ArchethicTheme.text,
                          height: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
