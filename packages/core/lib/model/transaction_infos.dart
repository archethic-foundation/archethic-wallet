/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';

class TransactionInfos {
  TransactionInfos(
      {required this.domain, required this.titleInfo, required this.valueInfo});

  String domain = '';
  String titleInfo = '';
  String valueInfo = '';

  static String getDisplayName(BuildContext context, String label) {
    switch (label) {
      case 'Address':
        return AppLocalization.of(context)!.transactionInfosKeyAddress;
      case 'Amount':
        return AppLocalization.of(context)!.transactionInfosKeyAmount;
      case 'Code':
        return AppLocalization.of(context)!.transactionInfosKeyCode;
      case 'Content':
        return AppLocalization.of(context)!.transactionInfosKeyContent;
      case 'CrossValidationStamps':
        return AppLocalization.of(context)!
            .transactionInfosKeyCrossValidationStamps;
      case 'Data':
        return AppLocalization.of(context)!.transactionInfosKeyData;
      case 'NFTLedger':
        return AppLocalization.of(context)!.transactionInfosKeyNFTLedger;
      case 'Nft':
        return AppLocalization.of(context)!.transactionInfosKeyNft;
      case 'OriginSignature':
        return AppLocalization.of(context)!.transactionInfosKeyOriginSignature;
      case 'PreviousPublicKey':
        return AppLocalization.of(context)!
            .transactionInfosKeyPreviousPublicKey;
      case 'PreviousSignature':
        return AppLocalization.of(context)!
            .transactionInfosKeyPreviousSignature;
      case 'ProofOfIntegrity':
        return AppLocalization.of(context)!.transactionInfosKeyProofOfIntegrity;
      case 'ProofOfWork':
        return AppLocalization.of(context)!.transactionInfosKeyProofOfWork;
      case 'Signature':
        return AppLocalization.of(context)!.transactionInfosKeySignature;
      case 'TimeStamp':
        return AppLocalization.of(context)!.transactionInfosKeyTimeStamp;
      case 'To':
        return AppLocalization.of(context)!.transactionInfosKeyTo;
      case 'Type':
        return AppLocalization.of(context)!.transactionInfosKeyType;
      case 'UCOLedger':
        return AppLocalization.of(context)!.transactionInfosKeyUCOLedger;
      case 'ValidationStamp':
        return AppLocalization.of(context)!.transactionInfosKeyValidationStamp;
      case 'Version':
        return AppLocalization.of(context)!.transactionInfosKeyVersion;
      default:
        return '';
    }
  }
}
