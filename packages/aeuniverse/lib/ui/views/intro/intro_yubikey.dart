/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';

// Project imports:
import 'package:aeuniverse/ui/views/settings/set_yubikey.dart';

class IntroYubikey extends StatefulWidget {
  final String? name;
  final String? seed;

  const IntroYubikey({super.key, this.name = '', this.seed = ''});
  @override
  State<IntroYubikey> createState() => _IntroYubikeyState();
}

class _IntroYubikeyState extends State<IntroYubikey> {
  @override
  Widget build(BuildContext context) {
    return SetYubikey(
        header: AppLocalization.of(context)!.seYubicloudHeader,
        description: AppLocalization.of(context)!.seYubicloudDescription,
        initPreferences: true,
        name: widget.name,
        seed: widget.seed);
  }
}
