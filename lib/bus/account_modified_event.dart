// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/db/account.dart';

class AccountModifiedEvent implements Event {
  AccountModifiedEvent({this.account, this.deleted = false});

  final Account? account;
  final bool deleted;
}
