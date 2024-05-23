import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:hive/hive.dart';

class AppWalletHiveDatasource {
  AppWalletHiveDatasource._();

  factory AppWalletHiveDatasource.instance() {
    return _instance ?? (_instance = AppWalletHiveDatasource._());
  }

  static AppWalletHiveDatasource? _instance;

  static const String appWalletTable = 'appWallet';

  Future<void> clearAppWallet() async {
    await Hive.deleteBox<HiveAppWalletDTO>(appWalletTable);
  }

  Future<HiveAppWalletDTO> createAppWallet(String keyChainAddress) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appKeychain = AppKeychain(
      address: keyChainAddress,
      accounts: <Account>[],
    );
    final appWallet = HiveAppWalletDTO(appKeychain: appKeychain);
    await box.add(appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO?> getAppWallet() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    return box.get(0);
  }

  Future<void> saveAppWallet(HiveAppWalletDTO wallet) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    return box.putAt(0, wallet);
  }
}
