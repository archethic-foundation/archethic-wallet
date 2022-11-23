import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';

extension PropertyAccessRecipientFormatters on PropertyAccessRecipient {
  String format(AppLocalization localizations) => when(
        publicKey: (publicKey) => publicKey.publicKey,
        contact: (contact) => contact.name.replaceFirst('@', ''),
        unknownContact: (name) => name.replaceFirst('@', ''),
      );
}
