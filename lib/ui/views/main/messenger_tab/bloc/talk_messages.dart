part of 'providers.dart';

@riverpod
class _TalkMessagesNotifier extends _$TalkMessagesNotifier {
  late String talkAddress;

  @override
  FutureOr<List<TalkMessage>> build(String talkAddress) async {
    this.talkAddress = talkAddress;
    final repository = ref.watch(MessengerProviders._messengerRepository);

    final account = await ref.watch(AccountProviders.selectedAccount.future);

    return await repository
        .getMessages(
          reader: account!,
          networkSettings: ref.watch(SettingsProviders.settings).network,
          session: ref.watch(SessionProviders.session).loggedIn!,
          talkAddress: talkAddress,
        )
        .valueOrThrow;
  }

  void refresh() {}

  void setMessageContent(String content) {}

  Future<void> createMessage(String content) async {
    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    final repository = ref.watch(MessengerProviders._messengerRepository);
    final session = ref.watch(SessionProviders.session).loggedIn;
    if (session == null) throw const Failure.loggedOut();

    final selectedAccount =
        await ref.watch(AccountProviders.selectedAccount.future);
    if (selectedAccount == null) throw const Failure.loggedOut();

    final messageCreated = await repository
        .sendMessage(
          talkAddress: talkAddress,
          content: content,
          creator: selectedAccount,
          networkSettings: ref.watch(SettingsProviders.settings).network,
          session: session,
        )
        .valueOrThrow;

    state = AsyncValue.data([
      ...loadedState,
      messageCreated,
    ]);
  }
}
