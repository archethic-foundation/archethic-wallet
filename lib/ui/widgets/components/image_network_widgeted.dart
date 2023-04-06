/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
            child: Text(
              errorMessage,
              style: theme.textStyleSize16W600Primary,
            ),
          ),
          loading: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return NFTThumbnailError(message: localizations.previewNotAvailable);
      }
    }
  }
}
