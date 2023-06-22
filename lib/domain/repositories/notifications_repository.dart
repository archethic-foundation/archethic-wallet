import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_repository.freezed.dart';
part 'notifications_repository.g.dart';

@freezed
class TxSentEvent with _$TxSentEvent {
  const factory TxSentEvent({
    required String txAddress,
    required String txChainGenesisAddress,
  }) = _TxSentEvent;
  const TxSentEvent._();

  factory TxSentEvent.fromJson(Map<String, dynamic> json) =>
      _$TxSentEventFromJson(json);
}

abstract class NotificationsRepository {
  Future<void> initialize();

  Future<void> sendTransactionNotification({
    required TransactionNotification notification,
    required KeyPair senderKeyPair,
    required int txIndex,
    required String notifBackendBaseUrl,
  });

  Future<void> subscribe(String txChainGenesisAddress);
  Future<void> unsubscribe(String txChainGenesisAddress);

  Stream<TxSentEvent> get events;
}
