// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';

class BuySheet extends StatefulWidget {
  const BuySheet({Key? key}) : super(key: key);

  @override
  _BuySheetState createState() => _BuySheetState();
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
                    color: StateContainer.of(context).curTheme.primary60,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),
            if (kIsWeb || Platform.isMacOS || Platform.isWindows)
              Stack(
                children: <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10, right: 0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: <Widget>[
                              buildIconDataWidget(
                                  context, Icons.close_outlined, 30, 30),
                            ],
                          ))),
                ],
              )
            else
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
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.transactionBuyHeader,
                style: AppStyles.textStyleSize24W700Primary(context),
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
                              color: Colors.white,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              UIUtil.showWebview(
                                  context,
                                  'https://rubic.exchange/?fromChain=ETH&toChain=ETH&from=ETH&to=UCO',
                                  'Quick');
                            },
                            child: Image.asset(
                              'assets/buy/Quickswap.png',
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
