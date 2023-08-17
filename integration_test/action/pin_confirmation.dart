import 'package:patrol/patrol.dart';

Future<void> validPinConfirmation(PatrolIntegrationTester $) async {
  // code pin 000000
  const pinConfirmationLength = 6;
  for (var i = pinConfirmationLength; i >= 1; i--) {
    await $('0').tap(
      settleTimeout: const Duration(minutes: 10),
    );
  }
}
