import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';

extension TransferRecipientFormatters on TransferRecipient {
  String format(AppLocalization localizations) => when(
        address: (address) => address.getShortString(),
        contact: (contact) => contact.name.replaceFirst('@', ''),
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
