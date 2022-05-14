/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:core/model/data/hive_db.dart';

class AccountChangedEvent implements Event {
  AccountChangedEvent(
      {this.account, this.delayPop = false, this.noPop = false});

  final Account? account;
  final bool delayPop;
  final bool noPop;
}
