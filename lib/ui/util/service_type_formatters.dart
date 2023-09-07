/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

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
        return Icons.language_outlined;
      case 'archethicWallet':
        return Icons.wallet_outlined;
      case 'other':
      default:
        return Icons.search_outlined;
    }
  }
}
