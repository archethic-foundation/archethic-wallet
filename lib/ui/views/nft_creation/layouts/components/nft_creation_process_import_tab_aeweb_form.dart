/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/url/provider.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_template_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabAEWebForm extends ConsumerWidget {
  const NFTCreationProcessImportTabAEWebForm({
    super.key,
    required this.onConfirm,
  });

  final void Function(String uri) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return NFTCreationProcessImportTabTemplateForm(
      title: localizations.nftAddImportAEWebTitle,
      placeholder: localizations.nftAddImportAEWebPlaceholder,
      buttonLabel: localizations.nftAddImportAEWebButton,
      warningLabel: localizations.nftAddImportAEWebWarning,
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
          setError(localizations.enterEndpointBlank);
          return;
        }

        final valueCleaned = value.replaceAll(' ', '');

        if (!ref.watch(
          UrlProvider.isUrlAEWeb(
            uri: valueCleaned,
          ),
        )) {
          setError(localizations.enterEndpointNotValid);
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
