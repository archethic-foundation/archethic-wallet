/// SPDX-License-Identifier: AGPL-3.0-or-later
class MimeUtil {
  static List<String> imageTypeMimeImage = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
    'image/bmp'
  ];

  static List<String> pdfTypeMime = ['application/x-pdf', 'application/pdf'];

  static bool isImage(String? typeMime) {
    if (typeMime == null) {
      return false;
    } else {
      return imageTypeMimeImage.contains(typeMime);
    }
  }

  static bool isPdf(String? typeMime) {
    if (typeMime == null) {
      return false;
    } else {
      return pdfTypeMime.contains(typeMime);
    }
  }
}
