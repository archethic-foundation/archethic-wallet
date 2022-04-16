/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

/// Models that are used in settings dialogs/dropdowns
abstract class SettingSelectionItem {
  String getDisplayName(BuildContext context);
}
