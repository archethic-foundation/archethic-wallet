import 'package:mime_dart/mime_dart.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later
class MimeUtil {
  static List<String> imageTypeMimeImage = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
    'image/bmp',
  ];

  static List<String> svgTypeMimeImage = [
    'image/svg+xml',
  ];

  static List<String> pdfTypeMime = [
    'application/x-pdf',
    'application/pdf',
  ];

  static bool isImage(String? typeMime) {
    if (typeMime == null) {
      return false;
    }
    return imageTypeMimeImage.contains(typeMime);
  }

  static bool isSvg(String? typeMime) {
    if (typeMime == null) {
      return false;
    }
    return svgTypeMimeImage.contains(typeMime);
  }

  static bool isPdf(String? typeMime) {
    if (typeMime == null) {
      return false;
    }
    return pdfTypeMime.contains(typeMime);
  }

  static bool isSvgFromExtension(String? url) {
    if (url == null) {
      return false;
    }

    final extensions = Mime.getTypesFromExtension(url.split('.').last);
    if (extensions != null && extensions.isNotEmpty) {
      return isSvg(extensions.first);
    }
    return false;
  }

  static bool isImageFromExtension(String? url) {
    if (url == null) {
      return false;
    }

    final extensions = Mime.getTypesFromExtension(url.split('.').last);
    if (extensions != null && extensions.isNotEmpty) {
      return isImage(extensions.first);
    }
    return false;
  }

  static bool isPdfFromExtension(String? url) {
    if (url == null) {
      return false;
    }

    final extensions = Mime.getTypesFromExtension(url.split('.').last);
    if (extensions != null && extensions.isNotEmpty) {
      return isPdf(extensions.first);
    }
    return false;
  }
}
