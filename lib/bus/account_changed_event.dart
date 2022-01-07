// Package imports:

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_wallet/model/data/hiveDB.dart';

class AccountChangedEvent implements Event {
  AccountChangedEvent(
      {this.account, this.delayPop = false, this.noPop = false});

  final Account? account;
  final bool delayPop;
  final bool noPop;
}
