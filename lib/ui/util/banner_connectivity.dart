/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_banners/super_banners.dart';

class BannerConnectivity extends ConsumerWidget {
  const BannerConnectivity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isConnected) {
      return const SizedBox();
    }
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Material(
      type: MaterialType.transparency,
      child: CornerBanner(
        bannerColor: theme.bannerColor!,
        shadowColor: theme.bannerShadowColor!,
        elevation: 7,
        child: Text(
          localizations.noConnectionBanner,
          style: theme.textStyleSize12W400EquinoxConnectivityBanner,
        ),
      ),
    );
  }
}
