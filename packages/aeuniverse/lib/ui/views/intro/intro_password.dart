/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';

// Project imports:
import 'package:aeuniverse/ui/views/settings/set_password.dart';

class IntroPassword extends StatefulWidget {
  const IntroPassword({super.key});
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
    );
  }
}
