import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/dapps.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/infrastructure/rpc/awc_webview.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/webview_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/sheets/unavailable_feature_warning.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/loading_list_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DEXSheet extends ConsumerStatefulWidget {
  const DEXSheet({
    super.key,
  });

  static bool get isAvailable => AWCWebview.isAvailable;
  static const String routerPage = '/dex';

  @override
  ConsumerState<DEXSheet> createState() => DEXSheetState();
}

class DEXSheetState extends ConsumerState<DEXSheet>
    implements SheetSkeletonInterface {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      menu: true,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return WebviewAppBar(
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: AutoSizeText(
          localizations.aeSwapHeader,
          style: ArchethicThemeStyles.textStyleSize24W700Primary,
        ),
      ).animate().fade(duration: const Duration(milliseconds: 300)),
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () async {
          AppDialogs.showConfirmDialog(
            context,
            ref,
            AppLocalizations.of(context)!.exitAESwapTitle,
            AppLocalizations.of(context)!.exitAESwap,
            AppLocalizations.of(context)!.yes,
            () {
              context.go(HomePage.routerPage);
            },
            cancelText: AppLocalizations.of(context)!.no,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
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
