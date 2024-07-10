/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_template_form.dart';
import 'package:aewallet/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NFTCreationProcessImportTabHTTPForm extends ConsumerWidget with UrlUtil {
  const NFTCreationProcessImportTabHTTPForm({
    super.key,
  });

  static const routerPage = '/nft_creation_process_import_tab_http';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return NFTCreationProcessImportTabTemplateForm(
      title: localizations.nftAddImportURLTitle,
      placeholder: localizations.nftAddImportURLPlaceholder,
      warningLabel: localizations.nftAddImportURLDescription,
      disclaimer: localizations.nftHTTPLinkDisclaimer,
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
          setError(localizations.nftHTTPUrlEmpty);
          return;
        }

        if (!UrlUtil.isUrlValid(
          value,
        )) {
          setError(localizations.nftHTTPUrlNotValid);
          return;
        }

        final nftCreationNotifier = ref.read(
          NftCreationFormProvider.nftCreationForm.notifier,
        );

        // ignore: cascade_invocations
        nftCreationNotifier.setContentHTTPProperties(
          context,
          value.replaceAll(' ', ''),
        );

        contextForm.pop();
      },
    );
  }
}
