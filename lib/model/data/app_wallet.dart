// Package imports:
// Project imports:
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

part 'app_wallet.g.dart';

@HiveType(typeId: 4)
class AppWallet extends HiveObject {
  AppWallet({
    required this.seed,
    required this.appKeychain,
  });

  /// Seed
  @HiveField(0)
  String seed;

  /// Keychain
  @HiveField(1)
  AppKeychain appKeychain;

  static Future<AppWallet> createNewAppWallet(
    String keychainAddress,
    Keychain keychain,
    String? name,
  ) async {
    Account? selectedAcct;
    const seed = '';

    var appWallet =
        await sl.get<DBHelper>().createAppWallet(seed, keychainAddress);

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
        fiatCurrencyCode: '',
        fiatCurrencyValue: 0,
        nativeTokenName: '',
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
      publicKey: uint8ListToHex(keychain.deriveKeypair(kServiceName).publicKey)
          .toUpperCase(),
    );
    await sl.get<DBHelper>().saveContact(newContact);

    return appWallet;
  }
}
