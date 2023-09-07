import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/widgets/components/image_network_widgeted.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:aewallet/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NFTThumbnailIPFS extends ConsumerWidget with UrlUtil {
  const NFTThumbnailIPFS({
    super.key,
    required this.properties,
    this.roundBorder = false,
    this.withContentInfo = false,
  });

  final Map<String, dynamic> properties;
  final bool roundBorder;
  final bool withContentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final raw = TokenUtil.getIPFSUrlFromToken(
      properties,
    );
    return Stack(
      children: <Widget>[
        if (raw == null)
          NFTThumbnailError(
            message: localizations.previewNotAvailable,
          )
        else
          roundBorder == true
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ImageNetworkWidgeted(
                    url: UrlUtil.convertUrlIPFSForWeb(raw),
                    errorMessage: localizations.nftAEWebEmpty,
                  ),
                )
              : ImageNetworkWidgeted(
                  url: UrlUtil.convertUrlIPFSForWeb(raw),
                  errorMessage: localizations.nftAEWebEmpty,
                ),
        if (withContentInfo)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              tooltip: raw,
              iconSize: 16,
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    UrlUtil.convertUrlIPFSForWeb(raw!),
                  ),
                );
              },
              icon: const Icon(
                Icons.open_in_new_outlined,
              ),
            ),
          ),
      ],
    );
  }
}
