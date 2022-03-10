// Package imports:

// Package imports:
import 'package:core/model/data/hive_db.dart';
import 'package:event_taxi/event_taxi.dart';

class ContactRemovedEvent implements Event {
  ContactRemovedEvent({this.contact});

  final Contact? contact;
}
