/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

enum FileImportTypeEnum { file, image, camera }

@freezed
class NftCreation with _$NftCreation {
  const factory NftCreation({
    Map<File, List<String>>? file,
    FileImportTypeEnum? fileImportType,
    Uint8List? fileDecoded,
    Uint8List? fileDecodedForPreview,
    String? fileTypeMime,
    int? fileSize,
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<NftCreationProperty> properties,
    @Default(false) bool canAddProperty,
    @Default(false) bool canCreateNFT,
    @Default(false) bool canAddAccess,
    Transaction? transaction,
  }) = _NftCreation;
  const NftCreation._();
}

@freezed
class NftCreationProperty with _$NftCreationProperty {
  const factory NftCreationProperty({
    @Default('') String propertyName,
    @Default('') String propertyValue,
    @Default([]) List<String> publicKeys,
  }) = _NftCreationProperty;
  const NftCreationProperty._();
}
