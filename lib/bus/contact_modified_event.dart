import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';

class ContactModifiedEvent implements Event {
  ContactModifiedEvent({this.contact});

  final Contact? contact;
}
