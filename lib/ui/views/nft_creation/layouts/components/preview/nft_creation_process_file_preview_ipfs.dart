/// SPDX-License-Identifier: AGPL-3.0-or-later';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/image_network.dart';
import 'package:aewallet/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewIPFS extends ConsumerWidget with UrlUtil {
  const NFTCreationProcessFilePreviewIPFS({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileUrl = nftCreation.fileURL;
    final localizations = AppLocalizations.of(context)!;

    if (fileUrl == null || fileUrl.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        ImageNetwork(
          url: UrlUtil.convertUrlIPFSForWeb(fileUrl),
          error: Text(localizations.nftIPFSEmpty),
          loading: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(
                color: ArchethicTheme.text,
                strokeWidth: 1,
              ),
            ),
          ),
        ),
        SelectableText(
          '${localizations.nftIPFSFrom}\n$fileUrl',
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
        ),
      ],
    );
  }
}
