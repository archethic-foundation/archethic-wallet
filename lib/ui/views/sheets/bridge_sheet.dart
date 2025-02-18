import 'dart:ui';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/main_appbar_basic.dart';
import 'package:aewallet/ui/views/sheets/bridge_sheet_feature_flag_false.dart';
import 'package:aewallet/ui/views/sheets/dapp_sheet.dart';
import 'package:aewallet/ui/views/sheets/dapp_sheet_icon_refresh.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BridgeSheet extends StatelessWidget {
  const BridgeSheet({super.key});

  static const String routerPage = '/bridge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BridgeAppBar(),
      backgroundColor: aedappfm.AppThemeBase.sheetBackground.withOpacity(0.2),
      body: DAppSheet.withFeatureFlag(
        dappKey: 'aeBridge',
        launchMessage: AppLocalizations.of(context)!.aeBridgeLaunchMessage,
        launchButtonLabel: AppLocalizations.of(context)!.aeBridgeLaunchButton,
        featureCode: 'bridge',
        featureUnavailableBuilder: (cause, dapp) => BridgeSheetFeatureFlagFalse(
          cause: cause,
          dapp: dapp,
        ),
      ),
    );
  }
}

class BridgeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BridgeAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final environment = ref.watch(environmentProvider);
    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: CloseButton(
        key: const Key('close'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        DAppSheetIconRefresh(dappKey: 'aeBridge'),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: Column(
        children: [
          MainAppBarBasic(
            header: localizations.aeBridgeHeader,
          ),
          if (environment != aedappfm.Environment.mainnet)
            Text(
              environment.label,
              style: AppTextStyles.bodySmallSecondaryColor(context),
            ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }
}
