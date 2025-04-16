import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class PubKeyUtil {
  static Future<String?> getGenesisPublicKey(
    String address,
    ApiService apiService,
  ) async {
    final publicKeyMap = await apiService.getTransactionChain(
      {address: ''},
      request: 'previousPublicKey',
    );
    String? publicKey;
    if (publicKeyMap.isNotEmpty &&
        publicKeyMap[address] != null &&
        publicKeyMap[address]!.isNotEmpty) {
      publicKey = publicKeyMap[address]![0].previousPublicKey;
    }

    return publicKey;
  }
}
