// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';

class BalanceGetEvent implements Event {
  BalanceGetEvent({this.response, this.account});

  final Account? account;
  final Balance? response;
}
