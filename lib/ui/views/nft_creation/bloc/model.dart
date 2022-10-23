/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

enum FileImportType { file, image, camera }

@freezed
class NftCreationFormData with _$NftCreationFormData {
  const factory NftCreationFormData({
    Map<File, List<String>>? file,
    FileImportType? fileImportType,
    Uint8List? fileDecoded,
    Uint8List? fileDecodedForPreview,
    @Default('') String? fileTypeMime,
    @Default(0) int fileSize,
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<NftCreationFormDataProperty> properties,
    @Default(false) bool canAddProperty,
    @Default(false) bool canCreateNFT,
    @Default(false) bool canAddAccess,
    @Default('') String symbol,
    Transaction? transaction,
  }) = _NftCreationFormData;
  const NftCreationFormData._();
}

@freezed
class NftCreationFormDataProperty with _$NftCreationFormDataProperty {
  const factory NftCreationFormDataProperty({
    @Default('') String propertyName,
    @Default('') String propertyValue,
    @Default([]) List<String> publicKeys,
  }) = _NftCreationFormDataProperty;
  const NftCreationFormDataProperty._();
}
