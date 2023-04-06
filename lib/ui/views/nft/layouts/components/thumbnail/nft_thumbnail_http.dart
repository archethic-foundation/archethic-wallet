/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_loading.dart';
import 'package:aewallet/ui/widgets/components/image_network_widgeted.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnailHTTP extends ConsumerWidget {
  const NFTThumbnailHTTP({
    super.key,
    required this.token,
    this.roundBorder = false,
  });

  final Token token;
  final bool roundBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder<String?>(
          future: TokenUtil.getHTTPUrlFromToken(
            token,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return NFTThumbnailError(
                  message: localizations.previewNotAvailable);
            }
            if (snapshot.hasData) {
              return roundBorder == true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageNetworkWidgeted(
                        url: snapshot.data,
                        errorMessage: localizations.nftURLEmpty,
                      ),
                    )
                  : ImageNetworkWidgeted(
                      url: snapshot.data,
                      errorMessage: localizations.nftURLEmpty,
                    );
            } else {
              return const NFTThumbnailLoading();
            }
          },
        )
      ],
    );
  }
}
