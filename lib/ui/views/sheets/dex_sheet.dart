import 'package:aewallet/application/dapps.dart';
import 'package:aewallet/infrastructure/rpc/awc_webview.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/webview_appbar.dart';
import 'package:aewallet/ui/views/sheets/unavailable_feature_warning.dart';
import 'package:aewallet/ui/widgets/components/loading_list_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DEXSheet extends ConsumerWidget implements SheetSkeletonInterface {
  const DEXSheet({
    super.key,
    required this.url,
  });

  static bool get isAvailable => AWCWebview.isAvailable;
  static const String routerPage = '/dex';
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return WebviewAppBar(
      title: const Column(
        children: [
          Text(
            'aeSwap (beta)',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            'Decentralized Exchange',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: FutureBuilder<bool>(
        future: AWCWebview.isAWCSupported,
        builder: (context, snapshot) {
          final isAWCSupported = snapshot.data;
          if (isAWCSupported == null) {
            return const Center(child: LoadingListHeader());
          }

          if (!isAWCSupported) return const UnavailableFeatureWarning();

          return AWCWebview(
            uri: Uri.parse(url),
          );
        },
      ),
    );
  }
}
