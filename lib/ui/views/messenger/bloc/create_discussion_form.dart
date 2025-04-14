part of 'providers.dart';

@freezed
class CreateDiscussionFormState with _$CreateDiscussionFormState {
  const factory CreateDiscussionFormState({
    @Default('') String name,
    @Default([]) List<Contact> members,
    @Default([]) List<Contact> admins,
  }) = _CreateDiscussionFormState;
  const CreateDiscussionFormState._();

  bool get canSubmit => members.isNotEmpty && name.isNotEmpty;

  bool get canGoNext =>
      members.isNotEmpty &&
      members.none((member) => PublicKey(member.publicKey).isValid == false);

  List<Contact> get membersList => members;
}

@riverpod
class _CreateDiscussionFormNotifier extends _$CreateDiscussionFormNotifier {
  @override
  _CreateDiscussionFormState build() => const _CreateDiscussionFormState();

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

  void removeAllMembers() {
    state = state.copyWith(
      members: [],
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

  void resetValidation() {
    setName('');
  }

  Future<Result<void, Failure>> createDiscussion() => Result.guard(() async {
        final session = ref.read(sessionNotifierProvider).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.accounts.future).selectedAccount;
        if (selectedAccount == null) throw const Failure.loggedOut();
        final selectedAccountPubKey = selectedAccount.publicKey;
        if (selectedAccountPubKey == null || selectedAccountPubKey.isEmpty) {
          throw const Failure.other(message: 'No public key found');
        }

        await ref.read(MessengerProviders.messengerRepository).createDiscussion(
          adminsPubKeys: [
            ...state.admins.map((recipient) => recipient.publicKey),
            selectedAccountPubKey,
          ],
          membersPubKeys: [
            ...state.members.map((recipient) => recipient.publicKey),
            selectedAccountPubKey,
          ],
          creator: selectedAccount,
          session: session,
          discussionName: state.name,
          apiService: ref.watch(apiServiceProvider),
        ).valueOrThrow;

        ref.invalidate(_discussionsProvider);
      });
}
