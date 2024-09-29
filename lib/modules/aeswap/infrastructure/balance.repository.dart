import 'package:aewallet/modules/aeswap/domain/repositories/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class BalanceRepositoryImpl implements BalanceRepository {
  BalanceRepositoryImpl({required this.apiService});

  final archethic.ApiService apiService;

  @override
  Future<archethic.Balance?> getUserTokensBalance(
    String address,
  ) async {
    final balanceGetResponseMap = await apiService.fetchBalance([address]);
    return balanceGetResponseMap[address];
  }
}
