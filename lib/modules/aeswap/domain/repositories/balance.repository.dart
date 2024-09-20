import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show Balance, ApiService;

abstract class BalanceRepository {
  Future<double> getBalance(
    String address,
    String tokenAddress,
    ApiService apiService,
  );

  Future<Balance?> getUserTokensBalance(
    String address,
    ApiService apiService,
  );
}
