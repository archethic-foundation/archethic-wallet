import 'package:aewallet/util/number_util.dart';

typedef AmountFormatter = String Function(double amount, String symbol);

class AmountFormatters {
  static String withoutCurrency(double amount) =>
      NumberUtil.formatThousands(amount);

  static String standard(
    double amount,
    String symbol,
  ) =>
      '${NumberUtil.formatThousands(amount)} $symbol';

  static String standardSmallValue(double amount, String symbol,
          {int decimal = 8}) =>
      '${amount.toStringAsFixed(decimal)} $symbol';
}
