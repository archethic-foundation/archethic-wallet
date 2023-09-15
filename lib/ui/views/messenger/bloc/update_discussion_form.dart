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

  int get numberOfMembers => members.length;
  List<String> get listMembers => members;
  List<String> get listAdmins => admins;
}

class UpdateDiscussionFormNotifier
    extends AutoDisposeNotifier<UpdateDiscussionFormState> {
  UpdateDiscussionFormNotifier();

  late AppLocalizations localizations;

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

  void removeMember(String member) {
    state = state.copyWith(
      members: state.members.where((element) => element != member).toList(),
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

  void removeAdmin(String admin) {
    state = state.copyWith(
      admins: state.admins.where((element) => element != admin).toList(),
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

  String? validator() {
    if (state.name.isEmpty) {
      return localizations.discussionNameMandatory;
    }
    if (state.members.length < 2) {
      return localizations.discussionAtLeastTwoMembers;
    }
    if (state.admins.isEmpty) {
      return localizations.discussionAtLeastOneAdmin;
    }
    return null;
  }

  Future<Result<String?, Failure>> updateDiscussion() => Result.guard(() async {
        final errorMessage = validator();
        if (errorMessage != null) {
          return errorMessage;
        }
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

        return null;
      });
}
