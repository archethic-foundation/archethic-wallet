/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/ui/views/settings/set_password.dart';
import 'package:core/localization.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    return SetPassword(
        header: AppLocalization.of(context)!.configureSecurityIntro,
        description:
            AppLocalization.of(context)!.configureSecurityExplanationPassword);
  }
}
