/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:hive/hive.dart';

part 'price.g.dart';

@HiveType(typeId: 7)
class Price extends HiveObject {
  Price({this.amount, this.lastLoading, this.useOracleUcoPrice});

  /// Amount
  @HiveField(0)
  double? amount;

  /// Last loading of the value
  @HiveField(1)
  int? lastLoading;

  /// Price from Oracle
  @HiveField(2)
  bool? useOracleUcoPrice;

  // Change currency
  static Future<Price> getCurrency(String currency) async {
    Price price = Price();
    SimplePriceResponse simplePriceResponse = SimplePriceResponse();
    price.useOracleUcoPrice = false;
    // if eur or usd, use Archethic Oracle
    // TODO: The value of 1 uco is not correct when the price is given by Archethic oracle #192
    /*if (currency == 'EUR' || currency == 'USD') {
      try {
        final OracleUcoPrice oracleUcoPrice =
            await sl.get<OracleService>().getLastOracleUcoPrice();
        if (oracleUcoPrice.uco == null || oracleUcoPrice.uco!.eur == 0) {
          simplePriceResponse =
              await sl.get<ApiCoinsService>().getSimplePrice(currency);
        } else {
          simplePriceResponse.currency = currency;
          if (currency == 'EUR') {
            simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.eur;
            price.useOracleUcoPrice = true;
          } else {
            if (currency == 'USD') {
              simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.usd;
              price.useOracleUcoPrice = true;
            } else {
              simplePriceResponse =
                  await sl.get<ApiCoinsService>().getSimplePrice(currency);
            }
          }
        }
      } catch (e) {
        simplePriceResponse =
            await sl.get<ApiCoinsService>().getSimplePrice(currency);
      }
    } else {
      simplePriceResponse =
          await sl.get<ApiCoinsService>().getSimplePrice(currency);
    }*/
    simplePriceResponse =
        await sl.get<ApiCoinsService>().getSimplePrice(currency);
    price.amount = simplePriceResponse.localCurrencyPrice!;
    price.lastLoading =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    await sl.get<DBHelper>().updatePrice(price);

    return price;
  }
}
