/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:flutter/material.dart';

class ShowSendingAnimation {
  static void build(BuildContext context, BaseTheme theme, {String? title}) {
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        theme.animationOverlayStrong!,
        title: title,
      ),
    );
  }
}
