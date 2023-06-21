import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class NotificationsRepository {
  /// Sends a new transaction notification to all listeners.
  ///
  /// Notification transmission is delegated to https://github.com/archethic-foundation/messaging_notification_backend
  ///
  /// [notificationSignature] is a signature of the payload. Signature is done with the same private key as the transaction signature.
  Future<void> sendTransactionNotification({
    required TransactionNotification notification,
    required KeyPair senderKeyPair,
    required String notifBackendBaseUrl,
  });
}
