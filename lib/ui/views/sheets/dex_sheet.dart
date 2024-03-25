/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:io';

import 'package:aewallet/infrastructure/rpc/awc_webview.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// TODO(redDwarf03): WebView POC - To remove
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
  @override
  void initState() {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetAppBar(
        title: 'Dex',
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: AWCWebview(
          uri: Uri.parse(
              Platform.isAndroid // TODO(Reddwarf03) : Use production dex URI
                  ? 'http://10.0.2.2:8080'
                  : 'http://localhost:8080'),
        ),
      ),
    );
  }
}
