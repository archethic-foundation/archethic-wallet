/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessFilePreview extends ConsumerWidget {
  const NFTCreationProcessFilePreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    if (nftCreation.file == null ||
        nftCreation.file!.keys.isEmpty ||
        (MimeUtil.isImage(nftCreation.fileTypeMime) == false &&
            MimeUtil.isPdf(nftCreation.fileTypeMime) == false)) {
      return const SizedBox();
    }
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: [
        if (nftCreation.name.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              child: Text(
                nftCreation.name,
                style: theme.textStyleSize16W400Primary,
              ),
            ),
          ),
        if (nftCreation.symbol.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Align(
              child: Text(
                key: const Key('nftCreationConfirmation'),
                '[${nftCreation.symbol}]',
                style: theme.textStyleSize12W400Primary,
              ),
            ),
          ),
        if (nftCreation.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Align(
              child: Text(
                nftCreation.description,
                style: theme.textStyleSize12W400Primary,
              ),
            ),
          ),
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
