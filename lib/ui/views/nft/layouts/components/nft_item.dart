/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_item_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_item_image.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_item_ipfs.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_item_loading.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTItem extends ConsumerWidget {
  const NFTItem({
    super.key,
    required this.tokenInformations,
    this.roundBorder = false,
  });

  final TokenInformations tokenInformations;
  final bool roundBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return FutureBuilder(
      future: TokenUtil.getTokenByAddress(
        tokenInformations.address!,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return NFTItemError(message: localizations.previewNotAvailable);
        }
        if (snapshot.hasData) {
          if (TokenUtil.isTokenFile(snapshot.data)) {
            final typeMime = tokenInformations.tokenProperties!['type_mime'];
            return NFTItemImage(
              token: snapshot.data,
              roundBorder: roundBorder,
              typeMime: typeMime,
            );
          }
          return NFTItemIPFS(
            token: snapshot.data,
            roundBorder: roundBorder,
          );
        } else {
          return const NFTItemLoading();
        }
      },
    );
  }
}
