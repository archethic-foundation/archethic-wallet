import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_notification.freezed.dart';
part 'transaction_notification.g.dart';

@freezed
class TransactionNotification with _$TransactionNotification {
  const factory TransactionNotification({
    required String txAddress,
    required String txChainGenesisAddress,
  }) = _TransactionNotification;
  const TransactionNotification._();
}

@freezed
class PushNotification with _$PushNotification {
  const factory PushNotification({
    String? title,
    String? body,
  }) = _PushNotification;
  const PushNotification._();

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);
}
