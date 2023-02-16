import 'package:patrol/patrol.dart';
import 'package:requests/requests.dart';

Future<void> faucetRequestAction(PatrolTester $) async {
  // Request the form
  final formRequest =
      await Requests.get('https://testnet.archethic.net/faucet');
  formRequest.raiseForStatus();
  final body = formRequest.content();

  // Extract the CSRF
  final exp = RegExp(r'^.*name=\"_csrf_token\" value=\"(.*)\".*$');
  final matches = exp.allMatches(body).toList();
  final csrf = matches[0];

  // Save the cookies
  final cookies = await Requests.getStoredCookies('archethic.net');

  // Build the request for 100UCO
  Requests.setStoredCookies('archethic.net', cookies);

  final request100Uco = await Requests.post(
    'https://testnet.archethic.net/faucet',
    body: {'csrf': csrf, 'address': 100},
  );

  // Check the status
  request100Uco.raiseForStatus();
  assert(request100Uco.success);
}
