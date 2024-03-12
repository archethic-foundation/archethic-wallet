/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroNewWalletDisclaimer extends ConsumerWidget
    implements SheetSkeletonInterface {
  const IntroNewWalletDisclaimer({super.key, this.name});
  final String? name;

  static const routerPage = '/intro_backup_safety';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      backgroundImage: ArchethicTheme.backgroundWelcome,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.understandButton,
          Dimens.buttonBottomDimens,
          key: const Key('understandButton'),
          onPressed: () {
            context.go(
              IntroBackupSeedPage.routerPage,
              extra: name,
            );
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return SheetAppBar(
      title: localizations.warning,
      styleTitle: ArchethicThemeStyles.textStyleSize24W700PrimaryRed,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(IntroNewWalletGetFirstInfos.routerPage);
        },
      ),
      widgetRight:
          connectivityStatusProvider == ConnectivityStatus.isDisconnected
              ? const Padding(
                  padding: EdgeInsets.only(
                    right: 7,
                    top: 7,
                  ),
                  child: IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
                )
              : const SizedBox.shrink(),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          localizations.backupSafetyLabel1,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
        ),
        Divider(
          height: 20,
          color: ArchethicTheme.text60,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel2,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel3,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.justify,
        ),
        Divider(
          height: 20,
          color: ArchethicTheme.text60,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel4,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel5,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.justify,
        ),
        Divider(
          height: 20,
          color: ArchethicTheme.text60,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel6,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          localizations.backupSafetyLabel7,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
