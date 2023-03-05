/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/url/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewIPFS extends ConsumerWidget {
  const NFTCreationProcessFilePreviewIPFS({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final fileUrl = nftCreation.fileURL;

    if (fileUrl == null || fileUrl.isEmpty) {
      return const SizedBox();
    }

    final ipfsFormattedUrl = ref.watch(
      UrlProvider.urlIPFSForWeb(
        uri: fileUrl,
      ),
    );

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.text,
            border: Border.all(),
          ),
          child: Image.network(
            ipfsFormattedUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
