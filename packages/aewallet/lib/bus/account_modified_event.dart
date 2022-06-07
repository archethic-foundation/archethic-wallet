// Package imports:
import 'package:core/model/data/hive_db.dart';
import 'package:event_taxi/event_taxi.dart';

class AccountModifiedEvent implements Event {
  final Account? account;
  final bool deleted;

  AccountModifiedEvent({this.account, this.deleted = false});
}
