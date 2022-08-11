/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/model/data/contact.dart';

class ContactAddedEvent implements Event {
  ContactAddedEvent({this.contact});

  final Contact? contact;
}
