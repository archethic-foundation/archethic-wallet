/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Address;

mixin UrlUtil {
  static bool isUrlValid(
    String uri,
  ) {
    return convertUri(uri).isAbsolute == true;
  }

  static bool isUrlIPFS(
    String uri,
  ) {
    return isUrlValid(uri) && convertUri(uri).isScheme('ipfs');
  }

  static String convertUrlIPFSForWeb(
    String uri,
  ) {
    return uri.replaceAll('ipfs://', 'https://ipfs.io/ipfs/');
  }

  static bool isUrlAEWeb(
    String uri,
  ) {
    final splitedUrl = uri.split('/');

    if (splitedUrl.length < 2) return false;

    final address = splitedUrl[0];

    if (address.isEmpty) return false;

    if (!Address(address: address).isValid()) {
      return false;
    }

    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];

    for (final extension in allowedExtensions) {
      if (splitedUrl.last.toLowerCase().endsWith(extension)) {
        return true;
      }
    }

    return false;
  }

  static Uri convertUri(
    String uri,
  ) {
    // Uri seem to accept whitespace. So I need to remove bad formated Uri.
    return Uri.parse(uri.replaceAll(' ', ''));
  }
}
