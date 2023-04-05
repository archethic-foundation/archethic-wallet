/// SPDX-License-Identifier: AGPL-3.0-or-later';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewAEWEB extends ConsumerWidget {
  const NFTCreationProcessFilePreviewAEWEB({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final fileUrl = nftCreation.fileURL;

    if (fileUrl == null || fileUrl.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        Center(
          child: Text(
            localizations.nftAEWebEmpty,
            style: theme.textStyleSize16W600Primary,
          ),
        )
      ],
    );
  }
}
