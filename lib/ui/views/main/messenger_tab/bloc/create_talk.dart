import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/messenger/talk.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/add_public_key_textfield_pk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_talk.freezed.dart';

final createTalkFormProvider =
    NotifierProvider.autoDispose<CreateTalkFormNotifier, CreateTalkFormState>(
  () {
    return CreateTalkFormNotifier();
  },
);

@freezed
class AccessRecipient with _$AccessRecipient {
  const AccessRecipient._();
  const factory AccessRecipient.publicKey({
    required PublicKey publicKey,
  }) = _PropertyAccessPublicKey;
  const factory AccessRecipient.contact({
    required Contact contact,
  }) = _PropertyAccessContact;

  PublicKey? get publicKey => when(
        publicKey: (publicKey) => publicKey,
        contact: (contact) => PublicKey(contact.publicKey),
      );

  bool get isPublicKeyValid => (publicKey ?? const PublicKey('')).isValid;
}

@freezed
class CreateTalkFormState with _$CreateTalkFormState {
  const factory CreateTalkFormState({
    required String name,
    AccessRecipient? memberAddFieldValue,
    required List<AccessRecipient> members,
    AccessRecipient? adminAddFieldValue,
    required List<AccessRecipient> admins,
  }) = _CreateTalkFormState;
  const CreateTalkFormState._();

  bool get canSubmit => name.isNotEmpty && members.isNotEmpty;
}

class CreateTalkFormNotifier extends AutoDisposeNotifier<CreateTalkFormState> {
  CreateTalkFormNotifier();

  @override
  CreateTalkFormState build() => const CreateTalkFormState(
        name: '',
        members: [],
        admins: [],
      );

  void setMemberAddFieldValue(AddPublicKeyTextFieldValue fieldValue) {
    state = state.copyWith(memberAddFieldValue: fieldValue.toAccessRecipient);
  }

  void addMember(AccessRecipient member) {
    if (state.members.contains(member)) return;
    state = state.copyWith(
      members: [
        ...state.members,
        member,
      ],
    );
  }

  void removeMember(AccessRecipient member) {
    state = state.copyWith(
      members: state.members.where((element) => element != member).toList(),
    );
  }

  void setAdminAddFieldValue(AddPublicKeyTextFieldValue fieldValue) {
    state = state.copyWith(adminAddFieldValue: fieldValue.toAccessRecipient);
  }

  void addAdmin(AccessRecipient member) {
    if (state.admins.contains(member)) return;
    state = state.copyWith(
      admins: [
        ...state.admins,
        member,
      ],
    );
  }

  Future<void> setName(
    String name,
  ) async {
    state = state.copyWith(
      name: name,
    );
    return;
  }

  Future<Result<Talk, Failure>> createTalk() => Result.guard(() async {
        final session = ref.watch(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.watch(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final talk = await ref
            .watch(MessengerProviders.messengerRepository)
            .createTalk(
              networkSettings: ref.watch(SettingsProviders.settings).network,
              admins: state.admins
                  .map((e) => e.publicKey)
                  .whereType<PublicKey>()
                  .toList(),
              members: state.members
                  .map((e) => e.publicKey)
                  .whereType<PublicKey>()
                  .toList(),
              creator: selectedAccount,
              session: session,
              groupName: state.name,
            )
            .valueOrThrow;
        ref.invalidate(MessengerProviders.talkIds);

        return talk;
      });
}
