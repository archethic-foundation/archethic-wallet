/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_congrats.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_join_waitlist.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_sign.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_support_ecosystem.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateSheet extends ConsumerStatefulWidget {
  const AirdropParticipateSheet({
    super.key,
  });

  static const String routerPage = '/airdrop_participate';

  @override
  ConsumerState<AirdropParticipateSheet> createState() =>
      _AirdropParticipateSheetState();
}

class _AirdropParticipateSheetState
    extends ConsumerState<AirdropParticipateSheet> {
  @override
  Widget build(BuildContext context) {
    final selectedAccount = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;

    if (selectedAccount == null) return const SizedBox();

    ref.listen<AirdropFormState>(
      airdropFormNotifierProvider,
      (_, airdropForm) {
        if (airdropForm.failure == null ||
            airdropForm.failure!.message == null) {
          return;
        }

        UIUtil.showSnackbar(
          airdropForm.failure!.message!,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
          duration: const Duration(seconds: 5),
        );

        ref.read(airdropFormNotifierProvider.notifier).setFailure(null);
      },
    );
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return airdropForm.airdropProcessStep == AirdropProcessStep.welcome
        ? const AirdropParticipateStepWelcomeSheet()
        : airdropForm.airdropProcessStep == AirdropProcessStep.joinWaitlist
            ? const AirdropParticipateStepJoinWaitlistSheet()
            : airdropForm.airdropProcessStep == AirdropProcessStep.sign
                ? const AirdropParticipateStepSignSheet()
                : airdropForm.airdropProcessStep ==
                        AirdropProcessStep.supportEcosystem
                    ? const AirdropParticipateStepSupportEcosystemSheet()
                    : const AirdropParticipateStepCongratsSheet();
  }
}
