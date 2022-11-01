/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart' as path;
import 'package:pdfx/pdfx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _initialNftCreationFormProvider = Provider<NftCreationFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _nftCreationFormProvider =
    NotifierProvider.autoDispose<NftCreationFormNotifier, NftCreationFormState>(
  () {
    return NftCreationFormNotifier();
  },
  dependencies: [
    NftCreationFormProvider.initialNftCreationForm,
    AccountProviders.getSelectedAccount,
    NftCreationFormProvider._repository,
  ],
);

class NftCreationFormNotifier
    extends AutoDisposeNotifier<NftCreationFormState> {
  NftCreationFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  Future<void> _updateFees(
    BuildContext context, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    state = state.copyWith(
      feeEstimation: const AsyncValue.loading(),
    );

    late final double fees;

    try {
      fees = await Future<double>(
        () async {
          if (state.name.isEmpty) {
            return 0; // TODO(Chralu): should we use an error class instead ?
          }

          _calculateFeesTask?.cancel();
          _calculateFeesTask = CancelableTask<double?>(
            task: () => _calculateFees(
              context: context,
              formState: state,
            ),
          );
          final fees = await _calculateFeesTask?.schedule(delay);

          return fees ??
              0; // TODO(Chralu): should we use an error class instead ?
        },
      );
    } on CanceledTask {
      return;
    }

    state = state.copyWith(
      feeEstimation: AsyncValue.data(fees),
      error: '',
    );
    if (state.feeEstimationOrZero >
        state.accountBalance.nativeTokenValue! - fees) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.insufficientBalance.replaceAll(
              '%1',
              state.symbolFees(context),
            ),
      );
    }
  }

  @override
  NftCreationFormState build() => ref.watch(
        NftCreationFormProvider.initialNftCreationForm,
      );

  // TODO(Chralu): That operation should be delayed to avoid to spam backend.
  Future<double?> _calculateFees({
    required BuildContext context,
    required NftCreationFormState formState,
  }) async {
    final selectedAccount = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );

    late Transaction transaction;

    transaction = Transaction.token(
      token: Token(
        accountSelectedName: selectedAccount!.name!,
        name: formState.name,
        symbol: formState.symbol,
        initialSupply: 1,
        seed: formState.seed,
        type: 'non-fungible',
      ),
    );

    final calculateFeesResult = await CalculateFeesUsecase(
      repository: ref.read(NftCreationFormProvider._repository),
    ).run(transaction);

    return calculateFeesResult.valueOrNull;
  }

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

  void setNftCreationProcessStep(
    NftCreationProcessStep nftCreationProcessStep,
  ) {
    state = state.copyWith(
      nftCreationProcessStep: nftCreationProcessStep,
    );
  }

  void changeStateCreateNFTButton(bool nexStateButton) {
    state = state.copyWith(
      canCreateNFT: nexStateButton,
    );
  }

  void addPublicKey(String propertyName, String publicKey) {
    if (publicKey.length < 68 ||
        !archethic.isHex(
          publicKey,
        )) {
      state = state.copyWith(
        canAddAccess: false,
      );
    } else {
      final updatedNftCreationProperties = state.properties.map(
        (property) {
          if (property.propertyName != propertyName) return property;

          return property.copyWith(
            publicKeys: [...property.publicKeys, publicKey],
          );
        },
      ).toList();

      state = state.copyWith(
        canAddAccess: true,
        properties: updatedNftCreationProperties,
      );
    }
  }

  void removeFileProperties() {
    final propertiesToRemove = [...state.properties];
    propertiesToRemove.removeWhere(
      (NftCreationFormStateProperty element) => element.propertyName == 'file',
    );
    propertiesToRemove.removeWhere(
      (NftCreationFormStateProperty element) =>
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
      (NftCreationFormStateProperty element) =>
          element.propertyName == propertyName,
    );
    state = state.copyWith(
      properties: propertiesToRemove,
    );
  }

  void setProperty(String propertyName, String propertyValue) {
    final propertiesToSet = [...state.properties];
    propertiesToSet.removeWhere(
      (element) => element.propertyName == propertyName,
    );
    propertiesToSet.add(
      NftCreationFormStateProperty(
        propertyName: propertyName,
        propertyValue: propertyValue,
      ),
    );
    propertiesToSet.sort((a, b) => a.propertyName.compareTo(b.propertyName));
    state = state.copyWith(
      properties: propertiesToSet,
    );
  }

  void setName(String name) {
    state = state.copyWith(name: name, error: '');
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
      NftCreationFormStateProperty(
        propertyName: 'file',
        propertyValue: file64,
      ),
      NftCreationFormStateProperty(
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

  bool controlName(
    BuildContext context,
  ) {
    if (state.name.isEmpty) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.nftNameEmpty,
      );
      return false;
    }
    return true;
  }

  bool controlFile(
    BuildContext context,
  ) {
    if (state.file == null && state.file!.keys.isEmpty) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.nftAddConfirmationFileEmpty,
      );
      return false;
    }

    if (MimeUtil.isImage(state.fileTypeMime) == false &&
        MimeUtil.isPdf(state.fileTypeMime) == false) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.nftFormatNotSupportedEmpty,
      );
      return false;
    }

    if (state.fileSize > 2500000) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.nftSizeExceed,
      );
      return false;
    }

    return true;
  }

  bool controlAddNFTProperty(
    BuildContext context,
  ) {
    // TODO(reddwarf03): Add control
    /* if (nftCreation.properties.where(element) =>
          element.propertyName!.compareTo(nftPropertyNameController.text)) {
        addNFTPropertyMessage = localizations.nftPropertyExists;
        return false;
      }*/

    return true;
  }

  Future<void> send(BuildContext context) async {
    final transactionRepository = ref.read(NftCreationFormProvider._repository);

    final localizations = AppLocalization.of(context)!;

    final selectedAccount = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );

    late Transaction transaction;

    transaction = Transaction.token(
      token: Token(
        name: state.name,
        symbol: state.symbol,
        initialSupply: 1,
        accountSelectedName: selectedAccount!.name!,
        seed: state.seed,
        type: 'non-fungible',
      ),
    );

    transactionRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            transactionAddress: confirmation.transactionAddress,
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
                response: localizations.insufficientBalance.replaceAll(
                  '%1',
                  state.symbolFees(context),
                ),
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
  static final _repository = Provider<TransactionRepositoryInterface>(
    (ref) {
      final networkSettings = ref
          .watch(
            SettingsProviders.localSettingsRepository,
          )
          .getNetwork();
      return ArchethicTransactionRepository(
        phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
        websocketEndpoint: networkSettings.getWebsocketUri(),
      );
    },
  );
  static final initialNftCreationForm = _initialNftCreationFormProvider;
  static final nftCreationForm = _nftCreationFormProvider;
}
