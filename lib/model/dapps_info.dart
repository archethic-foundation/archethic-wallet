/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dapps_info.freezed.dart';

@freezed
class DAppsInfo with _$DAppsInfo {
  const factory DAppsInfo({
    String? dAppName,
    String? dAppDesc,
    String? dAppLink,
    String? dAppBackgroundImgCard,
  }) = _DAppsInfo;
  const DAppsInfo._();
}
