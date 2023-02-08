import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';

extension TransferRecipientFormatters on TransferRecipient {
  String format(AppLocalization localizations) => when(
        address: (address) =>
            AddressFormatters(address.address!).getShortString(),
        contact: (contact) => contact.name.replaceFirst('@', ''),
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
