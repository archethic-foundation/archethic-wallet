/// SPDX-License-Identifier: AGPL-3.0-or-later';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/image_network_widgeted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewHTTP extends ConsumerWidget {
  const NFTCreationProcessFilePreviewHTTP({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileUrl = nftCreation.fileURL;
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    if (fileUrl == null || fileUrl.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        ImageNetworkWidgeted(
          url: fileUrl,
          errorMessage: localizations.nftURLEmpty,
        ),
        SelectableText(
          '${localizations.nftIPFSFrom}\n$fileUrl',
          style: theme.textStyleSize12W100Primary,
        ),
      ],
    );
  }
}
