/// SPDX-License-Identifier: AGPL-3.0-or-later

abstract class FarmAPRRepositoryInterface {
  Future<Map<String, String>> fetchAPRFarm();
}
