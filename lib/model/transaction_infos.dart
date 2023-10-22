/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
// Project imports:
import 'package:flutter_gen/gen_l10n/localizations.dart';

class TransactionInfos {
  TransactionInfos({
    required this.domain,
    required this.titleInfo,
    required this.valueInfo,
  });

  String domain = '';
  String titleInfo = '';
  String valueInfo = '';

  static String getDisplayName(BuildContext context, String label) {
    final localizations = AppLocalizations.of(context)!;
    switch (label) {
      case 'Address':
        return localizations.transactionInfosKeyAddress;
      case 'Amount':
        return localizations.transactionInfosKeyAmount;
      case 'Code':
        return localizations.transactionInfosKeyCode;
      case 'Content':
        return localizations.transactionInfosKeyContent;
      case 'CrossValidationStamps':
        return localizations.transactionInfosKeyCrossValidationStamps;
      case 'Data':
        return localizations.transactionInfosKeyData;
      case 'TokenLedger':
        return localizations.transactionInfosKeyTokenLedger;
      case 'Token':
        return localizations.transactionInfosKeyToken;
      case 'OriginSignature':
        return localizations.transactionInfosKeyOriginSignature;
      case 'PreviousPublicKey':
        return localizations.transactionInfosKeyPreviousPublicKey;
      case 'PreviousSignature':
        return localizations.transactionInfosKeyPreviousSignature;
      case 'ProofOfIntegrity':
        return localizations.transactionInfosKeyProofOfIntegrity;
      case 'ProofOfWork':
        return localizations.transactionInfosKeyProofOfWork;
      case 'Signature':
        return localizations.transactionInfosKeySignature;
      case 'TimeStamp':
        return localizations.transactionInfosKeyTimeStamp;
      case 'To':
        return localizations.transactionInfosKeyTo;
      case 'Type':
        return localizations.transactionInfosKeyType;
      case 'UCOLedger':
        return localizations.transactionInfosKeyUCOLedger;
      case 'ValidationStamp':
        return localizations.transactionInfosKeyValidationStamp;
      case 'Version':
        return localizations.transactionInfosKeyVersion;
      default:
        return '';
    }
  }
}
