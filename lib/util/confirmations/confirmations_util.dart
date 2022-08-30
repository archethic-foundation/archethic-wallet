/// SPDX-License-Identifier: AGPL-3.0-or-later

class ConfirmationsUtil {
  static bool isEnoughConfirmations(int nbConfirmations, int maxConfirmations) {
    /*if (maxConfirmations == 0 && nbConfirmations == 0) {
      return false;
    } else {
      if (maxConfirmations == 0 && nbConfirmations > 0) {
        return true;
      } else {
        if (nbConfirmations > 0 && maxConfirmations <= 3) {
          if (nbConfirmations > 0 && maxConfirmations <= 3) {
          return true;
        } else {
          if ((maxConfirmations / 3).ceil() <= nbConfirmations) {
            return true;
          } else {
            return false;
          }
        }
      }
    }
  }*/
    if (nbConfirmations > 0) {
      return true;
    } else {
      return false;
    }
  }
}
