/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_loading.dart';
import 'package:aewallet/util/cache_manager_hive.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:logging/logging.dart';

class NFTThumbnailImage extends StatefulWidget {
  const NFTThumbnailImage({
    super.key,
    required this.properties,
    required this.address,
    this.roundBorder = false,
  });

  final Map<String, dynamic> properties;
  final bool roundBorder;
  final String address;

  @override
  NFTThumbnailImageState createState() => NFTThumbnailImageState();
}

class NFTThumbnailImageState extends State<NFTThumbnailImage>
    with AutomaticKeepAliveClientMixin {
  final _logger = Logger('NFTThumbnailImage');
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
        if (MimeUtil.isImage(widget.properties['type_mime']) == true ||
            MimeUtil.isPdf(widget.properties['type_mime']) == true)
          FutureBuilder<Uint8List?>(
            future: _getImageFromToken(
              widget.address,
              widget.properties,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                _logger.info(
                  '${widget.address} Error ${DateTime.now().toUtc()}',
                );
                return NFTThumbnailError(
                  message: localizations.previewNotAvailable,
                );
              }
              if (snapshot.hasData) {
                _logger.info(
                  '${widget.address} Data ${DateTime.now().toUtc()}',
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
                _logger.info(
                  '${widget.address} Loading ${DateTime.now().toUtc()}',
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
  Map<String, dynamic> properties,
) async {
  final _logger = Logger('cacheManagement')
    ..info(
      'start _getImageFromToken ${DateTime.now().toUtc()}',
    );

  if (UniversalPlatform.isAndroid ||
      UniversalPlatform.isIOS ||
      UniversalPlatform.isMacOS) {
    final cacheManagerHive = await CacheManagerHive.getInstance();
    final cacheItem = cacheManagerHive.get(address);

    if (cacheItem != null) {
      _logger
        ..info('Use cache for token $address')
        ..info(
          'end _getImageFromToken ${DateTime.now().toUtc()}',
        );
      return cacheItem;
    } else {
      _logger.info('No cache for token $address');
      final imageBytes = await TokenUtil.getImageFromToken(
        properties,
      );
      if (imageBytes == null) {
        _logger.info(
          'end _getImageFromToken ${DateTime.now().toUtc()}',
        );
        return Uint8List.fromList([]);
      }
      _logger.info('Add cache for token $address');
      await cacheManagerHive.put(
        address,
        CacheItemHive(imageBytes),
      );
      _logger.info(
        'end _getImageFromToken ${DateTime.now().toUtc()}',
      );
      return imageBytes;
    }
  } else {
    _logger.info('No cache for token $address');
    final imageBytes = await TokenUtil.getImageFromToken(
      properties,
    );
    _logger.info(
      'end _getImageFromToken ${DateTime.now().toUtc()}',
    );
    return imageBytes!;
  }
}
