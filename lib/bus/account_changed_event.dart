/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/data/account.dart';
import 'package:event_taxi/event_taxi.dart';

class AccountChangedEvent implements Event {
  AccountChangedEvent({
    this.account,
    this.delayPop = false,
    this.noPop = false,
  });

  final Account? account;
  final bool delayPop;
  final bool noPop;
}
