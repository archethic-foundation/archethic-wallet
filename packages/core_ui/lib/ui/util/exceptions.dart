/// SPDX-License-Identifier: AGPL-3.0-or-later

class UIException implements Exception {
  UIException(this.cause);

  String cause;
}
