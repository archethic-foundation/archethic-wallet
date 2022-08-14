/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';

class BuySheet extends StatefulWidget {
  const BuySheet({super.key});

  @override
  State<BuySheet> createState() => _BuySheetState();
}

class _BuySheetState extends State<BuySheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // A row for the address text and close button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Empty SizedBox
            const SizedBox(
              width: 60,
              height: 40,
            ),
            Column(
              children: <Widget>[
                // Sheet handle
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.text60,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),

            const SizedBox(
              width: 60,
              height: 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.transactionBuyHeader,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      top: 50,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context,
                                  'https://rubic.exchange/?fromChain=ETH&toChain=ETH&from=ETH&to=UCO',
                                  'Rubic');
                            },
                            child: SvgPicture.asset(
                              'assets/buy/Rubic.svg',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context,
                                  'https://info.quickswap.exchange/#/pair/0x25bae75f6760ac30554cc62f9282307c3038c3a0',
                                  'Quick');
                            },
                            child: Image.asset(
                              'assets/buy/Quickswap.png',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(context,
                                  'https://www.probit.com/en-us/', 'Probit');
                            },
                            child: Image.asset(
                              'assets/buy/Probit.png',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(context,
                                  'https://www.bitglobal.com/en-us', 'Bithumb');
                            },
                            child: Image.asset(
                              'assets/buy/Bithumb.png',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context,
                                  'https://app.uniswap.org/#/swap?outputCurrency=0x8a3d77e9d6968b780564936d15b09805827c21fa&use=V2',
                                  'Bithumb');
                            },
                            child: SvgPicture.asset(
                              'assets/buy/Uniswap.svg',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context, 'https://zebitex.com', 'Zebitex');
                            },
                            child: SvgPicture.asset(
                              'assets/buy/Zebitex.svg',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context,
                                  'https://pancakeswap.finance/swap?inputCurrency=0xe9e7cea3dedca5984780bafc599bd69add087d56&outputCurrency=0xb001f1E7c8bda414aC7Cf7Ecba5469fE8d24B6de',
                                  'PancakeSwap');
                            },
                            child: Image.asset(
                              'assets/buy/Pancake.png',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(context,
                                  'https://dapps.zam.io/bridge', 'Zamio');
                            },
                            child: Image.asset(
                              'assets/buy/Zamio.png',
                              color: StateContainer.of(context).curTheme.text,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
