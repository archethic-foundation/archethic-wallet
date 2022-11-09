part of 'provider.dart';

@immutable
class ReceivedTransaction {
  const ReceivedTransaction({
    required this.amount,
    required this.currencySymbol,
    required this.accountName,
  });

  final int amount;
  final String currencySymbol;
  final String accountName;
}
