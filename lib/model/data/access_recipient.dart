import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'access_recipient.freezed.dart';
part 'access_recipient.g.dart';

@freezed
class AccessRecipient with _$AccessRecipient {
  const AccessRecipient._();
  @HiveType(
    adapterName: 'PubKeyAccessRecipientAdapter',
    typeId: HiveTypeIds.pubKeyAccessRecipient,
  )
  const factory AccessRecipient.publicKey({
    @HiveField(0) required String publicKey,
  }) = _AccessPublicKey;
  @HiveType(
    adapterName: 'ContactAccessRecipientAdapter',
    typeId: HiveTypeIds.contactAccessRecipient,
  )
  const factory AccessRecipient.contact({
    @HiveField(0) required Contact contact,
  }) = _AccessContact;

  String get publicKey => when(
        publicKey: (publicKey) => publicKey,
        contact: (contact) => contact.publicKey,
      );

  bool get isPublicKeyValid => PublicKey(publicKey).isValid;

  String get name => map(
        contact: (contact) => contact.contact.format,
        publicKey: (value) => value.publicKey,
      );
}
