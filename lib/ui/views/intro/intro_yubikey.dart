/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';

class IntroYubikey extends StatefulWidget {
  final String? name;
  final String? seed;
  final String? process;

  const IntroYubikey(
      {super.key, this.name = '', this.seed = '', this.process = ''});
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
        seed: widget.seed,
        process: widget.process);
  }
}
