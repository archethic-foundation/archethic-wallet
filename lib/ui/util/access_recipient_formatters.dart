import 'package:aewallet/model/data/access_recipient.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension AccessRecipientFormatters on AccessRecipient {
  String format(AppLocalizations localizations) => when(
        publicKey: (publicKey) => publicKey.publicKey,
        contact: (contact) => contact.name.replaceFirst('@', ''),
      );
}
