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
    @Default([]) List<String> membersToAdd,
    @Default([]) List<String> admins,
    @Default([]) List<String> initialMembers,
    @Default([]) List<String> initialAdmins,
  }) = _UpdateDiscussionFormState;
  const UpdateDiscussionFormState._();

  int get numberOfMembers => members.length;
  List<String> get listMembers => members;
  List<String> get listAdmins => admins;
  bool get canAddMembers => membersToAdd.isNotEmpty;
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
    _initializeMembers(discussion.membersPubKeys);
    _initializeAdmins(discussion.adminsPubKeys);
    _setInitialMembersAndAdmins();
  }

  void _initializeMembers(List<String> members) {
    for (final member in members) {
      addMember(member);
    }
  }

  void _initializeAdmins(List<String> admins) {
    for (final admin in admins) {
      addAdmin(admin);
    }
  }

  void _setInitialMembersAndAdmins() {
    state = state.copyWith(
      initialAdmins: state.admins.toList(),
      initialMembers: state.members.toList(),
    );
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
    // If the members was an admin, bye-bye
    removeAdmin(member);
  }

  void addMemberToAdd(String member) {
    if (state.membersToAdd.contains(member)) return;
    state = state.copyWith(
      membersToAdd: [
        ...state.membersToAdd,
        member,
      ],
    );
  }

  void removeMemberToAdd(String member) {
    state = state.copyWith(
      membersToAdd:
          state.membersToAdd.where((element) => element != member).toList(),
    );
  }

  void removeAllMembersToAdd() {
    state = state.copyWith(
      membersToAdd: [],
    );
  }

  void addAllMembersToAdd() {
    for (final member in state.membersToAdd) {
      addMember(member);
    }
    removeAllMembersToAdd();
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

  Future<Result<String?, Failure>> updateDiscussion(
    WidgetRef ref,
    BuildContext context,
  ) =>
      Result.guard(() async {
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

        final membersDeleted = Set.from(state.initialMembers)
            .difference(Set.from(state.listMembers));
        final membersAdded = Set.from(state.listMembers)
            .difference(Set.from(state.initialMembers));

        var updateAESKey = false;

        // When there is at least one member that has been deleted from the discussion
        // we are going to renew the AES key to not let the previous users
        // (the one that are going to be deleted) read the next messages
        if (membersDeleted.isNotEmpty) {
          updateAESKey = true;
        } else {
          // When there is at least one new member in the discussion, we will ask the
          // user to choose if he wants to let the new user read the previous messages
          if (membersAdded.isNotEmpty) {
            await AppDialogs.showConfirmDialog(
              context,
              ref,
              localizations.information,
              localizations.doYouWantNewUsersReadOldMessages,
              localizations.yes,
              () {
                updateAESKey = true;
              },
              cancelText: localizations.no,
            );
          }
        }

        await ref
            .read(MessengerProviders.messengerRepository)
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
              updateSCAESKey: updateAESKey,
              membersDeletedToNotify:
                  List<String>.from(membersDeleted.toList()),
              membersAddedToNotify: List<String>.from(membersAdded.toList()),
            )
            .valueOrThrow;

        ref.invalidate(_discussionProvider);

        return null;
      });
}
