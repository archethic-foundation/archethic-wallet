/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FileImportType { file, image, camera }

@freezed
class NftCreationFormState with _$NftCreationFormState {
  const factory NftCreationFormState({
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
    @Default(false) bool canCreateNFT,
    @Default(false) bool canAddAccess,
    @Default('') String symbol,
    Transaction? transaction,
  }) = _NftCreationFormState;
  const NftCreationFormState._();
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
