/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/verified_tokens.dart';

abstract class VerifiedTokensRepositoryInterface {
  Future<VerifiedTokens> getVerifiedTokens();
}
