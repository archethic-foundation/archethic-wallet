import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropCheckboxConfirmOnlyOneAirdrop extends ConsumerWidget {
  const AirdropCheckboxConfirmOnlyOneAirdrop({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return CheckboxConfirm(
      text: Text(
        localizations.airdropParticipateStepWelcomeConfirmItem1,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
      ),
      value: airdropForm.confirmOnlyOneAirdrop,
      onChanged: (value) {
        ref
            .read(airdropFormNotifierProvider.notifier)
            .setConfirmOnlyOneAirdrop(value);
      },
    );
  }
}
