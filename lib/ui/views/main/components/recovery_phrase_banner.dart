import 'dart:core';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/info_banner.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecoveryPhraseBanner extends ConsumerWidget {
  const RecoveryPhraseBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryPhraseSavedAsync =
        ref.watch(RecoveryPhraseSavedProvider.isRecoveryPhraseSaved);

    return recoveryPhraseSavedAsync.map(
      data: (data) => data.value == false
          ? Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: () async {
                  final preferences = ref.read(SettingsProviders.settings);
                  final authenticationSettings = ref.read(
                    AuthenticationProviders.settings,
                  );

                  final auth = await AuthFactory.authenticate(
                    context,
                    ref,
                    authMethod: AuthenticationMethod(
                      authenticationSettings.authenticationMethod,
                    ),
                    activeVibrations: preferences.activeVibrations,
                  );
                  if (auth) {
                    await ref.ensuresAutolockMaskHidden();

                    final seed = ref
                        .read(SessionProviders.session)
                        .loggedIn
                        ?.wallet
                        .seed;
                    final mnemonic = AppMnemomics.seedToMnemonic(
                      seed!,
                      languageCode: preferences.languageSeed,
                    );

                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: AppSeedBackupSheet(mnemonic),
                    );
                  }
                },
                child: InfoBanner(
                  AppLocalizations.of(context)!.recoveryPhraseBackupRequired,
                  fontSize: 10,
                ),
              ),
            )
          : const SizedBox(),
      error: (error) => const SizedBox(),
      loading: (loading) => const SizedBox(),
    );
  }
}
