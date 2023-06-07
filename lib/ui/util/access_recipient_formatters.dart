import 'package:aewallet/ui/views/main/messenger_tab/bloc/create_talk.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension AccessRecipientFormatters on AccessRecipient {
  String format(AppLocalizations localizations) => when(
        publicKey: (publicKey) => publicKey.publicKey,
        contact: (contact) => contact.name.replaceFirst('@', ''),
      );
}
