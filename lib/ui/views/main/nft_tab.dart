import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:flutter/material.dart';

class NFTTab extends StatelessWidget {
  const NFTTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
            onRefresh: () => Future<void>.sync(() {}),
            child: Column(
              children: <Widget>[
                /// BACKGROUND IMAGE
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(StateContainer.of(context)
                            .curTheme
                            .background1Small!),
                        fit: BoxFit.fitHeight,
                        opacity: 0.7),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: kToolbarHeight + kTextTabBarHeight, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          /// NFT
                          NFTListWidget(
                            appWallet: StateContainer.of(context).appWallet,
                          )
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
