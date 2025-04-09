import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'package:aewallet/modules/messaging_sdk/model/messaging/ae_discussion.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// For group discussions, a dedicated transaction chain will contain a smart contract and its updates, as well as the discussion's rules and description.
/// The messages will be contained in the inputs of the smart contracts in the chain.
/// A general public key for accessing messages is made available.
mixin DiscussionMixin {
  Future<({Transaction transaction, KeyPair previousKeyPair})>
      updateTransactionSC({
    required Keychain keychain,
    required ApiService apiService,
    required String discussionName,
    required List<String> adminsPubKey,
    required List<String> membersPubKey,
    required String adminAddress,
    required String serviceName,
    required String discussionSCAddress,
    required KeyPair adminKeyPair,
    bool updateSCAESKey = false,
  }) async {
    final indexMap = await apiService.getTransactionIndex([adminAddress]);
    if (indexMap[adminAddress] == null) {
      throw Exception('Discussion not exists');
    }

    var discussionKeyAccess = '';

    if (updateSCAESKey) {
      discussionKeyAccess = generateRandomAESKey();
    } else {
      discussionKeyAccess = uint8ListToHex(
        await getDiscussionKeyAccess(
          apiService: apiService,
          discussionSCAddress: discussionSCAddress,
          keyPair: adminKeyPair,
        ),
      );
    }

    final newContent = _generateDiscussionSCContent(
      discussionName: discussionName,
      adminsPubKey: adminsPubKey,
      discussionKeyAccess: discussionKeyAccess,
    );

    final originPrivateKey = apiService.getOriginKey();

    /// AESKey (32-byte (256-bit) random key) manages SC secrets
    final aesKey = generateRandomAESKey();
    final membersAuthorizedKeys = _addMembersInAuthorized(
      aesKey: aesKey,
      membersPubKey: membersPubKey,
    );

    final ownership = Ownership(
      secret: uint8ListToHex(
        aesEncrypt(discussionKeyAccess, aesKey),
      ),
      authorizedPublicKeys: membersAuthorizedKeys,
    );

    Map<String, Object?> ownershipToJson(Ownership x) {
      final authorizedKeysMap = <String, String>{};
      for (final key in x.authorizedPublicKeys) {
        if (key.publicKey != null && key.encryptedSecretKey != null) {
          authorizedKeysMap[key.publicKey!] = key.encryptedSecretKey!;
        }
      }

      return {
        'authorized_keys': authorizedKeysMap,
        'secret': x.secret == null ? '' : x.secret!,
      };
    }

    final transactionTransfer = Transaction(
      type: 'transfer',
      version: 3, // Old SC
      data: Transaction.initData(),
    ).addRecipient(
      discussionSCAddress,
      action: 'update_discussion',
      args: [
        newContent,
        ownershipToJson(ownership),
      ],
    ).addUCOTransfer(discussionSCAddress, toBigInt(5));

    final transactionTransferBuildResult = keychain.buildTransaction(
      transactionTransfer,
      serviceName,
      indexMap[adminAddress]!,
    );

    final transactionTransferSigned =
        transactionTransferBuildResult.transaction.originSign(originPrivateKey);

    await TransactionUtil().sendTransactions(
      [transactionTransferSigned],
      apiService,
    );

    return (
      transaction: transactionTransferSigned,
      previousKeyPair: transactionTransferBuildResult.keyPair,
    );
  }

  Future<({Transaction transaction, KeyPair previousKeyPair})>
      createTransactionSC({
    required Keychain keychain,
    required ApiService apiService,
    required List<String> membersPubKey,
    required String discussionName,
    required List<String> adminsPubKey,
    required String adminAddress,
    required String serviceName,
    int indexSCTransaction = 0,
  }) async {
    /// AESKey (32-byte (256-bit) random key) manages message access (encryption/decryption)
    final discussionKeyAccess = generateRandomAESKey();

    /// AESKey (32-byte (256-bit) random key) manages SC secrets
    final aesKey = generateRandomAESKey();

    final membersAuthorizedKeys = _addMembersInAuthorized(
      aesKey: aesKey,
      membersPubKey: membersPubKey,
    );

    /// Seed of the Smart Contract
    final storageNoncePublicKey = await apiService.getStorageNoncePublicKey();
    final seedSC = generateRandomSeed();

    final scAuthorizedKeys = List<AuthorizedKey>.empty(growable: true)
      ..add(
        AuthorizedKey(
          publicKey: storageNoncePublicKey,
          encryptedSecretKey:
              uint8ListToHex(ecEncrypt(aesKey, storageNoncePublicKey)),
        ),
      );

    final originPrivateKey = apiService.getOriginKey();

    /// Create a new transaction typed Smart Contract to manage a discussion
    final transactionSCBuildResult = Transaction(
      type: 'contract',
      data: Transaction.initData(),
      version: 3, // Old SC
    )
        .setCode(_generateDiscussionSCCode(membersPubKey: membersPubKey))
        .setContent(
          _generateDiscussionSCContent(
            discussionName: discussionName,
            adminsPubKey: adminsPubKey,
            discussionKeyAccess: discussionKeyAccess,
          ),
        )

        /// Secret 1 : Seed of the SC only accessible by nodes
        .addOwnership(
          uint8ListToHex(
            aesEncrypt(seedSC, aesKey),
          ),
          scAuthorizedKeys,
        )

        /// Secret 2 : DiscussionKeyAccess only accessible by the discussion's members
        .addOwnership(
          uint8ListToHex(
            aesEncrypt(discussionKeyAccess, aesKey),
          ),
          membersAuthorizedKeys,
        )
        .build(seedSC, indexSCTransaction);

    final transactionSC =
        transactionSCBuildResult.transaction.originSign(originPrivateKey);

    // Estimation of fees and send to SC's transaction chain
    final transactionTransferResult = await _provisionSC(
      apiService: apiService,
      issuerAddress: adminAddress,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      seedSC: seedSC,
      serviceName: serviceName,
      transactionSC: transactionSC,
    );

    await TransactionUtil().sendTransactions(
      [transactionTransferResult.transaction, transactionSC],
      apiService,
    );

    return (
      transaction: transactionSC,
      previousKeyPair: transactionSCBuildResult.keyPair,
    );
  }

  String _generateDiscussionSCCode({
    required List<String> membersPubKey,
  }) {
    /// A discussion is represented and managed by a smart contract.
    /// This smart contract contains a code that lists the public keys authorized to send transactions to the smart contract
    /// This prevents messages from unauthorized persons from being integrated as contract inputs into the smart contract.
    return '''
@version 1

condition transaction: [             
  previous_public_key: List.in?([
    ${membersPubKey.map((key) => '"$key"').join(', ')}
    ], 
    Chain.get_genesis_public_key(transaction.previous_public_key)
  )               
]

condition triggered_by: transaction, on: update_discussion(new_content, members_pub_key), as: [
]

actions triggered_by: transaction, on: update_discussion(new_content, members_pub_key) do
  Contract.set_content(new_content)
  Contract.add_ownership(members_pub_key)
end

actions triggered_by: transaction do

end

''';
  }

  /// A discussion is represented and managed by a smart contract.
  /// This smart contract contains a content that describes discussion's properties:
  /// - Name of the discussion
  /// - lists the public keys of the admin
  String _generateDiscussionSCContent({
    required String discussionName,
    required List<String> adminsPubKey,
    required String discussionKeyAccess,
  }) {
    final content = '''
{
  "discussionName": "$discussionName",                             
  "adminPublicKey": [${adminsPubKey.map((key) => '"$key"').join(', ')}]  
}
    ''';

    /// Only members of the discussion could decrypted discussion's properties
    /// We encrypt content with discussionKeyAccess + encode in Base64
    final cryptedContent =
        aesEncrypt(utf8.encode(content), discussionKeyAccess);
    final cryptedContentBase64 = base64.encode(cryptedContent);
    return cryptedContentBase64;
  }

  List<AuthorizedKey> _addMembersInAuthorized({
    required String aesKey,
    required List<String> membersPubKey,
  }) {
    final membersAuthorizedKeys = <AuthorizedKey>[];
    for (final key in membersPubKey) {
      membersAuthorizedKeys.add(
        AuthorizedKey(
          encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
          publicKey: key,
        ),
      );
    }
    return membersAuthorizedKeys;
  }

  Future<({Transaction transaction, KeyPair previousKeyPair})> _provisionSC({
    required Keychain keychain,
    required ApiService apiService,
    required Transaction transactionSC,
    required String seedSC,
    required String issuerAddress,
    required String serviceName,
    required String originPrivateKey,
  }) async {
    // Estimation of fees and send to SC's transaction chain
    const slippage = 1.01;
    final transactionFee = await apiService.getTransactionFee(transactionSC);
    final fees = fromBigInt(transactionFee.fee) * slippage;
    final genesisAddressSC = deriveAddress(seedSC, 0);

    final transactionTransfer = Transaction(
      type: 'transfer',
      data: Transaction.initData(),
    ).addUCOTransfer(genesisAddressSC, toBigInt(fees));

    final indexMap = await apiService.getTransactionIndex(
      [issuerAddress],
    );

    final index = indexMap[issuerAddress] ?? 0;

    final transactionBuildResult = keychain.buildTransaction(
      transactionTransfer,
      serviceName,
      index,
    );

    return (
      transaction:
          transactionBuildResult.transaction.originSign(originPrivateKey),
      previousKeyPair: transactionBuildResult.keyPair,
    );
  }

  Future<AEDiscussion?> getDiscussionFromSCAddress({
    required ApiService apiService,
    required String discussionSCAddress,
    required KeyPair keyPair,
  }) async {
    final smartContractMap =
        await apiService.getTransaction([discussionSCAddress]);
    if (smartContractMap[discussionSCAddress] == null) {
      return null;
    }

    try {
      final discussionKeyAccess = await getDiscussionKeyAccess(
        apiService: apiService,
        discussionSCAddress: discussionSCAddress,
        keyPair: keyPair,
      );

      final smartContract = smartContractMap[discussionSCAddress];

      final cryptedContent = base64.decode(smartContract!.data!.content!);

      final content = utf8.decode(
        aesDecrypt(cryptedContent, discussionKeyAccess),
      );
      final jsonContentMap = jsonDecode(content);

      final usersPubKey = <String>[];
      for (final authorizedPublicKey
          in smartContract.data!.ownerships[1].authorizedPublicKeys) {
        usersPubKey.add(authorizedPublicKey.publicKey!);
      }

      final aeDiscussion = AEDiscussion(
        address: smartContract.address!.address!,
        discussionName: jsonContentMap['discussionName'],
        usersPubKey: usersPubKey,
        adminPublicKey: List<String>.from(jsonContentMap['adminPublicKey']),
        timestampLastUpdate: smartContract.validationStamp!.timestamp!,
      );

      return aeDiscussion;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// This method get the AES Key used to encrypt and decrypt informations in the discussion (messages, discussion's properties)
  Future<Uint8List> getDiscussionKeyAccess({
    required ApiService apiService,
    required String discussionSCAddress,
    required KeyPair keyPair,
  }) async {
    // Get message key from SC secret
    final mapTransactionOwnerships =
        await apiService.getTransactionOwnerships([discussionSCAddress]);
    final ownerships = mapTransactionOwnerships[discussionSCAddress];
    if (ownerships == null && ownerships!.isEmpty) {
      throw Exception();
    }

    final authorizedPublicKey = ownerships[1].authorizedPublicKeys.firstWhere(
          (AuthorizedKey authKey) =>
              authKey.publicKey!.toUpperCase() ==
              uint8ListToHex(Uint8List.fromList(keyPair.publicKey!))
                  .toUpperCase(),
          orElse: AuthorizedKey.new,
        );
    if (authorizedPublicKey.encryptedSecretKey == null) {
      throw Exception();
    }
    final aesKey = ecDecrypt(
      authorizedPublicKey.encryptedSecretKey,
      Uint8List.fromList(keyPair.privateKey!),
    );
    return aesDecrypt(ownerships[1].secret, aesKey);
  }

  Future<String> getSCDiscussionLastContent({
    required ApiService apiService,
    required String discussionSCAddress,
    required KeyPair readerKeyPair,
  }) async {
    final lastTxMap =
        await apiService.getLastTransaction([discussionSCAddress]);
    final lastTx = lastTxMap[discussionSCAddress];

    final discussionKeyAccess = uint8ListToHex(
      await getDiscussionKeyAccess(
        apiService: apiService,
        discussionSCAddress: discussionSCAddress,
        keyPair: readerKeyPair,
      ),
    );

    final cryptedContent = base64.decode(lastTx!.data!.content!);

    final content = utf8.decode(
      aesDecrypt(cryptedContent, discussionKeyAccess),
    );

    return content;
  }
}

class TransactionUtil with TransactionMixin {}
