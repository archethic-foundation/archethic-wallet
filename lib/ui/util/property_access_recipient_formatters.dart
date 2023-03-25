import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension PropertyAccessRecipientFormatters on PropertyAccessRecipient {
  String format(AppLocalizations localizations) => when(
        publicKey: (publicKey) => publicKey.publicKey,
        contact: (contact) => contact.name.replaceFirst('@', ''),
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
