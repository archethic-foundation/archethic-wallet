/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BuySheet extends ConsumerWidget {
  const BuySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: <Widget>[
        SheetHeader(title: AppLocalization.of(context)!.transactionBuyHeader),
        Expanded(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: 50,
                ),
                child: ArchethicScrollbar(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://rubic.exchange/?fromChain=ETH&toChain=ETH&from=ETH&to=UCO',
                            'Rubic',
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/buy/Rubic.svg',
                          colorFilter:
                              ColorFilter.mode(theme.text!, BlendMode.srcIn),
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://info.quickswap.exchange/#/pair/0x25bae75f6760ac30554cc62f9282307c3038c3a0',
                            'Quick',
                          );
                        },
                        child: Image.asset(
                          'assets/buy/Quickswap.png',
                          color: theme.text,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
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
                          color: theme.text,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.bitglobal.com/en-us',
                            'Bithumb',
                          );
                        },
                        child: Image.asset(
                          'assets/buy/Bithumb.png',
                          color: theme.text,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://app.uniswap.org/#/swap?outputCurrency=0x8a3d77e9d6968b780564936d15b09805827c21fa&use=V2',
                            'Bithumb',
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/buy/Uniswap.svg',
                          colorFilter:
                              ColorFilter.mode(theme.text!, BlendMode.srcIn),
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://zebitex.com',
                            'Zebitex',
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/buy/Zebitex.svg',
                          colorFilter:
                              ColorFilter.mode(theme.text!, BlendMode.srcIn),
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://pancakeswap.finance/swap?inputCurrency=0xe9e7cea3dedca5984780bafc599bd69add087d56&outputCurrency=0xb001f1E7c8bda414aC7Cf7Ecba5469fE8d24B6de',
                            'PancakeSwap',
                          );
                        },
                        child: Image.asset(
                          'assets/buy/Pancake.png',
                          color: theme.text,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          UIUtil.showWebview(
                            context,
                            'https://dapps.zam.io/bridge',
                            'Zamio',
                          );
                        },
                        child: Image.asset(
                          'assets/buy/Zamio.png',
                          color: theme.text,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
