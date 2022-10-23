/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/model.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/transaction_builder.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart' as path;
import 'package:pdfx/pdfx.dart';

final _initialNftCreationFormProvider =
    Provider.autoDispose<NftCreationFormData>(
  (ref) {
    throw UnimplementedError();
  },
);

final _nftCreationFormProvider =
    StateNotifierProvider.autoDispose<NftCreationNotifier, NftCreationFormData>(
  (ref) {
    final initialNftCreationForm =
        ref.watch(NftCreationFormProvider.initialNftCreationForm);
    return NftCreationNotifier(initialNftCreationForm);
  },
  dependencies: [NftCreationFormProvider.initialNftCreationForm],
);

class NftCreationNotifier extends StateNotifier<NftCreationFormData> {
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
      (NftCreationFormDataProperty element) => element.propertyName == 'file',
    );
    propertiesToRemove.removeWhere(
      (NftCreationFormDataProperty element) =>
          element.propertyName == 'type/mime',
    );

    state = state.copyWith(
      fileImportType: null,
      fileSize: 0,
      fileDecodedForPreview: null,
      file: null,
      properties: propertiesToRemove,
    );
  }

  void removeProperty(String propertyName) {
    final propertiesToRemove = [...state.properties];
    propertiesToRemove.removeWhere(
      (NftCreationFormDataProperty element) =>
          element.propertyName == propertyName,
    );
    state = state.copyWith(
      properties: propertiesToRemove,
    );
  }

  void setProperty(String propertyName, String propertyValue) {
    final propertiesToSet = [
      ...state.properties,
      NftCreationFormDataProperty(
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
    FileImportType fileImportType,
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
      NftCreationFormDataProperty(
        propertyName: 'file',
        propertyValue: file64,
      ),
      NftCreationFormDataProperty(
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

  Future<void> buildTransaction(
    String seed,
    String accountSelectedName,
  ) async {
    final originPrivateKey = sl.get<ApiService>().getOriginKey();
    final keychain = await sl.get<ApiService>().getKeychain(seed);

    final nameEncoded = Uri.encodeFull(
      accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(
                keychain.deriveAddress(
                  service,
                ),
              ),
            ))
        .chainLength!;

    var tokenProperties = <String, dynamic>{};
    for (final element in state.properties) {
      tokenProperties = {element.propertyName: element.propertyValue};
    }

    final transaction = NftTransactionBuilder.build(
      tokenInitialSupply: 1,
      tokenName: state.name,
      tokenSymbol: state.symbol,
      tokenProperties: tokenProperties,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
    );
    state = state.copyWith(
      transaction: transaction,
    );
  }

  Future<void> send(BuildContext context) async {
    final localizations = AppLocalization.of(context)!;

    final preferences = await Preferences.getInstance();

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: await preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: await preferences.getNetwork().getWebsocketUri(),
    );

    transactionSender.send(
      transaction: state.transaction!,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            transactionAddress: state.transaction!.address,
            maxConfirmations: confirmation.maxConfirmations,
          ),
        );
      },
      onError: (error) async {
        error.maybeMap(
          connectivity: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          insufficientFunds: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.insufficientBalance
                    .replaceAll('%1', state.symbol),
                nbConfirmations: 0,
              ),
            );
          },
          other: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.keychainNotExistWarning,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: '',
                nbConfirmations: 0,
              ),
            );
          },
        );
      },
    );
  }
}

abstract class NftCreationFormProvider {
  static final initialNftCreationForm = _initialNftCreationFormProvider;
  static final nftCreationForm = _nftCreationFormProvider;
}
