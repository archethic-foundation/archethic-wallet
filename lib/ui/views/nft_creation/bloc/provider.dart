/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aewallet/ui/views/nft_creation/bloc/model.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart' as path;
import 'package:pdfx/pdfx.dart';

final _nftCreationProvider =
    StateNotifierProvider<NftCreationNotifier, NftCreation>((ref) {
  return NftCreationNotifier(const NftCreation());
});

class NftCreationNotifier extends StateNotifier<NftCreation> {
  NftCreationNotifier(
    super.state,
  );

  void canAddProperty(String propertyName, String propertyValue) {
    if (propertyName.isNotEmpty && propertyValue.isNotEmpty) {
      state = state.copyWith(
        canAddProperty: true,
      );
    } else {
      state = state.copyWith(
        canAddProperty: false,
      );
    }
  }

  void canCreateNFT() {
    if (state.name.isNotEmpty && state.file != null) {
      state = state.copyWith(
        canCreateNFT: true,
      );
    }
    state = state.copyWith(
      canCreateNFT: false,
    );
  }

  void changeStateCreateNFTButton(bool nexStateButton) {
    state = state.copyWith(
      canCreateNFT: nexStateButton,
    );
  }

  void addPublicKey(String propertyName, String publicKey) {
    if (publicKey.length < 68 ||
        !isHex(
          publicKey,
        )) {
      state = state.copyWith(
        canAddAccess: false,
      );
    } else {
      for (final element in state.properties) {
        if (element.propertyName == propertyName) {
          final publicKeys = [...element.publicKeys, publicKey];
          element.copyWith(publicKeys: publicKeys);
        }
      }
      state = state.copyWith(
        canAddAccess: true,
      );
    }
  }

  void removeFileProperties() {
    final propertiesToRemove = [...state.properties];
    propertiesToRemove.removeWhere(
      (NftCreationProperty element) => element.propertyName == 'file',
    );
    propertiesToRemove.removeWhere(
      (NftCreationProperty element) => element.propertyName == 'type/mime',
    );

    state = state.copyWith(
      fileImportType: null,
      fileSize: null,
      fileDecodedForPreview: null,
      file: null,
      properties: propertiesToRemove,
    );
  }

  void removeProperty(String propertyName) {
    final propertiesToRemove = [...state.properties];
    propertiesToRemove.removeWhere(
      (NftCreationProperty element) => element.propertyName == propertyName,
    );
    state = state.copyWith(
      properties: propertiesToRemove,
    );
  }

  void setProperty(String propertyName, String propertyValue) {
    final propertiesToSet = [
      ...state.properties,
      NftCreationProperty(
        propertyName: propertyName,
        propertyValue: propertyValue,
      ),
    ];
    propertiesToSet.sort((a, b) => a.propertyName.compareTo(b.propertyName));
    state = state.copyWith(
      properties: propertiesToSet,
    );
  }

  void setName(String name) {
    state = state.copyWith(name: name);
    setProperty('name', name);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
    setProperty('description', description);
  }

  Future<void> setFileProperties(
    File file,
    FileImportTypeEnum fileImportType,
  ) async {
    final fileDecoded = File(file.path).readAsBytesSync();
    final file64 = base64Encode(fileDecoded);
    final typeMime = Mime.getTypesFromExtension(
      path.extension(file.path).replaceAll('.', ''),
    )![0];

    Uint8List? fileDecodedForPreview;
    if (MimeUtil.isImage(typeMime) == true) {
      fileDecodedForPreview = fileDecoded;

      // TODO(reddwarf03): Change the exif addition in the ui
      /*final data = await readExifFromBytes(fileDecoded!);

      for (final entry in data.entries) {
        tokenPropertyWithAccessInfosList.add(TokenPropertyWithAccessInfos(
            tokenProperty:
                TokenProperty(name: entry.key, value: entry.value.printable)));
        tokenPropertyWithAccessInfosList.sort(
            (TokenPropertyWithAccessInfos a, TokenPropertyWithAccessInfos b) =>
                a.tokenProperty!.name!
                    .toLowerCase()
                    .compareTo(b.tokenProperty!.name!.toLowerCase()));
      }*/

    } else {
      if (MimeUtil.isPdf(typeMime) == true) {
        final pdfDocument = await PdfDocument.openData(
          File(file.path).readAsBytesSync(),
        );
        final pdfPage = await pdfDocument.getPage(1);
        final pdfPageImage =
            await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
        fileDecodedForPreview = pdfPageImage!.bytes;
      }
    }

    final newPropertiesToSet = [
      ...state.properties,
      NftCreationProperty(
        propertyName: 'file',
        propertyValue: file64,
      ),
      NftCreationProperty(
        propertyName: 'type/mime',
        propertyValue: typeMime,
      ),
    ];

    state = state.copyWith(
      fileImportType: fileImportType,
      fileSize: fileDecoded.length,
      fileTypeMime: typeMime,
      fileDecodedForPreview: fileDecodedForPreview,
      file: {file: List<String>.empty(growable: true)},
      properties: newPropertiesToSet,
    );
  }
}

abstract class NftCreationProvider {
  static final nftCreation = _nftCreationProvider;
}
