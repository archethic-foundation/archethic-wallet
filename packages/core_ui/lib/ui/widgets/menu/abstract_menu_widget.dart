/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

abstract class AbstractMenuWidget {
  Widget buildMainMenuIcons(BuildContext context);

  Widget buildSecondMenuIcons(BuildContext context);

  Widget buildContextMenu(BuildContext context);
}
