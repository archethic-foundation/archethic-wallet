import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_subscription.freezed.dart';
part 'rpc_subscription.g.dart';

@freezed
class RPCUnsubscribeCommandDTO with _$RPCUnsubscribeCommandDTO {
  const RPCUnsubscribeCommandDTO._();
  const factory RPCUnsubscribeCommandDTO({
    required String subscriptionId,
  }) = _RPCUnsubscribeCommandDTO;

  factory RPCUnsubscribeCommandDTO.fromJson(Map<String, dynamic> json) =>
      _$RPCUnsubscribeCommandDTOFromJson(json);
}

@freezed
class RPCSubscriptionDTO with _$RPCSubscriptionDTO {
  const factory RPCSubscriptionDTO({
    required String id,
    required Stream<Map<String, dynamic>> updates,
  }) = _RPCSubscriptionDTO;
  const RPCSubscriptionDTO._();

  Map<String, dynamic> toJson() => {
        'subscriptionId': id,
      };
}

@freezed
class RPCSubscriptionUpdateDTO with _$RPCSubscriptionUpdateDTO {
  const factory RPCSubscriptionUpdateDTO({
    required String subscriptionId,
    required Map<String, dynamic> data,
  }) = _RPCSubscriptionUpdateDTO;
  const RPCSubscriptionUpdateDTO._();

  factory RPCSubscriptionUpdateDTO.fromJson(Map<String, dynamic> json) =>
      _$RPCSubscriptionUpdateDTOFromJson(json);
}
