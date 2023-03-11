/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceTypeFormatters {
  const ServiceTypeFormatters(this._serviceType);

  final String _serviceType;

  String get serviceType => _serviceType;

  String getLabel(BuildContext context) {
    final localizations = AppLocalization.of(context)!;

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
        return FontAwesomeIcons.globe;
      case 'archethicWallet':
        return Icons.account_balance_wallet_outlined;
      case 'other':
      default:
        return Icons.help_center_outlined;
    }
  }
}
