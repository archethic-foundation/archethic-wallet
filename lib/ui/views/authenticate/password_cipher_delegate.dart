import 'dart:async';
import 'dart:typed_data';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/set_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:go_router/go_router.dart';

class PasswordCipherDelegate implements VaultCipherDelegate {
  PasswordCipherDelegate(this.context);

  BuildContext context;

  @override
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable) =>
      PasswordAuthScreenOverlay(
        canNavigateBack: userCancelable,
        challenge: payload,
      ).show(context);

  @override
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable) {
    final localizations = AppLocalizations.of(context)!;
    return context.push<Uint8List>(
      SetPassword.routerPage,
      extra: {
        'header': localizations.setPasswordHeader,
        'description': localizations.configureSecurityExplanationPassword,
        'challenge': payload,
      },
    );
  }
}
