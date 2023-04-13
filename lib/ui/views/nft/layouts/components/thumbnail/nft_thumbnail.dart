/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_aeweb.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_http.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_image.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_ipfs.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_loading.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnail extends ConsumerWidget {
  const NFTThumbnail({
    super.key,
    required this.tokenInformations,
    this.roundBorder = false,
    this.withContentInfo = false,
  });

  final TokenInformations tokenInformations;
  final bool roundBorder;
  final bool withContentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: TokenUtil.getTokenByAddress(
        tokenInformations.address!,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return NFTThumbnailError(message: localizations.previewNotAvailable);
        }
        if (snapshot.hasData) {
          if (TokenUtil.isTokenFile(snapshot.data)) {
            final typeMime = tokenInformations.tokenProperties!['type_mime'];
            return NFTThumbnailImage(
              token: snapshot.data,
              roundBorder: roundBorder,
              typeMime: typeMime,
            );
          } else if (TokenUtil.isTokenIPFS(snapshot.data)) {
            return NFTThumbnailIPFS(
              token: snapshot.data,
              roundBorder: roundBorder,
              withContentInfo: withContentInfo,
            );
          } else if (TokenUtil.isTokenHTTP(snapshot.data)) {
            return NFTThumbnailHTTP(
              token: snapshot.data,
              roundBorder: roundBorder,
              withContentInfo: withContentInfo,
            );
          } else if (TokenUtil.isTokenAEWEB(snapshot.data)) {
            return NFTThumbnailAEWEB(
              token: snapshot.data,
              roundBorder: roundBorder,
              withContentInfo: withContentInfo,
            );
          }
          return const SizedBox();
        } else {
          return const NFTThumbnailLoading();
        }
      },
    );
  }
}
