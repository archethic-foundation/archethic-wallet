part of 'providers.dart';

final _createDiscussionContactFormProvider = NotifierProvider.autoDispose<
    CreateDiscussionContactFormNotifier, CreateDiscussionContactFormState>(
  () {
    return CreateDiscussionContactFormNotifier();
  },
);

@freezed
class CreateDiscussionContactFormState with _$CreateDiscussionContactFormState {
  const factory CreateDiscussionContactFormState({
    @Default('') String name,
    @Default([]) List<AccessRecipient> members,
  }) = _CreateDiscussionContactFormState;
  const CreateDiscussionContactFormState._();
}

class CreateDiscussionContactFormNotifier
    extends AutoDisposeNotifier<CreateDiscussionContactFormState> {
  CreateDiscussionContactFormNotifier();

  @override
  CreateDiscussionContactFormState build() =>
      const CreateDiscussionContactFormState();

  void addMember(AccessRecipient member) {
    if (state.members.contains(member)) return;
    state = state.copyWith(
      members: [
        ...state.members,
        member,
      ],
    );
  }

  void setName(
    String name,
  ) {
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
