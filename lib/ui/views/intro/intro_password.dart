/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';

class IntroPassword extends StatefulWidget {
  final String name;
  final String seed;
  final String process;

  const IntroPassword(
      {super.key, this.name = '', this.seed = '', this.process = ''});
  @override
  State<IntroPassword> createState() => _IntroPasswordState();
}

class _IntroPasswordState extends State<IntroPassword> {
  @override
  Widget build(BuildContext context) {
    return SetPassword(
      header: AppLocalization.of(context)!.setPasswordHeader,
      description:
          AppLocalization.of(context)!.configureSecurityExplanationPassword,
      initPreferences: true,
      name: widget.name,
      seed: widget.seed,
      process: widget.process,
    );
  }
}
