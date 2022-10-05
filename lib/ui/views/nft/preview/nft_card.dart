/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:typed_data';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({
    super.key,
    required this.onTap,
    required this.tokenInformations,
  });

  final VoidCallback onTap;

  final TokenInformations tokenInformations;

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;
    final typeMime = TokenUtil.getPropertyValue(tokenInformations, 'type/mime');
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tokenInformations.name!,
                  style: AppStyles.textStyleSize12W400Primary(context),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            margin: const EdgeInsets.only(left: 8, right: 8),
            color: theme.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (MimeUtil.isImage(typeMime) == true ||
                    MimeUtil.isPdf(typeMime) == true)
                  FutureBuilder<Uint8List?>(
                    future: TokenUtil.getImageFromTokenAddress(
                      tokenInformations.address!,
                      typeMime,
                    ),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.text,
                              border: Border.all(),
                            ),
                            child: Image.memory(
                              snapshot.data!,
                              height: 130,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
              ],
            ),
          ),
        ),
        NFTCardBottom(tokenInformations: tokenInformations),
      ],
    );
  }
}

class NFTCardBottom extends StatefulWidget {
  const NFTCardBottom({
    super.key,
    required this.tokenInformations,
  });

  final TokenInformations tokenInformations;

  @override
  State<NFTCardBottom> createState() => _NFTCardBottomState();
}

class _NFTCardBottomState extends State<NFTCardBottom> {
  @override
  Widget build(BuildContext context) {
    final nftInfosOffChain = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .getftInfosOffChain(widget.tokenInformations.id);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*InkWell(
                  onTap: (() async {
                    sl.get<HapticUtil>().feedback(FeedbackType.light,
                        StateContainer.of(context).activeVibrations);
                    await StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .updateNftInfosOffChain(
                            tokenAddress: widget.tokenInformations.address,
                            favorite: false);
                  }),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),*/
                InkWell(
                  onTap: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );

                    StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .updateNftInfosOffChainFavorite(
                          widget.tokenInformations.id,
                        );
                    setState(() {});
                  },
                  child: nftInfosOffChain == null ||
                          nftInfosOffChain.favorite == false
                      ? Icon(
                          Icons.favorite_border,
                          color: Colors.yellow[800],
                          size: 18,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.yellow[800],
                          size: 18,
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
