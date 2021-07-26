// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/db/account.dart';

class BalanceGetEvent implements Event {
  BalanceGetEvent({this.response, this.account});

  final Account? account;
  final Balance? response;
}
