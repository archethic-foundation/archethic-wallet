/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';

class UpdatePassword extends StatefulWidget {
  final String name;
  final String seed;

  const UpdatePassword({super.key, this.name = '', this.seed = ''});
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    return SetPassword(
        header: AppLocalization.of(context)!.configureSecurityIntro,
        description:
            AppLocalization.of(context)!.configureSecurityExplanationPassword,
        initPreferences: false,
        name: widget.name,
        seed: widget.seed);
  }
}
