import 'dart:core';

import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/util/info_banner.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecoveryPhraseBanner extends ConsumerWidget {
  const RecoveryPhraseBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryPhraseSavedAsync =
        ref.watch(RecoveryPhraseSavedProvider.isRecoveryPhraseSaved);

    return recoveryPhraseSavedAsync.map(
      data: (data) => data.value == false
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: InkWell(
                  onTap: () async {
                    final preferences = ref.read(SettingsProviders.settings);

                    final auth = await AuthFactory.authenticate();
                    if (!auth) return;

                    final seed = ref
                        .read(SessionProviders.session)
                        .loggedIn
                        ?.wallet
                        .seed;
                    final mnemonic = AppMnemomics.seedToMnemonic(
                      seed!,
                      languageCode: preferences.languageSeed,
                    );
                    context.go(
                      AppSeedBackupSheet.routerPage,
                      extra: {'mnemonic': mnemonic, 'seed': seed},
                    );
                  },
                  child: InfoBanner(
                    AppLocalizations.of(context)!.recoveryPhraseBackupRequired,
                    fontSize: 10,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      error: (error) => const SizedBox(),
      loading: (loading) => const SizedBox(),
    );
  }
}
