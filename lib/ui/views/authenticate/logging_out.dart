/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';

import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoggingOutScreen extends ConsumerStatefulWidget {
  const LoggingOutScreen({
    super.key,
  });

  static const name = 'LoggingOutScreen';
  static const routerPage = '/logging_out';

  @override
  ConsumerState<LoggingOutScreen> createState() => _LoggingOutScreenState();
}

class _LoggingOutScreenState extends ConsumerState<LoggingOutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('Logging out');
      await ref.read(SessionProviders.session.notifier).logout();
      log('Logged out');
      context.go(Splash.routerPage);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLoadingPage(title: "Logging out");
  }
}
