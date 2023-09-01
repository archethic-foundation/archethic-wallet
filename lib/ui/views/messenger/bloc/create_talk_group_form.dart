part of 'providers.dart';

final _createTalkGroupFormProvider = NotifierProvider.autoDispose<
    CreateTalkGroupFormNotifier, CreateTalkGroupFormState>(
  () {
    return CreateTalkGroupFormNotifier();
  },
);

@freezed
class CreateTalkGroupFormState with _$CreateTalkGroupFormState {
  const factory CreateTalkGroupFormState({
    @Default('') String name,
    AccessRecipient? memberAddFieldValue,
    @Default([]) List<AccessRecipient> members,
    AccessRecipient? adminAddFieldValue,
    @Default([]) List<AccessRecipient> admins,
  }) = _CreateTalkGroupFormState;
  const CreateTalkGroupFormState._();

  bool get canSubmit => members.isNotEmpty;
}

class CreateTalkGroupFormNotifier
    extends AutoDisposeNotifier<CreateTalkGroupFormState> {
  CreateTalkGroupFormNotifier();

  @override
  CreateTalkGroupFormState build() => const CreateTalkGroupFormState();

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

  Future<Result<void, Failure>> createTalk() => Result.guard(() async {
        final session = ref.read(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final creator = AccessRecipient.contact(
          contact: await ref.read(ContactProviders.getSelectedContact.future),
        );

        await ref.read(MessengerProviders._messengerRepository).createTalk(
          adminsPubKeys: [
            ...state.admins.map((recipient) => recipient.publicKey),
            creator.publicKey,
          ],
          membersPubKeys: [
            ...state.members.map((recipient) => recipient.publicKey),
            creator.publicKey,
          ],
          creator: selectedAccount,
          session: session,
          groupName: state.name,
        ).valueOrThrow;

        ref.invalidate(_talksProvider);
      });
}
