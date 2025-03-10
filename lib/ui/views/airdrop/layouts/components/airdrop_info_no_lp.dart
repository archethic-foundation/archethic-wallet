import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropInfoNoLP extends ConsumerWidget {
  const AirdropInfoNoLP({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    if (airdropForm.personalLP > 0) {
      return const SizedBox.shrink();
    }

    return MessageBox(
      messageBoxType: MessageBoxType.warning,
      content: Text(
        localizations.airdropInfoNoLPDesc,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
