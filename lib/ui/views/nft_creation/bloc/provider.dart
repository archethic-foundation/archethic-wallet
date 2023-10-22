/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

final _nftCreationFormProviderArgs = Provider<NftCreationFormNotifierParams>(
  (ref) {
    throw UnimplementedError();
  },
);

final _nftCreationFormProvider = NotifierProvider.family<
    NftCreationFormNotifier,
    NftCreationFormState,
    NftCreationFormNotifierParams>(
  () {
    return NftCreationFormNotifier();
  },
  dependencies: [
    AccountProviders.selectedAccount,
    NftCreationFormProvider._repository,
    SessionProviders.session,
  ],
);

class NftCreationFormNotifierParams {
  const NftCreationFormNotifierParams({
    required this.selectedAccount,
    required this.currentNftCategoryIndex,
  });
  final Account selectedAccount;
  final int currentNftCategoryIndex;
}

class NftCreationFormNotifier extends FamilyNotifier<NftCreationFormState,
    NftCreationFormNotifierParams> {
  NftCreationFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  @override
  NftCreationFormState build(NftCreationFormNotifierParams arg) {
    return NftCreationFormState(
      feeEstimation: const AsyncValue.data(0),
      propertyAccessRecipient: const PropertyAccessRecipient.publicKey(
        publicKey: PublicKey(''),
      ),
      accountBalance: arg.selectedAccount.balance!,
      currentNftCategoryIndex: arg.currentNftCategoryIndex,
    );
  }

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
            return 0;
          }

          _calculateFeesTask?.cancel();
          _calculateFeesTask = CancelableTask<double?>(
            task: () => _calculateFees(
              context: context,
              formState: state,
            ),
          );
          final fees = await _calculateFeesTask?.schedule(delay);

          return fees ?? 0;
        },
      );
    } on CanceledTask {
      return;
    }

    state = state.copyWith(
      feeEstimation: AsyncValue.data(fees),
      error: '',
    );
    if (state.feeEstimationOrZero > state.accountBalance.nativeTokenValue) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.insufficientBalance.replaceAll(
              '%1',
              state.symbolFees(context),
            ),
      );
    }
  }

  Future<double?> _calculateFees({
    required BuildContext context,
    required NftCreationFormState formState,
  }) async {
    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    late Transaction transaction;

    final keychainSecuredInfos = ref
        .read(SessionProviders.session)
        .loggedIn!
        .wallet
        .keychainSecuredInfos;

    transaction = Transaction.token(
      token: Token(
        accountSelectedName: selectedAccount!.name,
        name: formState.name,
        symbol: formState.symbol,
        initialSupply: formState.initialSupply.toDouble(),
        keychainSecuredInfos: keychainSecuredInfos,
        transactionLastAddress: selectedAccount.lastAddress!,
        type: 'non-fungible',
        aeip: [2, 9],
        properties: formState.propertiesConverted,
      ),
    );

    final calculateFeesResult = await CalculateFeesUsecase(
      repository: ref.read(NftCreationFormProvider._repository),
    ).run(transaction);

    return calculateFeesResult.valueOrNull;
  }

  void setNftCreationProcessStep(
    NftCreationProcessStep nftCreationProcessStep,
  ) {
    state = state.copyWith(
      nftCreationProcessStep: nftCreationProcessStep,
    );
  }

  void setIndexTab(
    int indexTab,
  ) {
    state = state.copyWith(
      indexTab: indexTab,
    );
  }

  void setCheckPreventUserPublicInfo(
    bool checkPreventUserPublicInfo,
  ) {
    state = state.copyWith(
      checkPreventUserPublicInfo: checkPreventUserPublicInfo,
    );
  }

  Future<void> setFees(
    BuildContext context,
  ) async {
    _updateFees(
      context,
    );
    return;
  }

  void addPublicKey(
    String propertyName,
    PropertyAccessRecipient publicKey,
    BuildContext context,
  ) {
    if (publicKey.isPublicKeyValid == false) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.publicKeyInvalid,
      );
      return;
    }

    var exist = false;
    final updatedNftCreationProperties = state.properties.map(
      (property) {
        if (property.propertyName != propertyName) return property;

        for (final otherPublicKey in property.publicKeys) {
          if (otherPublicKey.publicKey!.publicKey ==
              publicKey.publicKey!.publicKey) {
            exist = true;
          }
        }

        return property.copyWith(
          publicKeys: [...property.publicKeys, publicKey],
        );
      },
    ).toList();

    if (exist) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.publicKeyAccessExists,
      );
      return;
    }

    state = state.copyWith(
      error: '',
      properties: updatedNftCreationProperties,
      propertyAccessRecipient:
          const PropertyAccessRecipient.publicKey(publicKey: PublicKey('')),
    );
  }

  void removePublicKey(String propertyName, String publicKey) {
    final updatedNftCreationProperties = state.properties.map(
      (property) {
        if (property.propertyName != propertyName) return property;

        return property.copyWith(
          publicKeys: [...property.publicKeys]..removeWhere(
              (element) => element.publicKey!.publicKey == publicKey,
            ),
        );
      },
    ).toList();

    state = state.copyWith(
      properties: updatedNftCreationProperties,
      error: '',
    );
  }

  void _setPropertyAccessRecipient({
    required PropertyAccessRecipient recipient,
  }) {
    state = state.copyWith(
      propertyAccessRecipient: recipient,
      error: '',
    );
  }

  Future<void> setPropertyAccessRecipientNameOrPublicKey({
    required BuildContext context,
    required String text,
  }) async {
    if (!text.startsWith('@')) {
      try {
        final contact = await sl.get<DBHelper>().getContactWithPublicKey(
              text,
            );
        _setPropertyAccessRecipient(
          recipient: PropertyAccessRecipient.contact(contact: contact),
        );
      } catch (_) {
        _setPropertyAccessRecipient(
          recipient:
              PropertyAccessRecipient.publicKey(publicKey: PublicKey(text)),
        );
      }

      return;
    }

    try {
      final contact = await sl.get<DBHelper>().getContactWithName(text);
      _setPropertyAccessRecipient(
        recipient: PropertyAccessRecipient.contact(
          contact: contact!,
        ),
      );
    } catch (e) {
      _setPropertyAccessRecipient(
        recipient: PropertyAccessRecipient.unknownContact(
          name: text,
        ),
      );
    }
  }

  Future<void> setPropertyAccessRecipient({
    required BuildContext context,
    required PropertyAccessRecipient contact,
  }) async {
    _setPropertyAccessRecipient(
      recipient: contact,
    );
  }

  Future<void> setContactPublicKey({
    required BuildContext context,
    required PublicKey publicKey,
  }) async {
    try {
      final contact = await sl.get<DBHelper>().getContactWithPublicKey(
            publicKey.publicKey,
          );

      _setPropertyAccessRecipient(
        recipient: PropertyAccessRecipient.contact(contact: contact),
      );
    } catch (_) {
      _setPropertyAccessRecipient(
        recipient: PropertyAccessRecipient.publicKey(
          publicKey: publicKey,
        ),
      );
    }
  }

  void removeContentProperties() {
    final propertiesToRemove = [...state.properties]
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'content',
      )
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'type_mime',
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
    final propertiesToRemove = [...state.properties]..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == propertyName,
      );
    state = state.copyWith(
      properties: propertiesToRemove,
    );
  }

  void setProperty(String propertyName, String propertyValue) {
    final propertiesToSet = [...state.properties]
      ..removeWhere(
        (element) => element.propertyName == propertyName,
      )
      ..add(
        NftCreationFormStateProperty(
          propertyName: propertyName,
          propertyValue: propertyValue,
        ),
      )
      ..sort((a, b) => a.propertyName.compareTo(b.propertyName));
    state = state.copyWith(
      properties: propertiesToSet,
      propertyName: '',
      propertyValue: '',
    );
  }

  void setName(BuildContext context, String name) {
    state = state.copyWith(error: '');

    if (name.isEmpty) {
      state = state.copyWith(
        name: name,
        error: AppLocalizations.of(context)!.nftNameEmpty,
      );
      return;
    }

    state = state.copyWith(name: name, error: '');
    setProperty('name', name);
  }

  void setSymbol(String symbol) {
    state = state.copyWith(symbol: symbol, error: '');
  }

  void setInitialSupply(int initialSupply) {
    state = state.copyWith(initialSupply: initialSupply, error: '');
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
    setProperty('description', description);
  }

  void setPropertyName(String propertyName) {
    state = state.copyWith(
      propertyName: propertyName,
      error: '',
    );
  }

  void setError(String error) {
    state = state.copyWith(
      error: error,
    );
  }

  void setPropertyValue(String propertyValue) {
    state = state.copyWith(
      propertyValue: propertyValue,
      error: '',
    );
  }

  void setPropertySearch(String propertySearch) {
    state = state.copyWith(
      propertySearch: propertySearch,
    );
  }

  void resetState() {
    state = state.copyWith(
      fileImportType: null,
      fileSize: 0,
      fileTypeMime: '',
      fileDecodedForPreview: null,
      file: null,
      properties: [],
      fileURL: null,
    );
  }

  Future<void> setContentProperties(
    BuildContext context,
    Uint8List fileDecoded,
    FileImportType fileImportType,
    String typeMime,
  ) async {
    final file64 = base64Encode(fileDecoded);

    Uint8List? fileDecodedForPreview;

    if (MimeUtil.isImage(typeMime) == true) {
      fileDecodedForPreview = fileDecoded;

      // TODO(reddwarf03): Change the exif addition in the ui (3)
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
          fileDecoded,
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
        propertyName: 'content',
        propertyValue: {'raw': file64},
      ),
      NftCreationFormStateProperty(
        propertyName: 'type_mime',
        propertyValue: typeMime,
      ),
    ];

    state = state.copyWith(
      fileImportType: fileImportType,
      fileSize: fileDecoded.length,
      fileTypeMime: typeMime,
      fileDecodedForPreview: fileDecodedForPreview,
      file: {fileDecoded: List<String>.empty(growable: true)},
      properties: newPropertiesToSet,
    );

    if (controlFile(context) == false) {
      resetState();
    }
  }

  Future<void> setContentIPFSProperties(
    BuildContext context,
    String uri,
  ) async {
    // Set content property and remove type_mine
    final newPropertiesToSet = [
      ...state.properties,
    ]
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'type_mime',
      )
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'content',
      )
      ..add(
        NftCreationFormStateProperty(
          propertyName: 'content',
          propertyValue: {'ipfs': uri},
        ),
      );

    state = state.copyWith(
      properties: newPropertiesToSet,
      fileImportType: FileImportType.ipfs,
      fileURL: uri,
    );

    if (controlURL(context) == false) {
      resetState();
      return;
    }
  }

  Future<void> setContentHTTPProperties(
    BuildContext context,
    String uri,
  ) async {
    // Set content property and remove type_mine
    final newPropertiesToSet = [
      ...state.properties,
    ]
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'type_mime',
      )
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'content',
      )
      ..add(
        NftCreationFormStateProperty(
          propertyName: 'content',
          propertyValue: {'http': uri},
        ),
      );

    state = state.copyWith(
      properties: newPropertiesToSet,
      fileImportType: FileImportType.http,
      fileURL: uri,
    );

    if (controlURL(context) == false) {
      resetState();
      return;
    }
  }

  Future<void> setContentAEWebProperties(
    BuildContext context,
    String uri,
  ) async {
    // Set content property and remove type_mine
    final newPropertiesToSet = [
      ...state.properties,
    ]
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'type_mime',
      )
      ..removeWhere(
        (NftCreationFormStateProperty element) =>
            element.propertyName == 'content',
      )
      ..add(
        NftCreationFormStateProperty(
          propertyName: 'content',
          propertyValue: {'aeweb': uri},
        ),
      );

    state = state.copyWith(
      properties: newPropertiesToSet,
      fileImportType: FileImportType.aeweb,
      fileURL: uri,
    );

    if (controlURL(context) == false) {
      resetState();
      return;
    }
  }

  bool controlFile(
    BuildContext context,
  ) {
    if (!state.isFileImportFile()) {
      return true;
    }

    if (state.file == null || state.file!.keys.isEmpty) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.nftAddConfirmationFileEmpty,
      );
      return false;
    }

    if (MimeUtil.isImage(state.fileTypeMime) == false &&
        MimeUtil.isPdf(state.fileTypeMime) == false) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.nftFormatNotSupportedEmpty,
      );
      return false;
    }

    if (state.fileSize > 2500000) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.nftSizeExceed,
      );
      return false;
    }

    state = state.copyWith(error: '');
    return true;
  }

  bool controlURL(
    BuildContext context,
  ) {
    if (!state.isFileImportUrl()) {
      return true;
    }
    if (state.fileURL == null) {
      state = state.copyWith(
        error: 'Error url',
      );
      return false;
    }

    state = state.copyWith(error: '');
    return true;
  }

  bool controlAddNFTProperty(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    if (state.properties
        .where((element) => element.propertyName == state.propertyName)
        .isNotEmpty) {
      state = state.copyWith(
        error: localizations.nftPropertyExists,
      );
      return false;
    }

    state = state.copyWith(
      error: '',
    );
    return true;
  }

  Future<void> send(BuildContext context) async {
    final transactionRepository = ref.read(NftCreationFormProvider._repository);

    final localizations = AppLocalizations.of(context)!;

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    late Transaction transaction;

    final keychainSecuredInfos = ref
        .read(SessionProviders.session)
        .loggedIn!
        .wallet
        .keychainSecuredInfos;

    transaction = Transaction.token(
      token: Token(
        name: state.name,
        symbol: state.symbol,
        initialSupply: state.initialSupply.toDouble(),
        accountSelectedName: selectedAccount!.name,
        keychainSecuredInfos: keychainSecuredInfos,
        transactionLastAddress: selectedAccount.lastAddress!,
        type: 'non-fungible',
        aeip: [2, 9],
        properties: state.propertiesConverted,
      ),
    );

    transactionRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        if (archethic.TransactionConfirmation.isEnoughConfirmations(
          confirmation.nbConfirmations,
          confirmation.maxConfirmations,
          TransactionValidationRatios.addNFT,
        )) {
          transactionRepository.close();
          EventTaxiImpl.singleton().fire(
            TransactionSendEvent(
              transactionType: TransactionSendEventType.token,
              response: 'ok',
              nbConfirmations: confirmation.nbConfirmations,
              transactionAddress: confirmation.transactionAddress,
              maxConfirmations: confirmation.maxConfirmations,
            ),
          );
        }
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
          consensusNotReached: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.consensusNotReached,
                nbConfirmations: 0,
              ),
            );
          },
          timeout: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.transactionTimeOut,
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
                response: localizations.genericError,
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
  static final _repository = Provider<TransactionRemoteRepositoryInterface>(
    (ref) {
      final networkSettings = ref
          .watch(
            SettingsProviders.settings,
          )
          .network;
      return ArchethicTransactionRepository(
        phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
        websocketEndpoint: networkSettings.getWebsocketUri(),
      );
    },
  );
  static final nftCreationFormArgs = _nftCreationFormProviderArgs;
  static final nftCreationForm = _nftCreationFormProvider;
}
