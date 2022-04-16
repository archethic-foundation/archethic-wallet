/// SPDX-License-Identifier: AGPL-3.0-or-later

class AccountUtil {
  String getShortName(String name) {
    final List<String> splitName = name.split(' ');
    if (splitName.length > 1 &&
        splitName[0].isNotEmpty &&
        splitName[1].isNotEmpty) {
      final String firstChar = splitName[0].substring(0, 1);
      String secondPart = splitName[1].substring(0, 1);
      try {
        if (int.parse(splitName[1]) >= 10) {
          secondPart = splitName[1].substring(0, 2);
        }
      } catch (e) {}
      return firstChar + secondPart;
    } else if (name.length >= 2) {
      return name.substring(0, 2);
    } else {
      return name.substring(0, 1);
    }
  }
}
