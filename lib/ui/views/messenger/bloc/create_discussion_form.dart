part of 'providers.dart';

final _createDiscussionFormProvider = NotifierProvider.autoDispose<
    CreateDiscussionFormNotifier, CreateDiscussionFormState>(
  () {
    return CreateDiscussionFormNotifier();
  },
);

@freezed
class CreateDiscussionFormState with _$CreateDiscussionFormState {
  const factory CreateDiscussionFormState({
    @Default('') String name,
    @Default([]) List<Contact> members,
    @Default([]) List<Contact> admins,
  }) = _CreateDiscussionFormState;
  const CreateDiscussionFormState._();

  bool get canSubmit => members.isNotEmpty;

  bool get canGoNext =>
      members.any((member) => PublicKey(member.publicKey).isValid);
}

class CreateDiscussionFormNotifier
    extends AutoDisposeNotifier<CreateDiscussionFormState> {
  CreateDiscussionFormNotifier();

  @override
  CreateDiscussionFormState build() => const CreateDiscussionFormState();

  void addMember(Contact member) {
    if (state.members.contains(member)) return;
    state = state.copyWith(
      members: [
        ...state.members,
        member,
      ],
    );
  }

  void removeMember(Contact member) {
    state = state.copyWith(
      members: state.members.where((element) => element != member).toList(),
    );
  }

  void addAdmin(Contact member) {
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

  Future<Result<void, Failure>> createDiscussion() => Result.guard(() async {
        final session = ref.read(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final creator = AccessRecipient.contact(
          contact: await ref.read(ContactProviders.getSelectedContact.future),
        );

        await ref
            .read(MessengerProviders._messengerRepository)
            .createDiscussion(
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
          discussionName: state.name,
        ).valueOrThrow;

        ref.invalidate(_discussionsProvider);
      });
}
