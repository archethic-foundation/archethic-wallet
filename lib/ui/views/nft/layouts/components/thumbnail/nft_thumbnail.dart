import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_aeweb.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_http.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_image.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_ipfs.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnail extends ConsumerWidget {
  const NFTThumbnail({
    super.key,
    required this.address,
    required this.properties,
    this.nameInCollection,
    this.roundBorder = false,
    this.withContentInfo = false,
  });

  final String address;
  final String? nameInCollection;
  final Map<String, dynamic> properties;
  final bool roundBorder;
  final bool withContentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (nameInCollection != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              nameInCollection!,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ),
        if (TokenUtil.isTokenFile(properties))
          NFTThumbnailImage(
            key: UniqueKey(),
            address: address,
            properties: properties,
            roundBorder: roundBorder,
          )
        else if (TokenUtil.isTokenIPFS(properties))
          NFTThumbnailIPFS(
            properties: properties,
            roundBorder: roundBorder,
            withContentInfo: withContentInfo,
          )
        else if (TokenUtil.isTokenHTTP(properties))
          NFTThumbnailHTTP(
            properties: properties,
            roundBorder: roundBorder,
            withContentInfo: withContentInfo,
          )
        else if (TokenUtil.isTokenAEWEB(properties))
          NFTThumbnailAEWEB(
            properties: properties,
            roundBorder: roundBorder,
            withContentInfo: withContentInfo,
          )
        else
          NFTThumbnailError(message: localizations.nftNotFound),
      ],
    );
  }
}
