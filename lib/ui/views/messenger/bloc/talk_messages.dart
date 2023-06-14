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
          .read(_paginatedTalkMessagesNotifierProvider(talkAddress).notifier)
          .addMessage(messageCreated);

      await repository.saveMessage(
        talkAddress: talkAddress,
        creator: selectedAccount,
        message: messageCreated,
      );
      ref.invalidate(_talkProvider(talkAddress));

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
class _PaginatedTalkMessagesNotifier extends _$PaginatedTalkMessagesNotifier {
  static const _pageSize = 10;

  @override
  PagingController<int, TalkMessage> build(String talkAddress) {
    final pagingController = PagingController<int, TalkMessage>(
      firstPageKey: 0,
    );
    _addPageRequestListener(pagingController);

    ref.onDispose(() {
      state.dispose();
    });
    return pagingController;
  }

  void _addPageRequestListener(
    PagingController<int, TalkMessage> pagingController,
  ) {
    pagingController.addPageRequestListener((offset) async {
      final nextPageItems = await ref.read(
        MessengerProviders.messages(
          talkAddress,
          offset,
          _pageSize,
        ).future,
      );

      final isLastPage = nextPageItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(nextPageItems);
      } else {
        pagingController.appendPage(
          nextPageItems,
          offset + nextPageItems.length,
        );
      }
    });
  }

  set _pagingController(PagingController<int, TalkMessage> controller) {
    state.dispose();

    _addPageRequestListener(controller);
    state = controller;
  }

  void addMessage(TalkMessage messageCreated) {
    _pagingController = PagingController<int, TalkMessage>.fromValue(
      PagingState(
        itemList: [messageCreated, ...state.itemList ?? []],
        nextPageKey: state.nextPageKey == null ? null : state.nextPageKey! + 1,
      ),
      firstPageKey: 0,
    );
  }
}

@riverpod
Future<List<TalkMessage>> _talkMessages(
  _TalkMessagesRef ref,
  String talkAddress,
  int offset,
  int pageSize,
) async {
  final repository = ref.watch(MessengerProviders._messengerRepository);

  final account = await ref.watch(AccountProviders.selectedAccount.future);

  final messages = await repository
      .getMessages(
        reader: account!,
        session: ref.watch(SessionProviders.session).loggedIn!,
        talkAddress: talkAddress,
        pagingOffset: offset,
        limit: pageSize,
      )
      .valueOrThrow;

  return messages;
}
