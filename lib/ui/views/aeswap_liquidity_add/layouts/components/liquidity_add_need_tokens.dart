import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/swap_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class LiquidityAddNeedTokens extends ConsumerWidget {
  const LiquidityAddNeedTokens({
    required this.balance,
    required this.token,
    super.key,
  });

  final double balance;
  final DexToken token;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Container(
      alignment: Alignment.center,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: ArchethicThemeBase.raspberry300,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Buy ${token.symbol}'),
            const SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.arrow_forward_outlined,
                size: 16,
              ),
            ),
          ],
        ),
        onTap: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );

          final params = {
            'to': token.address,
          };

          ref.read(swapParametersProvider.notifier).state = params;

          ref.read(mainTabControllerProvider)!.animateTo(
                2,
                duration: Duration.zero,
              );
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(2);
          while (context.canPop()) {
            context.pop();
          }
        },
      ),
    );
  }
}
