import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_service.freezed.dart';

@freezed
class RPCAddServiceCommandData with _$RPCAddServiceCommandData {
  const factory RPCAddServiceCommandData({
    /// - Name: service's name
    required String name,
  }) = _RPCAddServiceCommandData;
  const RPCAddServiceCommandData._();
}
