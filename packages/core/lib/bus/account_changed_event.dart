// Package imports:

// Package imports:
import 'package:core/model/data/hive_db.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:

class AccountChangedEvent implements Event {
  AccountChangedEvent(
      {this.account, this.delayPop = false, this.noPop = false});

  final Account? account;
  final bool delayPop;
  final bool noPop;
}
