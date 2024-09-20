import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_list_item.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EarnFarmLockInfos extends ConsumerWidget {
  const EarnFarmLockInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final earnForm =
        ref.watch(earnFormNotifierProvider).value ?? const EarnFormState();

    return InkWell(
      onTap: earnForm.farmLock == null
          ? null
          : () async {
              return showDialog<void>(
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Scaffold(
                      extendBodyBehindAppBar: true,
                      extendBody: true,
                      backgroundColor: Colors.transparent.withAlpha(120),
                      body: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: FarmLockListItem(
                              key: ValueKey(earnForm.pool!.poolAddress),
                              farmLock: earnForm.farmLock!,
                              heightCard: 440,
                              isInPopup: true,
                            )
                                .animate()
                                .fade(
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                )
                                .scale(
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
      child: Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: earnForm.farmLock == null
              ? aedappfm.AppThemeBase.gradient
              : aedappfm.AppThemeBase.gradientBtn,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          aedappfm.Iconsax.search_status,
          size: 18,
        ),
      ),
    );
  }
}
