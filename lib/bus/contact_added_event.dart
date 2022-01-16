// Package imports:

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_wallet/model/data/hive_db.dart';

// Project imports:

class ContactAddedEvent implements Event {
  ContactAddedEvent({this.contact});

  final Contact? contact;
}
