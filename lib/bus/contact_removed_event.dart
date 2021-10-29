// Package imports:

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/data/hiveDB.dart';

// Project imports:

class ContactRemovedEvent implements Event {
  ContactRemovedEvent({this.contact});

  final Contact? contact;
}
