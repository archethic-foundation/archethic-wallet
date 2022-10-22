import 'package:aewallet/model/data/contact.dart';

extension ContactFormatters on Contact {
  String get format => name.replaceFirst('@', '');
}
