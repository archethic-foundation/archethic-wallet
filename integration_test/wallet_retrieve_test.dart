//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'action/import_wallet.dart';
import 'config/config.dart';

void main() {
  patrolTest(
    'As a user I can retrieve my wallet',
    nativeAutomatorConfig: nativeAutomatorConfig,
    ($) async {
      await app.main();
      await importWalletAction($);

      expect($(#TxListLine), findsWidgets);
    },
  );
}
