/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:pdfx/pdfx.dart';

class TokenUtil {
  static Future<Uint8List?> getImageFromTokenAddress(
    String address,
    String typeMime,
  ) async {
    Uint8List? valueFileDecoded;
    Uint8List? imageDecoded;
    final tokenMap =
        await sl.get<ApiService>().getToken([address], request: 'properties');
    if (tokenMap.isEmpty) {
      return Uint8List.fromList([]);
    }
    final token = tokenMap[address]!;
    if (token.tokenProperties != null && token.tokenProperties!.isNotEmpty) {
      token.tokenProperties!.forEach((key, value) {
        if (key == 'file') {
          valueFileDecoded = base64Decode(value);
        }
      });
    }

    if (valueFileDecoded != null) {
      if (MimeUtil.isPdf(typeMime) == true) {
        final pdfDocument = await PdfDocument.openData(
          valueFileDecoded!,
        );
        final pdfPage = await pdfDocument.getPage(1);

        final pdfPageImage =
            await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
        imageDecoded = pdfPageImage!.bytes;
      } else {
        imageDecoded = valueFileDecoded;
      }
    }
    return imageDecoded;
  }
}
