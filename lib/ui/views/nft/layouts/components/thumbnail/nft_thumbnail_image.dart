/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:typed_data';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_loading.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnailImage extends ConsumerWidget {
  const NFTThumbnailImage({
    super.key,
    required this.token,
    this.roundBorder = false,
    required this.typeMime,
  });

  final Token token;
  final bool roundBorder;
  final String typeMime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (MimeUtil.isImage(typeMime) == true ||
            MimeUtil.isPdf(typeMime) == true)
          FutureBuilder<Uint8List?>(
            future: TokenUtil.getImageFromToken(
              token,
              typeMime,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return NFTThumbnailError(
                  message: localizations.previewNotAvailable,
                );
              }
              if (snapshot.hasData) {
                return roundBorder == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          snapshot.data!,
                        ),
                      )
                    : Image.memory(
                        snapshot.data!,
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
