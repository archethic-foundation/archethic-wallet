/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dapps.freezed.dart';
part 'dapps.g.dart';

@freezed
class DApps with _$DApps {
  const factory DApps({
    required String code,
    required String url,
    String? accessToken,
  }) = _DApps;

  factory DApps.fromJson(Map<String, dynamic> json) => _$DAppsFromJson(json);
}
