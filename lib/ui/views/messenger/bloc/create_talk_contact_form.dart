part of 'providers.dart';

final _createTalkContactFormProvider = NotifierProvider.autoDispose<
    CreateTalkContactFormNotifier, CreateTalkContactFormState>(
  () {
    return CreateTalkContactFormNotifier();
  },
);

@freezed
class CreateTalkContactFormState with _$CreateTalkContactFormState {
  const factory CreateTalkContactFormState({
    required String name,
    required List<AccessRecipient> members,
  }) = _CreateTalkContactFormState;
  const CreateTalkContactFormState._();
}

class CreateTalkContactFormNotifier
    extends AutoDisposeNotifier<CreateTalkContactFormState> {
  CreateTalkContactFormNotifier();

  @override
  CreateTalkContactFormState build() => const CreateTalkContactFormState(
        name: '',
        members: [],
      );

  void addMember(AccessRecipient member) {
    if (state.members.contains(member)) return;
    state = state.copyWith(
      members: [
        ...state.members,
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
