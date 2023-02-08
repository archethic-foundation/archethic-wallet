import 'package:aewallet/domain/models/app_wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

part 'hive_app_wallet_dto.g.dart';

/// Next field available : 2
@HiveType(typeId: 4)
class HiveAppWalletDTO extends HiveObject {
  HiveAppWalletDTO({
    required this.appKeychain,
  });

  factory HiveAppWalletDTO.fromModel(AppWallet appWallet) => HiveAppWalletDTO(
        appKeychain: appWallet.appKeychain,
      );

  AppWallet toModel({
    required String seed,
    required KeychainSecuredInfos keychainSecuredInfos,
  }) =>
      AppWallet(
        appKeychain: appKeychain,
        seed: seed,
        keychainSecuredInfos: keychainSecuredInfos,
      );

  /// Keychain
  @HiveField(1)
  AppKeychain appKeychain;

  static Future<HiveAppWalletDTO> createNewAppWallet(
    String keychainAddress,
    Keychain keychain,
    String? name,
  ) async {
    Account? selectedAcct;

    var appWallet = await sl.get<DBHelper>().createAppWallet(keychainAddress);

    final nameEncoded = Uri.encodeFull(name!);

    /// Default service for wallet
    final kServiceName = 'archethic-wallet-$nameEncoded';

    final genesisAddress = keychain.deriveAddress(kServiceName);
    selectedAcct = Account(
      lastLoadingTransactionInputs: 0,
      lastAddress: uint8ListToHex(genesisAddress),
      genesisAddress: uint8ListToHex(genesisAddress),
      name: name,
      balance: AccountBalance(
        nativeTokenName: AccountBalance.cryptoCurrencyLabel,
        nativeTokenValue: 0,
      ),
      selected: true,
      recentTransactions: [],
    );
    appWallet = await sl.get<DBHelper>().addAccount(selectedAcct);

    final newContact = Contact(
      name: '@$name',
      address: uint8ListToHex(genesisAddress),
      type: ContactType.keychainService.name,
      publicKey: uint8ListToHex(keychain.deriveKeypair(kServiceName).publicKey!)
          .toUpperCase(),
    );
    await sl.get<DBHelper>().saveContact(newContact);

    return appWallet;
  }

  HiveAppWalletDTO copyWith({
    AppKeychain? appKeychain,
  }) =>
      HiveAppWalletDTO(
        appKeychain: appKeychain ?? this.appKeychain,
      );
}
