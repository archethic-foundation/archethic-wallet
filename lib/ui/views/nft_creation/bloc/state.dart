/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:typed_data';

import 'package:aewallet/domain/models/token_property.dart';
import 'package:aewallet/domain/models/token_property_access.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FileImportType { file, image, camera }

enum NftCreationProcessStep { form, confirmation }

enum NftCreationTab { import, infos, properties, summary }

@freezed
class NftCreationFormState with _$NftCreationFormState {
  const factory NftCreationFormState({
    @Default(NftCreationProcessStep.form)
        NftCreationProcessStep nftCreationProcessStep,
    @Default(0) int currentNftCategoryIndex,
    @Default(0) int indexTab,
    required AsyncValue<double> feeEstimation,
    required AccountBalance accountBalance,
    Map<File, List<String>>? file,
    FileImportType? fileImportType,
    Uint8List? fileDecoded,
    Uint8List? fileDecodedForPreview,
    @Default('') String? fileTypeMime,
    @Default(0) int fileSize,
    @Default('') String name,
    @Default('') String description,
    @Default('') String propertyName,
    @Default('') String propertyValue,
    @Default('') String propertySearch,
    required PropertyAccessRecipient propertyAccessRecipient,
    @Default([]) List<NftCreationFormStateProperty> properties,
    @Default('') String error,
    @Default('') String symbol,
    @Default(1) int initialSupply,
    @Default(false) bool checkPreventUserPublicInfo,
    Transaction? transaction,
  }) = _NftCreationFormState;
  const NftCreationFormState._();

  double get feeEstimationOrZero => feeEstimation.valueOrNull ?? 0;

  bool get isControlsOk => error == '';

  bool get canCreateNFT =>
      feeEstimation.value != null && feeEstimation.value! > 0;

  bool get canAddProperty =>
      propertyName.isNotEmpty && propertyValue.isNotEmpty;

  bool get canAddAccess => propertyAccessRecipient.when(
        publicKey: (publicKey) => publicKey.publicKey.isNotEmpty,
        contact: (contact) => contact.name.isNotEmpty,
        unknownContact: (name) => false,
      );

  bool get canConfirmNFTCreation => checkPreventUserPublicInfo;

  String symbolFees(BuildContext context) => AccountBalance.cryptoCurrencyLabel;

  List<TokenProperty> get propertiesConverted {
    final tokenProperties = <TokenProperty>[];
    for (final property in properties) {
      final tokenPropertyAccessList = <TokenPropertyAccess>[];
      for (final tokenPropertyAccess in property.publicKeys) {
        tokenPropertyAccessList.add(
          TokenPropertyAccess(
            publicKey: tokenPropertyAccess.publicKey!.publicKey,
          ),
        );
      }

      final tokenProperty = TokenProperty(
        propertyName: property.propertyName,
        propertyValue: property.propertyValue,
        publicKeys: tokenPropertyAccessList,
      );
      tokenProperties.add(tokenProperty);
    }
    return tokenProperties;
  }
}

@freezed
class NftCreationFormStateProperty with _$NftCreationFormStateProperty {
  const factory NftCreationFormStateProperty({
    @Default('') String propertyName,
    dynamic propertyValue,
    @Default([]) List<PropertyAccessRecipient> publicKeys,
  }) = _NftCreationFormStateProperty;
  const NftCreationFormStateProperty._();
}

@freezed
class PropertyAccessRecipient with _$PropertyAccessRecipient {
  const PropertyAccessRecipient._();
  const factory PropertyAccessRecipient.publicKey({
    required PublicKey publicKey,
  }) = _PropertyAccessPublicKey;
  const factory PropertyAccessRecipient.contact({
    required Contact contact,
  }) = _PropertyAccessContact;
  const factory PropertyAccessRecipient.unknownContact({
    required String name,
  }) = _PropertyAccessUnknownContact;

  PublicKey? get publicKey => when(
        publicKey: (publicKey) => publicKey,
        contact: (contact) => PublicKey(contact.publicKey),
        unknownContact: (_) => null,
      );

  bool get isPublicKeyValid => (publicKey ?? const PublicKey('')).isValid;
}
