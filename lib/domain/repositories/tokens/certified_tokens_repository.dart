/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/certified_tokens.dart';

abstract class CertifiedTokensRepositoryInterface {
  Future<CertifiedTokens> getCertifiedTokens();
}
