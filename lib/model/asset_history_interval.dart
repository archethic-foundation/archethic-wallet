/// SPDX-License-Identifier: AGPL-3.0-or-later

class AssetHistoryInterval {
  AssetHistoryInterval({
    required this.price,
    required this.time,
  });
  num price;
  DateTime time;
}
