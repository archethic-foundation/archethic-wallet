import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';

class BalanceGetEvent implements Event {
  final Account? account;
  final Balance? response;

  BalanceGetEvent({this.response, this.account});
}
