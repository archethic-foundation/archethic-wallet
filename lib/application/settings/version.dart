/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/version_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final versionStringProvider =
    FutureProvider.autoDispose.family<String, AppLocalizations>(
  (ref, localizations) async {
    final currentVersion = await CurrentVersionRepository().getCurrentVersion();
    if (!kIsWeb && Platform.isWindows) {
      // TODO(reddwarf03): Not optimal but ok for the moment
      return '${localizations.version} 2.1.1';
    } else {
      return '${localizations.version} ${currentVersion.$1} - ${localizations.build} ${currentVersion.$2}';
    }
  },
);
