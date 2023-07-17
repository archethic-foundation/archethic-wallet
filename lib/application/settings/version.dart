/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/util/version_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final versionStringProvider =
    FutureProvider.autoDispose.family<String, AppLocalizations>(
  (ref, localizations) async {
    final version = await VersionManager.getCurrentVersion();
    if (!kIsWeb && Platform.isWindows) {
      // TODO(reddwarf03): Not optimal but ok for the moment
      return '${localizations.version} 2.1.1';
    } else {
      return '${localizations.version} ${version.$1} - ${localizations.build} ${version.$2}';
    }
  },
);
