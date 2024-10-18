import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({required this.payload, super.key});

  final String payload;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return AppButtonTinyConnectivity(
      localizations.share,
      Dimens.buttonBottomDimens,
      key: const Key('share'),
      onPressed: () async {
        final box = context.findRenderObject() as RenderBox?;
        await Share.share(
          payload,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      },
    );
  }
}
