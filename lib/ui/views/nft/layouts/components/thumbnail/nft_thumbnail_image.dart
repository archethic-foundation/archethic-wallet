/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer' as dev;
import 'dart:io';

import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_loading.dart';
import 'package:aewallet/util/cache_manager_hive.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class NFTThumbnailImage extends StatefulWidget {
  const NFTThumbnailImage({
    super.key,
    required this.token,
    required this.address,
    this.roundBorder = false,
    required this.typeMime,
  });

  final Token token;
  final bool roundBorder;
  final String typeMime;
  final String address;

  @override
  NFTThumbnailImageState createState() => NFTThumbnailImageState();
}

class NFTThumbnailImageState extends State<NFTThumbnailImage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (MimeUtil.isImage(widget.typeMime) == true ||
            MimeUtil.isPdf(widget.typeMime) == true)
          FutureBuilder<Uint8List?>(
            future: _getImageFromToken(
              widget.address,
              widget.token,
              widget.typeMime,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                dev.log(
                  '${widget.address} Error ${DateTime.now().toUtc()}',
                  name: 'NFTThumbnailImage',
                );
                return NFTThumbnailError(
                  message: localizations.previewNotAvailable,
                );
              }
              if (snapshot.hasData) {
                dev.log(
                  '${widget.address} Data ${DateTime.now().toUtc()}',
                  name: 'NFTThumbnailImage',
                );
                return widget.roundBorder == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          snapshot.data!,
                        ),
                      )
                    : Image.memory(
                        snapshot.data!,
                      );
              } else {
                dev.log(
                  '${widget.address} Loading ${DateTime.now().toUtc()}',
                  name: 'NFTThumbnailImage',
                );
                return const NFTThumbnailLoading();
              }
            },
          ),
      ],
    );
  }
}

Future<Uint8List> _getImageFromToken(
  String address,
  Token token,
  String typeMime,
) async {
  dev.log(
    'start _getImageFromToken ${DateTime.now().toUtc()}',
    name: 'cacheManagement',
  );
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
    final cacheManagerHive = await CacheManagerHive.getInstance();
    final cacheItem = cacheManagerHive.get(address);

    if (cacheItem != null) {
      dev.log('Use cache for token $address', name: 'cacheManagement');
      dev.log(
        'end _getImageFromToken ${DateTime.now().toUtc()}',
        name: 'cacheManagement',
      );
      return cacheItem;
    } else {
      dev.log('No cache for token $address', name: 'cacheManagement');
      final imageBytes = await TokenUtil.getImageFromToken(
        token,
        typeMime,
      );
      if (imageBytes == null) {
        dev.log(
          'end _getImageFromToken ${DateTime.now().toUtc()}',
          name: 'cacheManagement',
        );
        return Uint8List.fromList([]);
      }
      dev.log('Add cache for token $address', name: 'cacheManagement');
      await cacheManagerHive.put(
        address,
        CacheItemHive(imageBytes),
      );
      dev.log(
        'end _getImageFromToken ${DateTime.now().toUtc()}',
        name: 'cacheManagement',
      );
      return imageBytes;
    }
  } else {
    dev.log('No cache for token $address', name: 'cacheManagement');
    final imageBytes = await TokenUtil.getImageFromToken(
      token,
      typeMime,
    );
    dev.log(
      'end _getImageFromToken ${DateTime.now().toUtc()}',
      name: 'cacheManagement',
    );
    return imageBytes!;
  }
}
