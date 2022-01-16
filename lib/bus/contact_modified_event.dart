// Package imports:

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_wallet/model/data/hive_db.dart';

// Project imports:

class ContactModifiedEvent implements Event {
  ContactModifiedEvent({this.contact});

  final Contact? contact;
}
