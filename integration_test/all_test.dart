import 'package:flutter_test/flutter_test.dart';

import 'wallet_creation_test.dart' as wallet_creation_test;
import 'wallet_use_test.dart' as wallet_use_test;

void main() {
  group('All tests', () {
    wallet_creation_test.main();
    wallet_use_test.main();
  });
}
