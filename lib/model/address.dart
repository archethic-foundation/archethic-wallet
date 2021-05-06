import 'dart:core';

// Object to represent an account address or address URI, and provide useful utilities
class Address {
  String? _address;
  String? _amount;

  Address(String value) {
    _address = value;
  }

  String get address => _address!;

  String get amount => _amount!;

  String getShortString() {
    if (_address == null) return "";
    if (_address!.length < 21) {
      return _address!;
    } else {
      return _address!.substring(0, 11) +
          "..." +
          _address!.substring(_address!.length - 6);
    }
  }

  String getShortString2() {
    if (_address == null) return "";
    if (_address!.length < 21) {
      return _address!;
    } else {
      return _address!.substring(0, 18) +
          "..." +
          _address!.substring(_address!.length - 6);
    }
  }

  String getShorterString() {
    if (_address == null) return "";
    if (_address!.length < 21) {
      return _address!;
    } else {
      return _address!.substring(0, 9) +
          "..." +
          _address!.substring(_address!.length - 4);
    }
  }

  bool isValid() {
    return _address == null ? false : true;
  }
}
