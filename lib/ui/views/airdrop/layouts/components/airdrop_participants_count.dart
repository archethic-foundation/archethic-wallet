import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipantsCount extends ConsumerWidget {
  const AirdropParticipantsCount({
    this.withShadow = false,
    super.key,
  });

  final bool withShadow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropCountAsync = ref.watch(airdropCountProvider);
    final bodyMedium = withShadow
        ? Theme.of(context).textTheme.bodyMediumWithOpacity.copyWith(
            fontWeight: FontWeightTelegraf.fontWeightSemibold,
            shadows: [
              const Shadow(
                offset: Offset(0, 1),
                blurRadius: 8,
              ),
            ],
          )
        : Theme.of(context).textTheme.bodySmallWithOpacity;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: '',
        children: <InlineSpan>[
          airdropCountAsync.when(
            data: (data) => TextSpan(
              text: data.participantCount != null
                  ? '${data.participantCount} '
                  : '? ',
              style: bodyMedium,
            ),
            error: (_, __) => TextSpan(
              text: '? ',
              style: bodyMedium,
            ),
            loading: () => TextSpan(
              text: '',
              style: bodyMedium,
            ),
          ),
          TextSpan(
            text: localizations
                .airdropParticipateStepWelcomeCardParticipantsCount,
            style: bodyMedium,
          ),
        ],
      ),
    );
  }
}
