import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipantsCount extends ConsumerWidget {
  const AirdropParticipantsCount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropCountAsync = ref.watch(airdropCountProvider);
    final bodyMedium = AppTextStyles.bodyMedium(context);
    final bodyMediumSecondary = AppTextStyles.bodyMediumSecondaryColor(context);

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: '',
        children: <InlineSpan>[
          TextSpan(
            text: localizations
                .airdropParticipateStepWelcomeCardParticipantsCount,
            style: bodyMedium,
          ),
          airdropCountAsync.when(
            data: (data) => TextSpan(
              text: data != null ? '$data' : '?',
              style: bodyMediumSecondary,
            ),
            error: (_, __) => TextSpan(
              text: '?',
              style: bodyMediumSecondary,
            ),
            loading: () => TextSpan(
              text: '',
              style: bodyMediumSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
