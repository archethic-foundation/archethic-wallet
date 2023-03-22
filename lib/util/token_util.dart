/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/src/model/token.dart';
import 'package:pdfx/pdfx.dart';

class TokenUtil {
  static Future<Map<String, Token>> getTokensFromAddress(
    String address,
  ) async {
    final tokenMap =
        await sl.get<AppService>().getToken([address], request: 'properties');

    return tokenMap;
  }

  static Token getTokenByAddressFromTokenMap(
    Map<String, Token> tokenMap,
    String address,
  ) {
    return tokenMap[address]!;
  }

  static Future<Token?> getTokenByAddress(
    String address,
  ) async {
    final tokenMap =
        await sl.get<AppService>().getToken([address], request: 'properties');

    if (tokenMap.isEmpty) {
      return null;
    }
    return getTokenByAddressFromTokenMap(tokenMap, address);
  }

  static bool isTokenFile(Token token) {
    var flag = false;

    token.properties.forEach((key, value) {
      if (key == 'content') {
        value.forEach((key, value) {
          if (key == 'raw') {
            flag = true;
          }
        });
      }
    });

    return flag;
  }

  static bool isTokenIPFS(Token token) {
    var flag = false;

    token.properties.forEach((key, value) {
      if (key == 'content') {
        value.forEach((key, value) {
          if (key == 'ipfs') {
            flag = true;
          }
        });
      }
    });

    return flag;
  }

  static bool isTokenHTTP(Token token) {
    var flag = false;

    token.properties.forEach((key, value) {
      if (key == 'content') {
        value.forEach((key, value) {
          if (key == 'http_url') {
            flag = true;
          }
        });
      }
    });

    return flag;
  }

  static bool isTokenAEWEB(Token token) {
    var flag = false;

    token.properties.forEach((key, value) {
      if (key == 'content') {
        value.forEach((key, value) {
          if (key == 'aeweb') {
            flag = true;
          }
        });
      }
    });

    return flag;
  }

  static T? getValueFromKeyInTokenContent<T>(
    Token token,
    String keyToSearch,
  ) {
    T? valueToReturn;

    token.properties.forEach((key, value) {
      if (key == 'content') {
        value.forEach((key, value) {
          if (key == keyToSearch) {
            valueToReturn = value;
          }
        });
      }
    });

    return valueToReturn;
  }

  static Future<Uint8List?> getImageDecodedForPdf(
    Uint8List valueFileDecoded,
  ) async {
    final pdfDocument = await PdfDocument.openData(
      valueFileDecoded,
    );
    final pdfPage = await pdfDocument.getPage(1);

    final pdfPageImage =
        await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
    return pdfPageImage!.bytes;
  }

  static Future<Uint8List?> getImageDecoded(
    Uint8List valueFileDecoded,
    String typeMime,
  ) async {
    if (MimeUtil.isPdf(typeMime) == false) {
      return valueFileDecoded;
    }
    return getImageDecodedForPdf(valueFileDecoded);
  }

  static Future<Uint8List?> getImageFromToken(
    Token token,
    String typeMime,
  ) async {
    Uint8List? valueFileDecoded;
    Uint8List? imageDecoded;
    if (token.properties.isNotEmpty) {
      valueFileDecoded =
          base64Decode(getValueFromKeyInTokenContent(token, 'raw'));
    }

    if (valueFileDecoded == null) {
      return imageDecoded;
    }

    return getImageDecoded(valueFileDecoded, typeMime);
  }

  static Future<Uint8List?> getImageFromTokenAddress(
    String address,
    String typeMime,
  ) async {
    final token = await getTokenByAddress(address);
    if (token == null) {
      return Uint8List.fromList([]);
    }

    return getImageFromToken(token, typeMime);
  }

  static Future<String?>? getIPFSUrlFromToken(Token token) async {
    String? imageDecoded;

    if (token.properties.isNotEmpty) {
      imageDecoded = getValueFromKeyInTokenContent(token, 'ipfs');
    }
    return imageDecoded;
  }

  static Future<String?> getIPFSUrlFromTokenAddress(
    String address,
  ) async {
    final token = await getTokenByAddress(address);
    if (token == null) {
      return null;
    }
    return getIPFSUrlFromToken(token);
  }

  static Future<String?>? getHTTPUrlFromToken(Token token) async {
    String? imageDecoded;

    if (token.properties.isNotEmpty) {
      imageDecoded = getValueFromKeyInTokenContent(token, 'http_url');
    }
    return imageDecoded;
  }

  static Future<String?> getHTTPUrlFromTokenAddress(
    String address,
  ) async {
    final token = await getTokenByAddress(address);
    if (token == null) {
      return null;
    }
    return getHTTPUrlFromToken(token);
  }

  static Future<String?>? getAEWEBUrlFromToken(Token token) async {
    String? imageDecoded;

    if (token.properties.isNotEmpty) {
      imageDecoded = getValueFromKeyInTokenContent(token, 'aeweb_url');
    }
    return imageDecoded;
  }

  static Future<String?> getAEWEBUrlFromTokenAddress(
    String address,
  ) async {
    final token = await getTokenByAddress(address);
    if (token == null) {
      return null;
    }
    return getAEWEBUrlFromToken(token);
  }
}
