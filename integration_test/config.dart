import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:patrol/patrol.dart';

const patrolConfig = PatrolTesterConfig(/*findTimeout: Duration(seconds: 90)*/);

const nativeAutomatorConfig = NativeAutomatorConfig(
  packageName: 'net.archethic.archethic_wallet',
  bundleId: 'tech.archethic.wallet',
  //findTimeout: Duration(seconds: 90),
);
