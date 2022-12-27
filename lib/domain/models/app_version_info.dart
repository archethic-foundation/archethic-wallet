/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_info.freezed.dart';

/// Represents the app stores informations
@freezed
class AppVersionInfo with _$AppVersionInfo {
  const factory AppVersionInfo({
    required String storeVersion,
    required String storeUrl,
    @Default(false) bool canUpdate,
    TargetPlatform? platform,
  }) = _AppVersionInfo;
  const AppVersionInfo._();
}
