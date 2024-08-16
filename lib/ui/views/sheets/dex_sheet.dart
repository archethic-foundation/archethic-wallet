import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/dapps.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/infrastructure/rpc/awc_webview.dart';
import 'package:aewallet/ui/views/sheets/unavailable_feature_warning.dart';
import 'package:aewallet/ui/widgets/components/loading_list_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DEXSheet extends ConsumerStatefulWidget {
  const DEXSheet({
    super.key,
  });

  static bool get isAvailable => AWCWebview.isAvailable;
  static const String routerPage = '/dex';

  @override
  ConsumerState<DEXSheet> createState() => DEXSheetState();
}

class DEXSheetState extends ConsumerState<DEXSheet> {
  String? aeSwapUrl;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final networkSettings = ref.watch(
        SettingsProviders.settings.select((settings) => settings.network),
      );

      final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
      DApp? dapp;
      if (connectivityStatusProvider == ConnectivityStatus.isConnected &&
          DEXSheet.isAvailable) {
        dapp = await ref.read(
          DAppsProviders.getDApp(networkSettings.network, 'aeSwap').future,
        );
        setState(() {
          aeSwapUrl = dapp!.url;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: FutureBuilder<bool>(
        future: AWCWebview.isAWCSupported,
        builder: (context, snapshot) {
          final isAWCSupported = snapshot.data;
          if (isAWCSupported == null) {
            return const Center(child: LoadingListHeader());
          }

          if (!isAWCSupported) return const UnavailableFeatureWarning();

          if (aeSwapUrl != null) {
            return AWCWebview(
              uri: Uri.parse(aeSwapUrl!),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
