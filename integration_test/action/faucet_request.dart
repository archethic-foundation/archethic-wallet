import 'package:http/http.dart' as http;
import 'package:patrol/patrol.dart';

class CookieJar {
  final Map<String, String> _cookies = {};

  void setCookies(String cookies) {
    final cookieList = cookies.split(';');
    for (final cookie in cookieList) {
      final parts = cookie.split('=');
      if (parts.length == 2) {
        final key = parts[0].trim();
        final value = parts[1].trim();
        _cookies[key] = value;
      }
    }
  }

  String getCookies() {
    return _cookies.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('; ');
  }
}

Future<void> faucetRequestAction(PatrolIntegrationTester $) async {
  final cookieJar = CookieJar();

  // Request the form
  final formResponse =
      await http.get(Uri.parse('https://testnet.archethic.net/faucet'));
  if (formResponse.statusCode != 200) {
    throw Exception('Failed to fetch form');
  }
  final body = formResponse.body;

  // Extract the CSRF
  final exp = RegExp(r'^.*name=\"_csrf_token\" value=\"(.*)\".*$');
  final matches = exp.allMatches(body).toList();
  final csrf = matches[0].group(1);

  // Save the cookies
  final cookies = formResponse.headers['set-cookie'];
  cookieJar.setCookies(cookies!);

  // Build the request for 100UCO
  final request100Uco = await http.post(
    Uri.parse('https://testnet.archethic.net/faucet'),
    body: {'csrf': csrf, 'address': '100'},
    headers: {'Cookie': cookieJar.getCookies()},
  );

  // Check the status
  if (request100Uco.statusCode != 200) {
    throw Exception('Failed to get 100UCO');
  }
}
