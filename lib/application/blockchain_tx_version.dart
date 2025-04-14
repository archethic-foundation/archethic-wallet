import 'package:aewallet/application/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blockchain_tx_version.g.dart';

@riverpod
Future<int> blockchainTxCurrentVersion(Ref ref) async {
  const defaultVersion = 4;
  final apiService = ref.watch(apiServiceProvider);
  final blockchainVersion = await apiService.getBlockchainVersion();
  return int.tryParse(blockchainVersion.version.transaction) ?? defaultVersion;
}
