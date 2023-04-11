/// SPDX-License-Identifier: AGPL-3.0-or-later';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/image_network_safe.dart';
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
        ImageNetworkSafe(
          url: UrlUtil.convertUrlIPFSForWeb(fileUrl),
          error: Text(localizations.nftIPFSEmpty),
          loading: const SizedBox(),
        ),
      ],
    );
  }
}
