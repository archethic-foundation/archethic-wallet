part of 'providers.dart';

final _discussionDetailsFormProvider = NotifierProvider.autoDispose<
    DiscussionDetailsFormNotifier, DiscussionDetailsFormState>(
  () {
    return DiscussionDetailsFormNotifier();
  },
);

@freezed
class DiscussionDetailsFormState with _$DiscussionDetailsFormState {
  const factory DiscussionDetailsFormState({
    @Default('') String name,
    @Default('') String discussionAddress,
    @Default([]) List<String> members,
    @Default([]) List<String> admins,
  }) = _DiscussionDetailsFormState;
  const DiscussionDetailsFormState._();
}

class DiscussionDetailsFormNotifier
    extends AutoDisposeNotifier<DiscussionDetailsFormState> {
  DiscussionDetailsFormNotifier();

  late AppLocalizations localizations;

  @override
  DiscussionDetailsFormState build() => const DiscussionDetailsFormState();

  void init(Discussion discussion) {
    setName(discussion.name ?? '');
    setAddress(discussion.address);
    _initMembers(discussion.membersPubKeys);
    _initAdmins(discussion.adminsPubKeys);
  }

  void _initMembers(List<String> members) {
    for (final member in members) {
      addMember(member);
    }
  }

  void _initAdmins(List<String> admins) {
    for (final admin in admins) {
      addAdmin(admin);
    }
  }

  Future<void> setName(
    String name,
  ) async {
    state = state.copyWith(
      name: name,
    );
    return;
  }

  Future<void> setAddress(
    String address,
  ) async {
    state = state.copyWith(
      discussionAddress: address,
    );
    return;
  }

  void addMember(String member) {
    if (state.members.contains(member)) return;
    state = state.copyWith(
      members: [
        ...state.members,
        member,
      ],
    );
  }

  void addAdmin(String admin) {
    if (state.admins.contains(admin)) return;
    state = state.copyWith(
      admins: [
        ...state.admins,
        admin,
      ],
    );
  }

  Future<Result<void, Failure>> leaveDiscussion() => Result.guard(() async {
        final session = ref.read(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final selectedContact =
            await ref.watch(ContactProviders.getSelectedContact.future);
        if (selectedContact == null) throw const Failure.loggedOut();

        final keyPair = session.wallet.keychainSecuredInfos
            .services[selectedAccount.name]!.keyPair!.toKeyPair;

        await ref
            .read(MessengerProviders.messengerRepository)
            .updateDiscussion(
              discussionSCAddress: state.discussionAddress,
              adminsPubKeys: state.admins
                  .where((element) => element != selectedContact.publicKey)
                  .toList(),
              membersPubKeys: state.members
                  .where((element) => element != selectedContact.publicKey)
                  .toList(),
              discussionName: state.name,
              adminAddress: selectedAccount.lastAddress!,
              serviceName: selectedAccount.name,
              session: session,
              adminKeyPair: keyPair,
              owner: selectedAccount,
              updateSCAESKey:
                  true, // the user is not going to read the next messages
            )
            .valueOrThrow;

        ref.invalidate(_discussionProvider);
      });
}
