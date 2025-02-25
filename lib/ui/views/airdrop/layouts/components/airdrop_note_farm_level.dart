import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropNoteFarmLevel extends ConsumerWidget {
  const AirdropNoteFarmLevel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '* ',
            style: Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textBaseline: TextBaseline.alphabetic,
                ),
          ),
          TextSpan(
            text: 'Note:',
            style: Theme.of(context)
                .textTheme
                .bodySmallWithOpacity
                .copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' ${localizations.airdropStepsNoteDesc}',
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
        ],
      ),
    );
  }
}
