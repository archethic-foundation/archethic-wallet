import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
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
    @HiveField(0) required PublicKey publicKey,
  }) = _AccessPublicKey;
  @HiveType(
    adapterName: 'ContactAccessRecipientAdapter',
    typeId: HiveTypeIds.contactAccessRecipient,
  )
  const factory AccessRecipient.contact({
    @HiveField(0) required Contact contact,
  }) = _AccessContact;

  PublicKey? get publicKey => when(
        publicKey: (publicKey) => publicKey,
        contact: (contact) => PublicKey(contact.publicKey),
      );

  bool get isPublicKeyValid => (publicKey ?? const PublicKey('')).isValid;

  String get name => map(
        contact: (contact) => contact.contact.name,
        publicKey: (value) => value.publicKey.publicKey,
      );
}
