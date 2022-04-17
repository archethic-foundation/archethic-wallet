/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/ui/views/settings/set_password.dart';
import 'package:core/localization.dart';

class IntroPassword extends StatefulWidget {
  const IntroPassword({Key? key}) : super(key: key);
  @override
  _IntroPasswordState createState() => _IntroPasswordState();
}

class _IntroPasswordState extends State<IntroPassword> {
  @override
  Widget build(BuildContext context) {
    return SetPassword(
        header: AppLocalization.of(context)!.setPasswordHeader,
        description: AppLocalization.of(context)!.setPasswordDescription);
  }
}
