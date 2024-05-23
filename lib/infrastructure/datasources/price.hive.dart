import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:hive/hive.dart';

class PriceHiveDatasource {
  PriceHiveDatasource._();

  factory PriceHiveDatasource.instance() {
    return _instance ?? (_instance = PriceHiveDatasource._());
  }

  static const String priceTable = 'price';

  static PriceHiveDatasource? _instance;
  Future<void> updatePrice(AvailableCurrencyEnum currency, Price price) async {
    final box = await Hive.openBox<Price>(priceTable);
    await box.put(currency.index, price);
  }

  Future<Price?> getPrice(AvailableCurrencyEnum currency) async {
    final box = await Hive.openBox<Price>(priceTable);
    return box.get(currency.index);
  }

  Future<void> clearPrice() async {
    await Hive.deleteBox(priceTable);
  }
}
