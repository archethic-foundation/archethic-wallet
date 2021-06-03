import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';

class AccountChangedEvent implements Event {
  AccountChangedEvent(
      {this.account, this.delayPop = false, this.noPop = false});

  final Account? account;
  final bool delayPop;
  final bool noPop;
}
