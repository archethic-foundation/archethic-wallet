// Flutter imports:
import 'package:aeuniverse/ui/views/intro/set_yubikey.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';

class UpdateYubikey extends StatefulWidget {
  const UpdateYubikey({Key? key}) : super(key: key);
  @override
  _UpdateYubikeyState createState() => _UpdateYubikeyState();
}

class _UpdateYubikeyState extends State<UpdateYubikey> {
  @override
  Widget build(BuildContext context) {
    return SetYubikey(
        header: AppLocalization.of(context)!.seYubicloudHeader,
        description: AppLocalization.of(context)!.seYubicloudDescription);
  }
}
