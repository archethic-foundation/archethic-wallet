part of 'providers.dart';

final _updateDiscussionFormProvider = NotifierProvider.autoDispose<
    UpdateDiscussionFormNotifier, UpdateDiscussionFormState>(
  () {
    return UpdateDiscussionFormNotifier();
  },
);

@freezed
class UpdateDiscussionFormState with _$UpdateDiscussionFormState {
  const factory UpdateDiscussionFormState({
    @Default('') String name,
    @Default('') String discussionAddress,
    @Default([]) List<String> members,
    @Default([]) List<String> admins,
  }) = _UpdateDiscussionFormState;
  const UpdateDiscussionFormState._();

  bool get canSubmit =>
      name.isNotEmpty && members.isNotEmpty && admins.isNotEmpty;
}

class UpdateDiscussionFormNotifier
    extends AutoDisposeNotifier<UpdateDiscussionFormState> {
  UpdateDiscussionFormNotifier();

  @override
  UpdateDiscussionFormState build() => const UpdateDiscussionFormState();

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

  void removeMember(String member) {
    state = state.copyWith(
      members: state.members.where((element) => element != member).toList(),
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

  Future<void> setAddress(
    String address,
  ) async {
    state = state.copyWith(
      discussionAddress: address,
    );
    return;
  }

  Future<Result<void, Failure>> updateDiscussion() => Result.guard(() async {
        final session = ref.read(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final keyPair = session.wallet.keychainSecuredInfos
            .services[selectedAccount.name]!.keyPair!.toKeyPair;

        await ref
            .read(MessengerProviders._messengerRepository)
            .updateDiscussion(
              discussionSCAddress: state.discussionAddress,
              adminsPubKeys: state.admins,
              membersPubKeys: state.members,
              discussionName: state.name,
              adminAddress: selectedAccount.lastAddress!,
              serviceName: selectedAccount.name,
              session: session,
              adminKeyPair: keyPair,
              owner: selectedAccount,
            )
            .valueOrThrow;

        ref.invalidate(_discussionProvider);
      });
}
