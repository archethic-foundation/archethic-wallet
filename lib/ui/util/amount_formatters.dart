import 'package:aewallet/util/number_util.dart';

typedef AmountFormatter = String Function(double amount, String symbol);

class AmountFormatters {
  static final AmountFormatter standard = (double amount, String symbol) =>
      '${NumberUtil.formatThousands(amount)} $symbol';
  static final AmountFormatter standardSmallValue =
      (double amount, String symbol) => '${amount.toStringAsFixed(8)} $symbol';
}
