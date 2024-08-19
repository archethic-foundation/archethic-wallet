/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:typed_data';

import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FileImportType { file, image, camera, ipfs, http, aeweb }

enum NftCreationProcessStep { form, confirmation }

enum NftCreationTab { import, infos, properties, summary }

@freezed
class NftCreationFormState with _$NftCreationFormState {
  const factory NftCreationFormState({
    @Default(NftCreationProcessStep.form)
    NftCreationProcessStep nftCreationProcessStep,
    @Default(0) int indexTab,
    required AsyncValue<double> feeEstimation,
    required AccountBalance accountBalance,
    Map<Uint8List, List<String>>? file,
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
    String? fileURL,
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

  bool isFileImportFile() {
    return [FileImportType.file, FileImportType.camera, FileImportType.image]
        .contains(fileImportType);
  }

  bool isFileImportUrl() {
    return [FileImportType.ipfs, FileImportType.http, FileImportType.aeweb]
        .contains(fileImportType);
  }

  bool get canAccessToSummary =>
      (file != null || fileURL != null) && name.isNotEmpty;

  bool get canCreateNFT =>
      feeEstimation.value != null &&
      feeEstimation.value! > 0 &&
      isControlsOk == true;

  bool get canAddProperty =>
      propertyName.isNotEmpty && propertyValue.isNotEmpty;

  bool get canAddAccess => propertyAccessRecipient.when(
        address: (address) => address.address!.isNotEmpty,
        contact: (contact) => contact.format.isNotEmpty,
        unknownContact: (name) => false,
      );

  bool get canConfirmNFTCreation => checkPreventUserPublicInfo;

  String symbolFees(BuildContext context) => AccountBalance.cryptoCurrencyLabel;
}

@freezed
class NftCreationFormStateProperty with _$NftCreationFormStateProperty {
  const factory NftCreationFormStateProperty({
    @Default('') String propertyName,
    dynamic propertyValue,
    @Default([]) List<PropertyAccessRecipient> addresses,
  }) = _NftCreationFormStateProperty;
  const NftCreationFormStateProperty._();
}

@freezed
class PropertyAccessRecipient with _$PropertyAccessRecipient {
  const PropertyAccessRecipient._();
  const factory PropertyAccessRecipient.address({
    required Address address,
  }) = _PropertyAccessAddress;
  const factory PropertyAccessRecipient.contact({
    required Contact contact,
  }) = _PropertyAccessContact;
  const factory PropertyAccessRecipient.unknownContact({
    required String name,
  }) = _PropertyAccessUnknownContact;

  Address? get address => when(
        address: (address) => address,
        contact: (contact) => Address(address: contact.address),
        unknownContact: (_) => null,
      );

  bool get isAddressValid => (address ?? const Address(address: '')).isValid();
}
