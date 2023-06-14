import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/repositories/messenger_repository.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/messenger/layouts/components/add_public_key_textfield_pk.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_talk_form.dart';
part 'providers.freezed.dart';
part 'providers.g.dart';
part 'talk_messages.dart';

@riverpod
Future<Iterable<Talk>> _talks(_TalksRef ref) async {
  final selectedAccount =
      await ref.watch(AccountProviders.selectedAccount.future);
  if (selectedAccount == null) throw const Failure.loggedOut();

  final repository = ref.watch(MessengerProviders._messengerRepository);

  final talkAddresses = await repository
      .getTalkAddresses(
        owner: selectedAccount,
      )
      .valueOrThrow;

  return Future.wait(
    talkAddresses.map(
      (talkAddress) => ref.watch(_talkProvider(talkAddress).future),
    ),
  );
}

@riverpod
Future<Talk> _talk(_TalkRef ref, String address) async {
  final selectedAccount = await ref.watch(
    AccountProviders.selectedAccount.future,
  );
  if (selectedAccount == null) throw const Failure.loggedOut();

  return ref
      .watch(MessengerProviders._messengerRepository)
      .getTalk(
        owner: selectedAccount,
        talkAddress: address,
      )
      .valueOrThrow;
}

@riverpod
Future<List<Talk>> _sortedTalks(_SortedTalksRef ref) async {
  final talks = await ref.watch(_talksProvider.future);
  return talks.sorted((a, b) => b.updateDate.compareTo(a.updateDate));
}

abstract class MessengerProviders {
  static final _messengerRepository = Provider<MessengerRepositoryInterface>(
    (ref) => MessengerRepository(),
  );

  static final talks = _talksProvider;
  static final sortedTalks = _sortedTalksProvider;
  static const talk = _talkProvider;
  static const messages = _talkMessagesProvider;
  static const paginatedMessages = _paginatedTalkMessagesNotifierProvider;

  static final talkCreationForm = _createTalkFormProvider;
  static const messageCreationForm = _messageCreationFormNotifierProvider;
  static const messageCreationFees = _messageCreationFeesProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_messengerRepository).clear();
    ref
      ..invalidate(talks)
      ..invalidate(talkCreationForm)
      ..invalidate(messages);
  }
}
