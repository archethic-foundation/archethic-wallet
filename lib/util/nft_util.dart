/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// Package imports:
import 'package:aewallet/model/data/account_token.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

// Project imports:
import 'package:aewallet/util/get_it_instance.dart';

RegExp _base64 = RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

class NFTUtil {
  static Future<Uint8List?> getImageFromTokenAddress(
    String address,
  ) async {
    final Completer<Uint8List> completer = Completer<Uint8List>();
    Uint8List? imageDecoded;
    final Token token = await sl
        .get<ApiService>()
        .getToken(address, request: 'properties {name, value}');
    if (token.tokenProperties != null && token.tokenProperties!.isNotEmpty) {
      List<TokenProperty> list = token.tokenProperties![0];
      for (TokenProperty tokenProperty in list) {
        if (tokenProperty.name == 'file') {
          if (_base64.hasMatch(tokenProperty.value!) == true) {
            imageDecoded = base64Decode(tokenProperty.value!);
          }
        }
      }
    }
    completer.complete(imageDecoded);
    return completer.future;
  }

  static Future<List<Uint8List>?> getImagesFromTokenAddressList(
      List<AccountToken> accountTokenList) async {
    final Completer<List<Uint8List>> completer = Completer<List<Uint8List>>();
    List<Uint8List> imageDecodedList = List<Uint8List>.empty(growable: true);
    for (AccountToken accountToken in accountTokenList) {
      Uint8List? imageDecoded = await getImageFromTokenAddress(
          accountToken.tokenInformations!.address!);

      imageDecodedList.add(imageDecoded!);
    }

    return completer.future;
  }
}
