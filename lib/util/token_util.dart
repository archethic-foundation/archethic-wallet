/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:pdfx/pdfx.dart';

// Project imports:
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/mime_util.dart';

RegExp _base64 = RegExp(
  r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$',
);

class TokenUtil {
  static Future<Uint8List?> getImageFromTokenAddress(
    String address,
    String typeMime,
  ) async {
    Uint8List? valueFileDecoded;
    Uint8List? imageDecoded;
    final Token token =
        await sl.get<ApiService>().getToken(address, request: 'properties');
    if (token.tokenProperties != null && token.tokenProperties!.isNotEmpty) {
      final Map<String, dynamic> list = token.tokenProperties!;
      list.forEach((key, value) {
        if (key == 'file') {
          if (_base64.hasMatch(value) == true) {
            valueFileDecoded = base64Decode(value);
          }
        }
      });
    }

    if (valueFileDecoded != null) {
      if (MimeUtil.isPdf(typeMime) == true) {
        final PdfDocument pdfDocument = await PdfDocument.openData(
          valueFileDecoded!,
        );
        final PdfPage pdfPage = await pdfDocument.getPage(1);

        final PdfPageImage? pdfPageImage =
            await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
        imageDecoded = pdfPageImage!.bytes;
      } else {
        imageDecoded = valueFileDecoded;
      }
    }
    return imageDecoded;
  }

  static String getPropertyValue(
    TokenInformations tokenInformations,
    String nameProperty,
  ) {
    String value = '';
    if (tokenInformations.tokenProperties != null &&
        tokenInformations.tokenProperties!
                .firstWhereOrNull((element) => element.name == nameProperty) !=
            null) {
      value = tokenInformations.tokenProperties!
          .where((element) => element.name == nameProperty)
          .first
          .value!;
    }
    return value;
  }
}
