import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension PropertyAccessRecipientFormatters on PropertyAccessRecipient {
  String format(AppLocalizations localizations) => when(
        address: (address) => address.address!,
        contact: (contact) => contact.format,
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
