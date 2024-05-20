/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/dapps_info.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardDapps extends ConsumerWidget {
  const CardDapps({
    super.key,
    required this.dAppsInfo,
  });

  final DAppsInfo dAppsInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            if (dAppsInfo.dAppBackgroundImgCard != null)
              Positioned.fill(
                child: Image.asset(
                  dAppsInfo.dAppBackgroundImgCard!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: aedappfm.AppThemeBase.sheetBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: aedappfm.AppThemeBase.sheetBorder,
                ),
              ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                key: Key('dAppsInfo${dAppsInfo.dAppName}'),
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  context.go(
                    dAppsInfo.dAppLink ?? '',
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 4,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              dAppsInfo.dAppName ?? '',
                              style: ArchethicThemeStyles
                                  .textStyleSize16W600Primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Symbols.arrow_right_alt,
                              size: 18,
                              color: ArchethicThemeBase.raspberry300,
                            )
                          ],
                        ),
                        Text(
                          dAppsInfo.dAppDesc ?? '',
                          style:
                              ArchethicThemeStyles.textStyleSize14W200Primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
