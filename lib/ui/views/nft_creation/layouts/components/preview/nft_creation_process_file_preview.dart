/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/preview/nft_creation_process_file_preview_aeweb.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/preview/nft_creation_process_file_preview_file.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/preview/nft_creation_process_file_preview_http.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/preview/nft_creation_process_file_preview_ipfs.dart';
import 'package:aewallet/util/mime_util.dart';
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
    final isTypeImportFile = [
      FileImportType.file,
      FileImportType.camera,
      FileImportType.image,
    ].contains(nftCreation.fileImportType);

    final isTypeImportURL = [
      FileImportType.ipfs,
      FileImportType.aeweb,
      FileImportType.http,
    ].contains(nftCreation.fileImportType);

    final isInvalidFile = nftCreation.file == null ||
        nftCreation.file!.keys.isEmpty ||
        (MimeUtil.isImage(nftCreation.fileTypeMime) == false &&
                MimeUtil.isPdf(nftCreation.fileTypeMime) == false) &&
            !isTypeImportFile;

    final isInvalidUrl = nftCreation.fileURL == null && !isTypeImportURL;

    if (isInvalidFile && isInvalidUrl) {
      return const SizedBox();
    }

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
        if (isTypeImportFile)
          NFTCreationProcessFilePreviewFile(
            nftCreation: nftCreation,
          ),
        if (nftCreation.fileImportType == FileImportType.ipfs)
          NFTCreationProcessFilePreviewIPFS(
            nftCreation: nftCreation,
          ),
        if (nftCreation.fileImportType == FileImportType.http)
          NFTCreationProcessFilePreviewHTTP(
            nftCreation: nftCreation,
          ),
        if (nftCreation.fileImportType == FileImportType.aeweb)
          NFTCreationProcessFilePreviewAEWEB(
            nftCreation: nftCreation,
          ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
