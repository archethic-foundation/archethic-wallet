/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aewallet/domain/models/certified_tokens.dart';
import 'package:aewallet/domain/repositories/tokens/certified_tokens_repository.dart';
import 'package:flutter/services.dart';

class CertifiedTokensList implements CertifiedTokensRepositoryInterface {
  @override
  Future<CertifiedTokens> getCertifiedTokens() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/tokens/certified_tokens.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return CertifiedTokens.fromJson(jsonData);
  }
}
