/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:typed_data';

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FileImportType { file, image, camera }

enum NftCreationProcessStep { form, confirmation }

@freezed
class NftCreationFormState with _$NftCreationFormState {
  const factory NftCreationFormState({
    required String seed,
    @Default(NftCreationProcessStep.form)
        NftCreationProcessStep nftCreationProcessStep,
    @Default(0) int currentNftCategoryIndex,
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
    @Default([]) List<NftCreationFormStateProperty> properties,
    @Default(false) bool canAddProperty,
    @Default(false) bool canAddAccess,
    @Default('') String error,
    @Default('') String symbol,
    Transaction? transaction,
  }) = _NftCreationFormState;
  const NftCreationFormState._();

  double get feeEstimationOrZero => feeEstimation.valueOrNull ?? 0;

  bool get isControlsOk => error == '';

  bool get canCreateNFT =>
      feeEstimation.value != null && feeEstimation.value! > 0;

  String symbolFees(BuildContext context) =>
      StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel();
}

@freezed
class NftCreationFormStateProperty with _$NftCreationFormStateProperty {
  const factory NftCreationFormStateProperty({
    @Default('') String propertyName,
    @Default('') String propertyValue,
    @Default([]) List<String> publicKeys,
  }) = _NftCreationFormStateProperty;
  const NftCreationFormStateProperty._();
}
