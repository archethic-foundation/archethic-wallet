import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class NotificationsRepositoryImpl
    with MessengerMixin
    implements NotificationsRepository {
  @override
  Future<void> sendTransactionNotification({
    required TransactionNotification notification,
    required KeyPair senderKeyPair,
    required String notifBackendBaseUrl,
  }) {
    throw UnimplementedError();
  }
}
