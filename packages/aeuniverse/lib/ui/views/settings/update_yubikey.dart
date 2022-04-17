/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/ui/views/settings/set_yubikey.dart';
import 'package:core/localization.dart';
import 'package:core/util/vault.dart';

class UpdateYubikey extends StatefulWidget {
  const UpdateYubikey({Key? key}) : super(key: key);
  @override
  _UpdateYubikeyState createState() => _UpdateYubikeyState();
}

class _UpdateYubikeyState extends State<UpdateYubikey> {
  String header = '';
  String description = '';
  String? apiKey;
  String? clientID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getInfo(context),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return SetYubikey(
            header: header,
            description: description,
            apiKey: apiKey,
            clientID: clientID,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<bool> getInfo(BuildContext context) async {
    Vault vault = await Vault.getInstance();
    if (vault.getYubikeyClientAPIKey().isNotEmpty &&
        vault.getYubikeyClientID().isNotEmpty) {
      header = AppLocalization.of(context)!.seYubicloudConfirmHeader;
      description = AppLocalization.of(context)!.seYubicloudDescription;
      apiKey = vault.getYubikeyClientAPIKey();
      clientID = vault.getYubikeyClientID();
    } else {
      header = AppLocalization.of(context)!.seYubicloudHeader;
      description = AppLocalization.of(context)!.seYubicloudDescription;
    }
    return true;
  }
}
