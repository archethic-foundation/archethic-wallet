import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'oracle_service.g.dart';

@riverpod
OracleService oracleService(OracleServiceRef ref) {
  // We use always mainnet values
  return OracleService('https://mainnet.archethic.net');
}
