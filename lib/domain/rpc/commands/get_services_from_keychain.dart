import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_services_from_keychain.freezed.dart';

@freezed
class RPCGetServicesFromKeychainCommandData
    with _$RPCGetServicesFromKeychainCommandData {
  const factory RPCGetServicesFromKeychainCommandData() =
      _RPCGetAccountsCommandData;
  const RPCGetServicesFromKeychainCommandData._();
}

@freezed
class RPCGetServicesFromKeychainResultData
    with _$RPCGetServicesFromKeychainResultData {
  const factory RPCGetServicesFromKeychainResultData({
    required List<Service> services,
  }) = _RPCGetServicesFromKeychainResultData;

  const RPCGetServicesFromKeychainResultData._();
}
