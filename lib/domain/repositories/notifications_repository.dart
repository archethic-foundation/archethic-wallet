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

/// Manages subscriptions to PUSH and Websocket notifications.
///
/// When listening a TransactionChain, every update to that
/// TransactionChain will be received as a notification.
///
/// Subscriptions are restaured when calling [initialize].
/// You should call that method on application startup.
abstract class NotificationsRepository {
  /// Initializes notifications listeners.
  ///
  /// Previous subscriptions are restaured.
  /// You should call that method on application startup.
  Future<void> initialize();

  /// Sends a notification to the Notification relay backend.
  /// The notification may be received by applications listening to
  /// that TransactionChain
  Future<void> sendTransactionNotification({
    required TransactionNotification notification,
    required KeyPair senderKeyPair,
    required int txIndex,
    required String notifBackendBaseUrl,
  });

  /// Starts listening to a TransactionChain updates.
  ///
  /// You must not call this on every application startup :
  /// every subscription is restaured on application startup.
  Future<void> subscribe(List<String> txChainGenesisAddresses);

  /// Stops listening to a TransactionChain updates.
  Future<void> unsubscribe(List<String> txChainGenesisAddresses);

  /// Received websocket notifications.
  Stream<TxSentEvent> get events;
}
