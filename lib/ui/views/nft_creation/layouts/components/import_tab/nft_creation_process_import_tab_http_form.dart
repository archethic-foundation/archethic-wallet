/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/url/provider.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_template_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTCreationProcessImportTabHTTPForm extends ConsumerWidget {
  const NFTCreationProcessImportTabHTTPForm({
    super.key,
    required this.onConfirm,
  });

  final void Function(String uri) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return NFTCreationProcessImportTabTemplateForm(
      title: localizations.nftAddImportURLTitle,
      placeholder: localizations.nftAddImportURLPlaceholder,
      buttonLabel: localizations.nftAddImportURLButton,
      warningLabel: localizations.nftAddImportURLWarning,
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

        final uriInput = ref.watch(
          UrlProvider.cleanUri(
            uri: value,
          ),
        );

        if (!ref.watch(
          UrlProvider.isUrlValid(
            uri: uriInput,
          ),
        )) {
          setError(localizations.enterEndpointNotValid);
          return;
        }
        onConfirm(
          value.replaceAll(' ', ''),
        );
        Navigator.of(contextForm).pop();
      },
    );
  }
}
