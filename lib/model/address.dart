/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show addressFormatControl;

// Object to represent an account address or address URI,
// and provide useful utilities
class Address {
  const Address(this._address);

  final String _address;

  String get address => _address;

  String getAddressUpperCased() {
    return _address.toUpperCase();
  }

  String getShortString() {
    final addressUpperCased = getAddressUpperCased();
    if (_address.length < 21) {
      return addressUpperCased;
    } else {
      return '${addressUpperCased.substring(0, 11)}...${addressUpperCased.substring(_address.length - 6)}';
    }
  }

  String getShortString2() {
    final addressUpperCased = getAddressUpperCased();
    if (_address.length < 21) {
      return addressUpperCased;
    } else {
      return '${addressUpperCased.substring(0, 18)}...${addressUpperCased.substring(_address.length - 6)}';
    }
  }

  String getShortString3() {
    final addressUpperCased = getAddressUpperCased();
    if (_address.length < 27) {
      return addressUpperCased;
    } else {
      return '${addressUpperCased.substring(0, 12)}...${addressUpperCased.substring(_address.length - 12)}';
    }
  }

  String getShortString4() {
    final addressUpperCased = getAddressUpperCased();
    if (_address.length < 21) {
      return addressUpperCased;
    } else {
      return '${addressUpperCased.substring(0, 11)}...${addressUpperCased.substring(_address.length - 2)}';
    }
  }

  bool get isValid {
    return addressFormatControl(_address);
  }
}
