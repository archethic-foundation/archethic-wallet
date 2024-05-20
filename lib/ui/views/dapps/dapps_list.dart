import 'package:aewallet/model/dapps_info.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/dapps/components/card_dapps.dart';
import 'package:aewallet/ui/views/main/nft_tab.dart';
import 'package:aewallet/ui/views/sheets/dex_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DAppsList extends ConsumerStatefulWidget {
  const DAppsList({super.key});

  @override
  ConsumerState<DAppsList> createState() => DAppsListState();
}

class DAppsListState extends ConsumerState<DAppsList> {
  final List<DAppsInfo> dAppsInfoList = <DAppsInfo>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Hard coded pending a more global system...
      if (DEXSheet.isAvailable) {
        dAppsInfoList.add(
          DAppsInfo(
            dAppName: 'aeSwap',
            dAppDesc: AppLocalizations.of(context)!.dappsAESwapDesc,
            dAppLink: DEXSheet.routerPage,
            dAppBackgroundImgCard: ArchethicTheme.backgroundAESwap,
          ),
        );
      }

      dAppsInfoList.add(
        DAppsInfo(
          dAppName: 'NFT',
          dAppDesc: AppLocalizations.of(context)!.dappsNFTDesc,
          dAppLink: NFTTab.routerPage,
        ),
      );
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dAppsInfoList.length,
          itemBuilder: (BuildContext context, int index) {
            return CardDapps(
              dAppsInfo: dAppsInfoList[index],
            )
                .animate()
                .fade(duration: Duration(milliseconds: 300 + (index * 50)))
                .scale(duration: Duration(milliseconds: 300 + (index * 50)));
          },
        ),
      ],
    );
  }
}
