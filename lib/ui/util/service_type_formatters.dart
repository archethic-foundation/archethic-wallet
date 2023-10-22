/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

class ServiceTypeFormatters {
  const ServiceTypeFormatters(this._serviceType);

  final String _serviceType;

  String get serviceType => _serviceType;

  String getLabel(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (serviceType) {
      case 'aeweb':
        return localizations.serviceTypeLabelAeweb;
      case 'archethicWallet':
        return localizations.serviceTypeLabelArchethicWallet;
      case 'other':
      default:
        return localizations.serviceTypeLabelOther;
    }
  }

  IconData getIcon() {
    switch (_serviceType) {
      case 'aeweb':
        return Symbols.language;
      case 'archethicWallet':
        return Symbols.account_balance_wallet;
      case 'other':
      default:
        return Symbols.search;
    }
  }
}
