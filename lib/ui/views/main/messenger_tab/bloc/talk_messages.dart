part of 'providers.dart';

@freezed
class MessageCreationFormState with _$MessageCreationFormState {
  const factory MessageCreationFormState({
    required String talkAddress,
    required String text,
    required bool isCreating,
  }) = _MessageCreationFormState;
  const MessageCreationFormState._();
}

@riverpod
class _MessageCreationFormNotifier extends _$MessageCreationFormNotifier {
  @override
  MessageCreationFormState build(String talkAddress) =>
      MessageCreationFormState(
        talkAddress: talkAddress,
        text: '',
        isCreating: false,
      );

  void setText(String text) {
    if (text == state.text) return;

    state = state.copyWith(text: text);
  }

  Future<void> createMessage() async {
    try {
      final content = state.text;

      final repository = ref.watch(MessengerProviders._messengerRepository);
      final session = ref.watch(SessionProviders.session).loggedIn;
      if (session == null) throw const Failure.loggedOut();

      final selectedAccount =
          await ref.watch(AccountProviders.selectedAccount.future);
      if (selectedAccount == null) throw const Failure.loggedOut();

      state = state.copyWith(isCreating: true);
      final messageCreated = await repository
          .sendMessage(
            talkAddress: talkAddress,
            content: content,
            creator: selectedAccount,
            session: session,
          )
          .valueOrThrow;

      ref
          .read(_talkMessagesNotifierProvider(talkAddress).notifier)
          .addMessage(messageCreated);

      state = state.copyWith(
        text: '',
        isCreating: false,
      );
    } catch (e) {
      state = state.copyWith(
        isCreating: false,
      );
      rethrow;
    }
  }
}

@riverpod
Future<double> _messageCreationFees(
  _MessageCreationFeesRef ref,
  String talkAddress,
  String content,
) async {
  final task = CancelableTask<double>(
    task: () async {
      final session = ref.watch(SessionProviders.session).loggedIn;
      if (session == null) throw const Failure.loggedOut();

      final selectedAccount =
          await ref.watch(AccountProviders.selectedAccount.future);
      if (selectedAccount == null) throw const Failure.loggedOut();

      final repository = ref.watch(MessengerProviders._messengerRepository);
      return repository
          .calculateFees(
            creator: selectedAccount,
            session: session,
            talkAddress: talkAddress,
            content: content,
          )
          .valueOrThrow;
    },
  );

  ref.onCancel(task.cancel);
  return task.schedule(const Duration(milliseconds: 800));
}

@riverpod
class _TalkMessagesNotifier extends _$TalkMessagesNotifier {
  @override
  FutureOr<List<TalkMessage>> build(String talkAddress) async {
    final repository = ref.watch(MessengerProviders._messengerRepository);

    final account = await ref.watch(AccountProviders.selectedAccount.future);

    return await repository
        .getMessages(
          reader: account!,
          session: ref.watch(SessionProviders.session).loggedIn!,
          talkAddress: talkAddress,
        )
        .valueOrThrow;
  }

  void addMessage(TalkMessage message) {
    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    state = AsyncValue.data([
      ...loadedState,
      message,
    ]);
  }
}
