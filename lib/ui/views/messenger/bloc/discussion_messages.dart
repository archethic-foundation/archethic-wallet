part of 'providers.dart';

@freezed
class MessageCreationFormState with _$MessageCreationFormState {
  const factory MessageCreationFormState({
    required Discussion discussion,
    required String text,
    required bool isCreating,
  }) = _MessageCreationFormState;
  const MessageCreationFormState._();
}

@riverpod
class _MessageCreationFormNotifier extends _$MessageCreationFormNotifier {
  @override
  MessageCreationFormState build(Discussion discussion) =>
      MessageCreationFormState(
        discussion: discussion,
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

      final repository = ref.watch(MessengerProviders.messengerRepository);
      final session = ref.watch(SessionProviders.session).loggedIn;
      if (session == null) throw const Failure.loggedOut();

      final selectedAccount =
          await ref.watch(AccountProviders.accounts.future).selectedAccount;
      if (selectedAccount == null) throw const Failure.loggedOut();

      state = state.copyWith(isCreating: true);
      final messageCreated = await repository
          .sendMessage(
            discussionGenesisAddress: discussion.address,
            content: content,
            creator: selectedAccount,
            session: session,
            membersPublicKeysForNotifications: discussion.membersPubKeys,
          )
          .valueOrThrow;

      await ref
          .read(
            _paginatedDiscussionMessagesNotifierProvider(discussion.address)
                .notifier,
          )
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
  String discussionAddress,
  String content,
) async {
  final task = CancelableTask<double>(
    task: () async {
      final session = ref.watch(SessionProviders.session).loggedIn;
      if (session == null) throw const Failure.loggedOut();

      final selectedAccount =
          await ref.watch(AccountProviders.accounts.future).selectedAccount;
      if (selectedAccount == null) throw const Failure.loggedOut();

      final repository = ref.watch(MessengerProviders.messengerRepository);
      return repository
          .calculateFees(
            creator: selectedAccount,
            session: session,
            discussionGenesisAddress: discussionAddress,
            content: content,
          )
          .valueOrThrow;
    },
  );

  ref.onCancel(task.cancel);
  return task.schedule(const Duration(milliseconds: 800));
}

@riverpod
class _PaginatedDiscussionMessagesNotifier
    extends _$PaginatedDiscussionMessagesNotifier {
  static const _pageSize = 7;

  @override
  PagingController<int, DiscussionMessage> build(String discussionAddress) {
    final pagingController = PagingController<int, DiscussionMessage>(
      firstPageKey: 0,
    );
    _addPageRequestListener(pagingController);

    _addIncomingMessagesListener();

    ref.onDispose(() {
      _pagingController.dispose();
    });
    return pagingController;
  }

  Future _addIncomingMessagesListener() async {
    final selectedContact =
        await ref.read(ContactProviders.getSelectedContact.future);

    if (selectedContact == null) {
      return;
    }

    ref.listen(
      NotificationProviders.txSentEvents(selectedContact.publicKey),
      (_, event) async {
        final txEvent = event.valueOrNull;
        if (txEvent == null) return;

        if (txEvent.type == MessengerConstants.notificationTypeNewMessage) {
          final transaction = await sl.get<ApiService>().getTransaction(
            [txEvent.notificationRecipientAddress],
          );
          final discussionGenesisAddress =
              transaction.values.first.data?.recipients.first;

          if (discussionGenesisAddress == null ||
              discussionGenesisAddress != discussionAddress) {
            return;
          }

          if (_alreadyHasMessageWithAddress(
            txEvent.notificationRecipientAddress,
          )) {
            return;
          }

          final newMessage = (await ref.read(
            MessengerProviders.messages(
              discussionAddress,
              0,
              1,
            ).future,
          ))
              .last;

          if (_alreadyHasMessageWithAddress(newMessage.address)) {
            return;
          }
          await addMessage(newMessage);
        }
      },
    );
  }

  bool _alreadyHasMessageWithAddress(String address) =>
      _pagingController.value.itemList != null &&
      _pagingController.value.itemList!.any(
        (message) => message.address.toLowerCase() == address.toLowerCase(),
      );

  void _addPageRequestListener(
    PagingController<int, DiscussionMessage> pagingController,
  ) {
    pagingController.addPageRequestListener((offset) async {
      final nextPageItems = await ref.read(
        MessengerProviders.messages(
          discussionAddress,
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

      if (offset == 0 && nextPageItems.isNotEmpty) {
        await _updateDiscussionLastMessage(nextPageItems.first);
      }
    });
  }

  PagingController<int, DiscussionMessage> get _pagingController => state;
  set _pagingController(PagingController<int, DiscussionMessage> controller) {
    state.dispose();

    _addPageRequestListener(controller);
    state = controller;
  }

  Future<void> _updateDiscussionLastMessage(DiscussionMessage message) async {
    await ref
        .read(MessengerProviders.messengerRepository)
        .updateDiscussionLastMessage(
          discussionAddress: discussionAddress,
          creator: (await ref
              .read(AccountProviders.accounts.future)
              .selectedAccount)!,
          message: message,
        );
    ref.invalidate(_discussionProvider(discussionAddress));
  }

  Future<void> addMessage(DiscussionMessage messageCreated) async {
    _pagingController = PagingController<int, DiscussionMessage>.fromValue(
      PagingState(
        itemList: [messageCreated, ..._pagingController.itemList ?? []],
        nextPageKey: _pagingController.nextPageKey == null
            ? null
            : _pagingController.nextPageKey! + 1,
      ),
      firstPageKey: 0,
    );

    await _updateDiscussionLastMessage(messageCreated);
  }
}

@riverpod
Future<List<DiscussionMessage>> _discussionMessages(
  _DiscussionMessagesRef ref,
  String discussionAddress,
  int offset,
  int pageSize,
) async {
  final repository = ref.watch(MessengerProviders.messengerRepository);

  final account =
      await ref.watch(AccountProviders.accounts.future).selectedAccount;

  final messages = await repository
      .getMessages(
        reader: account!,
        session: ref.watch(SessionProviders.session).loggedIn!,
        discussionGenesisAddress: discussionAddress,
        pagingOffset: offset,
        limit: pageSize,
      )
      .valueOrThrow;

  return messages;
}
