import 'package:archethic_lib_dart/archethic_lib_dart.dart' show TokenProperty;

/// SPDX-License-Identifier: AGPL-3.0-or-later

class TokenPropertyWithAccessInfos {
  TokenPropertyWithAccessInfos({this.tokenProperty, this.publicKeysList});

  TokenProperty? tokenProperty;
  List<String>? publicKeysList;
}
