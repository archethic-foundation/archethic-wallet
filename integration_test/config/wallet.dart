part of 'config.dart';

class AccountConfiguration {
  const AccountConfiguration({
    required this.address,
    required this.name,
  });

  final String address;
  final String name;
}

class WalletConfiguration {
  const WalletConfiguration({
    required this.aliceAccount,
    required this.bobAccount,
    required this.seed,
  });

  final AccountConfiguration aliceAccount;
  final AccountConfiguration bobAccount;
  final List<String> seed;
}
