/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_template_form.dart';
import 'package:aewallet/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabAEWebForm extends ConsumerWidget with UrlUtil {
  const NFTCreationProcessImportTabAEWebForm({
    super.key,
    required this.onConfirm,
  });

  final void Function(String uri) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return NFTCreationProcessImportTabTemplateForm(
      title: localizations.nftAddImportAEWebTitle,
      placeholder: localizations.nftAddImportAEWebPlaceholder,
      warningLabel: localizations.nftAddImportAEWebDescription,
      disclaimer: localizations.nftAEWebLinkDisclaimer,
      onConfirm: (String value, BuildContext contextForm) {
        void setError(String errorText) {
          UIUtil.showSnackbar(
            errorText,
            contextForm,
            ref,
            theme.text!,
            theme.snackBarShadow!,
          );
        }

        if (value.isEmpty) {
          setError(localizations.nftAEWebUrlEmpty);
          return;
        }

        final valueCleaned = value.replaceAll(' ', '');

        if (!UrlUtil.isUrlAEWeb(
          valueCleaned,
        )) {
          setError(localizations.nftAEWebUrlNotValid);
          return;
        }
        onConfirm(
          valueCleaned,
        );
        Navigator.of(contextForm).pop();
      },
    );
  }
}
