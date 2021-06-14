// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:uniris_mobile_wallet/model/db/contact.dart';

class ContactAddedEvent implements Event {
  ContactAddedEvent({this.contact});

  final Contact? contact;
}
