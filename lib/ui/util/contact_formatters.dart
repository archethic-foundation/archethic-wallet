import 'package:aewallet/model/data/contact.dart';

extension ContactFormatters on Contact {
  String get format {
    final decodedName = Uri.decodeFull(name);
    return decodedName.length > 1 && decodedName.startsWith('@')
        ? decodedName.replaceFirst('@', '')
        : decodedName;
  }
}
