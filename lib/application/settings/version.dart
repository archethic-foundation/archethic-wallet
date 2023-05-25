/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final versionStringProvider =
    FutureProvider.autoDispose.family<String, AppLocalizations>(
  (ref, localizations) async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!kIsWeb && Platform.isWindows) {
      // TODO(reddwarf03): Not optimal but ok for the moment
      return '${localizations.version} 2.1.0';
    } else {
      return '${localizations.version} ${packageInfo.version} - ${localizations.build} ${packageInfo.buildNumber}';
    }
  },
);
