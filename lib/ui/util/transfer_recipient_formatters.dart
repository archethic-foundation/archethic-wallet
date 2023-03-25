import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension TransferRecipientFormatters on TransferRecipient {
  String format(AppLocalizations localizations) => when(
        address: (address) =>
            AddressFormatters(address.address!).getShortString(),
        contact: (contact) => contact.name.replaceFirst('@', ''),
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
