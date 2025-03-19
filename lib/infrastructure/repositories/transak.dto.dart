import 'package:aewallet/domain/models/onramp.dart';

extension OnRampProviderOrderFromDTO on Map<String, dynamic> {
  OnRampProviderOrder? toOnRampProviderOrder() {
    return switch (this) {
      {
        'orderId': final String orderId,
        'cryptoAmount': final String cryptoAmount,
        'cryptoCurrency': final String cryptoSymbol,
        'status': final status,
      } =>
        (
          providerId: 'transak',
          orderId: orderId,
          cryptoSymbol: cryptoSymbol,
          cryptoAmount: double.parse(cryptoAmount),
          status: switch (status) {
            'CANCELLED' => OnRampProviderOrderStatus.canceled,
            'COMPLETED' => OnRampProviderOrderStatus.completed,
            'AWAITING_PAYMENT_FROM_USER' ||
            'PAYMENT_DONE_MARKED_BY_USER' ||
            'PENDING_DELIVERY_FROM_TRANSAK' ||
            'ON_HOLD_PENDING_DELIVERY_FROM_TRANSAK' =>
              OnRampProviderOrderStatus.processing,
            _ => OnRampProviderOrderStatus.failed,
          }
        ),
      _ => null,
    };
  }
}
