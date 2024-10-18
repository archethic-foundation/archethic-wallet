/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

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
  static final _logger = Logger('LoggingOutScreen');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _logger.info('Logging out');
      await Future.wait([
        Future.delayed(const Duration(seconds: 2)),
        ref.read(sessionNotifierProvider.notifier).logout(),
      ]);
      _logger.info('Logged out');
      context.go(Splash.routerPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return LoadingAnimationPage(
      title: localizations.loggingOutWaitMessage,
    );
  }
}
