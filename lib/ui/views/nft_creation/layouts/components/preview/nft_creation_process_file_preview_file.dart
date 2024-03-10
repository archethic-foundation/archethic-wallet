/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewFile extends ConsumerWidget {
  const NFTCreationProcessFilePreviewFile({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: ArchethicTheme.text,
            border: Border.all(),
          ),
          child: Image.memory(
            nftCreation.fileDecodedForPreview!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            child: Text(
              '${localizations.formatLabel} ${nftCreation.fileTypeMime!}',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            child: Text(
              '${localizations.nftAddFileSize} ${filesize(nftCreation.fileSize)}',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ),
        ),
      ],
    );
  }
}
