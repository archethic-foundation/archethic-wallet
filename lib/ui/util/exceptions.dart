// @dart=2.9

class UIException implements Exception {
  UIException(this.cause);

  String cause;
}
