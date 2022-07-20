/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/util/vault.dart';

// Project imports:
import 'package:aeuniverse/ui/views/settings/set_yubikey.dart';

class UpdateYubikey extends StatefulWidget {
  final String name;
  final String seed;

  const UpdateYubikey({super.key, this.name = '', this.seed = ''});
  @override
  State<UpdateYubikey> createState() => _UpdateYubikeyState();
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
              initPreferences: false,
              name: widget.name,
              seed: widget.seed);
        } else {
          return const Center(child: const CircularProgressIndicator());
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
