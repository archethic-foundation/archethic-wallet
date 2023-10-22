/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/widgets/components/image_network.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ImageNetworkWidgeted extends ConsumerWidget {
  const ImageNetworkWidgeted({
    required this.url,
    required this.errorMessage,
    super.key,
  });

  final String url;
  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    if (MimeUtil.isSvgFromExtension(url)) {
      return Align(
        child: SvgPicture.network(
          url,
        ),
      );
    } else {
      if (MimeUtil.isImageFromExtension(url)) {
        return ImageNetwork(
          url: url,
          error: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 2, left: 10),
              child: Text(
                errorMessage,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ),
          ),
          loading: Center(
            child: CircularProgressIndicator(
              color: ArchethicTheme.text,
              strokeWidth: 1,
            ),
          ),
        );
      } else {
        return NFTThumbnailError(message: localizations.previewNotAvailable);
      }
    }
  }
}
