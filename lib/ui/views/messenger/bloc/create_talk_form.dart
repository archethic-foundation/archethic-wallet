part of 'providers.dart';

final _createTalkFormProvider =
    NotifierProvider.autoDispose<CreateTalkFormNotifier, CreateTalkFormState>(
  () {
    return CreateTalkFormNotifier();
  },
);

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

  bool get canSubmit => members.isNotEmpty;
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

  Future<Result<void, Failure>> createTalk() => Result.guard(() async {
        final session = ref.read(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final creator = AccessRecipient.contact(
          contact: await ref.read(ContactProviders.getSelectedContact.future),
        );

        final talk =
            await ref.read(MessengerProviders._messengerRepository).createTalk(
          admins: [
            ...state.admins,
            creator,
          ],
          members: [
            ...state.members,
            creator,
          ],
          creator: selectedAccount,
          session: session,
          groupName: state.name,
        ).valueOrThrow;

        ref.read(NotificationProviders.repository).subscribe(talk.address);
        ref.invalidate(MessengerProviders.talks);
      });
}
