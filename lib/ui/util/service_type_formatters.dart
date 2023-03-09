/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceTypeFormatters {
  const ServiceTypeFormatters(this._serviceType);

  final ServiceType _serviceType;

  ServiceType get serviceType => _serviceType;

  String getLabel(BuildContext context) {
    final localizations = AppLocalization.of(context)!;

    switch (_serviceType) {
      case ServiceType.aeweb:
        return localizations.serviceTypeLabelAeweb;
      case ServiceType.archethicWallet:
        return localizations.serviceTypeLabelArchethicWallet;
      case ServiceType.other:
        return localizations.serviceTypeLabelOther;
    }
  }

  IconData getIcon() {
    switch (_serviceType) {
      case ServiceType.aeweb:
        return FontAwesomeIcons.globe;
      case ServiceType.archethicWallet:
        return Icons.account_balance_wallet_outlined;
      case ServiceType.other:
        return Icons.help_center_outlined;
    }
  }
}
