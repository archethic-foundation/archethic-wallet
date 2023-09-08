/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail_error.dart';
import 'package:aewallet/ui/widgets/components/image_network_widgeted.dart';
import 'package:aewallet/util/token_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTThumbnailHTTP extends ConsumerWidget {
  const NFTThumbnailHTTP({
    super.key,
    required this.token,
    this.roundBorder = false,
    this.withContentInfo = false,
  });

  final Token token;
  final bool roundBorder;
  final bool withContentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final raw = TokenUtil.getHTTPUrlFromToken(
      token,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    url: raw,
                    errorMessage: localizations.nftURLEmpty,
                  ),
                )
              : ImageNetworkWidgeted(
                  url: raw,
                  errorMessage: localizations.nftURLEmpty,
                ),
        if (withContentInfo)
          Padding(
            padding: const EdgeInsets.all(10),
            child: SelectableText(
              '${localizations.nftHTTPFrom}\n${raw!}',
              style: theme.textStyleSize12W100Primary,
            ),
          ),
        if (withContentInfo)
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    Symbols.warning,
                    color: theme.warning,
                    size: 12,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    localizations.nftHTTPLinkDisclaimer,
                    style: theme.textStyleSize12W100PrimaryWarning,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
