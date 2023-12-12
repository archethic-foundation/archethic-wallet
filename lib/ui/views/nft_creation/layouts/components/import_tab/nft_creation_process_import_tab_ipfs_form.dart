/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_template_form.dart';
import 'package:aewallet/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NFTCreationProcessImportTabIPFSForm extends ConsumerWidget with UrlUtil {
  const NFTCreationProcessImportTabIPFSForm({
    super.key,
    required this.onConfirm,
  });

  final void Function(String uri) onConfirm;

  static const routerPage = '/nft_creation_process_import_tab_ipfs';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return NFTCreationProcessImportTabTemplateForm(
      title: localizations.nftAddImportIPFSTitle,
      placeholder: localizations.nftAddImportIPFSPlaceholder,
      warningLabel: localizations.nftAddImportIPFSDescription,
      onConfirm: (String value, BuildContext contextForm) {
        void setError(String errorText) {
          UIUtil.showSnackbar(
            errorText,
            contextForm,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
          );
        }

        if (value.isEmpty) {
          setError(localizations.nftIPFSUrlEmpty);
          return;
        }

        if (!UrlUtil.isUrlIPFS(value)) {
          setError(localizations.nftIPFSUrlNotValid);
          return;
        }
        onConfirm(
          value.replaceAll(' ', ''),
        );
        contextForm.pop();
      },
    );
  }
}
