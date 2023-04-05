/// SPDX-License-Identifier: AGPL-3.0-or-later';
import 'package:aewallet/application/url/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/image_network_safe_widgeted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewIPFS extends ConsumerWidget {
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

    final ipfsFormattedUrl = ref.watch(
      UrlProvider.urlIPFSForWeb(
        uri: fileUrl,
      ),
    );

    return Column(
      children: [
        ImageNetworkSafeWidgeted(
          url: ipfsFormattedUrl,
          errorMessage: localizations.nftIPFSEmpty,
        ),
      ],
    );
  }
}
