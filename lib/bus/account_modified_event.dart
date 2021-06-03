import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';

class AccountModifiedEvent implements Event {
  AccountModifiedEvent({this.account, this.deleted = false});

  final Account? account;
  final bool deleted;

}
