import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/logging_out.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RemoveWalletDialog {
  static void show(
    BuildContext context,
    WidgetRef ref, {
    bool authRequired = true,
  }) {
    final localizations = AppLocalizations.of(context)!;
    final language = ref.read(
      LanguageProviders.selectedLanguage,
    );

    AppDialogs.showConfirmDialog(
        context,
        ref,
        CaseChange.toUpperCase(
          localizations.warning,
          language.getLocaleString(),
        ),
        localizations.removeWalletDetail,
        localizations.removeWalletAction, () {
      // Show another confirm dialog
      AppDialogs.showConfirmDialog(
        context,
        ref,
        localizations.areYouSure,
        localizations.removeWalletReassurance,
        localizations.yes,
        () async {
          if (authRequired) {
            final auth = await AuthFactory.of(context).authenticate();
            if (!auth) return;
          }

          context.go(LoggingOutScreen.routerPage);
        },
      );
    });
  }
}
