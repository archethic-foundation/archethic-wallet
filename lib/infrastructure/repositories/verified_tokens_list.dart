/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aewallet/domain/models/verified_tokens.dart';
import 'package:aewallet/domain/repositories/tokens/verified_tokens_repository.dart';
import 'package:flutter/services.dart';

class VerifiedTokensList implements VerifiedTokensRepositoryInterface {
  @override
  Future<VerifiedTokens> getVerifiedTokens() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/tokens/verified_tokens.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return VerifiedTokens.fromJson(jsonData);
  }
}
