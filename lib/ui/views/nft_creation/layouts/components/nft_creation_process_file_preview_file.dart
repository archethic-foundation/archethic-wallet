/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreviewFile extends ConsumerWidget {
  const NFTCreationProcessFilePreviewFile({
    super.key,
    required this.nftCreation,
  });

  final NftCreationFormState nftCreation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.text,
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
              style: theme.textStyleSize12W400Primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            child: Text(
              '${localizations.nftAddFileSize} ${filesize(nftCreation.fileSize)}',
              style: theme.textStyleSize12W400Primary,
            ),
          ),
        ),
      ],
    );
  }
}
