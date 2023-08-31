import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/notification/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
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

part 'create_group_form.dart';
part 'providers.freezed.dart';
part 'providers.g.dart';
part 'talk_messages.dart';

@riverpod
class _Talks extends AutoDisposeAsyncNotifier<Iterable<Talk>> {
  @override
  FutureOr<Iterable<Talk>> build() async {
    final selectedAccount = await ref.watch(
      AccountProviders.selectedAccount.future,
    );
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

  Future<Talk> addRemoteTalk(Talk talk) async {
    final talks = state.valueOrNull;
    if (talks == null) throw const Failure.other();

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    if (selectedAccount == null) throw const Failure.loggedOut();

    final createdTalk = await ref
        .read(MessengerProviders._messengerRepository)
        .addRemoteTalk(
          creator: selectedAccount,
          talk: talk,
        )
        .valueOrThrow;

    ref.invalidateSelf();
    return createdTalk;
  }

  Future<void> removeTalk(Talk talk) async {
    final talks = state.valueOrNull;
    if (talks == null) throw const Failure.other();

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    if (selectedAccount == null) throw const Failure.loggedOut();

    await ref
        .read(MessengerProviders._messengerRepository)
        .removeTalk(
          owner: selectedAccount,
          talk: talk,
        )
        .valueOrThrow;

    ref.invalidateSelf();
  }
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
String _talkDisplayName(_TalkDisplayNameRef ref, Talk talk) {
  if (talk.name != null && talk.name!.isNotEmpty) return talk.name!;

  return ref
          .watch(
            ContactProviders.getSelectedContact,
          )
          .mapOrNull(
            data: (contactData) {
              final memberToDisplayPubKey =
                  talk.membersPubKeys.firstWhereOrNull(
                (memberPublicKey) =>
                    memberPublicKey != contactData.value.publicKey,
              );
              if (memberToDisplayPubKey == null) return null;

              return ref
                  .watch(
                    _accessRecipientWithPublicKeyProvider(
                      memberToDisplayPubKey,
                    ),
                  )
                  .asData;
            },
          )
          ?.value
          .name ??
      '...';
}

@riverpod
Future<AccessRecipient> _accessRecipientWithPublicKey(
  _AccessRecipientWithPublicKeyRef ref,
  String pubKey,
) async {
  final contact = await ref.watch(
    ContactProviders.getContactWithGenesisPublicKey(pubKey).future,
  );

  if (contact != null) return AccessRecipient.contact(contact: contact);
  return AccessRecipient.publicKey(publicKey: pubKey);
}

@riverpod
Future<Talk> _remoteTalk(_TalkRef ref, String address) async {
  final selectedAccount = await ref.watch(
    AccountProviders.selectedAccount.future,
  );
  if (selectedAccount == null) throw const Failure.loggedOut();

  final session = ref.read(SessionProviders.session).loggedIn;
  if (session == null) throw const Failure.loggedOut();

  return ref
      .watch(MessengerProviders._messengerRepository)
      .getRemoteTalk(
        currentAccount: selectedAccount,
        session: session,
        talkAddress: address,
      )
      .valueOrThrow;
}

@riverpod
Future<List<Talk>> _sortedTalks(_SortedTalksRef ref) async {
  final talks = await ref.watch(_talksProvider.future);
  return talks.sorted((a, b) => b.updateDate.compareTo(a.updateDate));
}

void _subscribeNotificationsWorker(WidgetRef ref) {
  ref.listen(_talksProvider, (previous, next) {
    final previousTalksAdresses =
        previous?.value?.map((talk) => talk.address.toLowerCase()).toSet() ??
            {};
    final nextTalksAdresses =
        next.value?.map((talk) => talk.address.toLowerCase()).toSet() ?? {};

    final talksToUnsubscribe =
        previousTalksAdresses.difference(nextTalksAdresses).toList();
    final talksToSubscribe =
        nextTalksAdresses.difference(previousTalksAdresses).toList();

    if (talksToUnsubscribe.isNotEmpty) {
      ref
          .read(NotificationProviders.repository)
          .unsubscribe(talksToUnsubscribe);
    }
    if (talksToSubscribe.isNotEmpty) {
      ref.read(NotificationProviders.repository).subscribe(talksToSubscribe);
    }
  });
}

abstract class MessengerProviders {
  static final _messengerRepository = Provider<MessengerRepositoryInterface>(
    (ref) => MessengerRepository(
      networksSetting: ref.watch(
        SettingsProviders.settings.select((settings) => settings.network),
      ),
    ),
  );

  /// Watches Talks creation/deletion to update notifications subscriptions
  static const subscribeNotificationsWorker = _subscribeNotificationsWorker;
  static final talks = _talksProvider;
  static final sortedTalks = _sortedTalksProvider;
  static const talk = _talkProvider;
  static const talkDisplayName = _talkDisplayNameProvider;
  static const accessRecipientWithPublicKey =
      _accessRecipientWithPublicKeyProvider;
  static const remoteTalk = _remoteTalkProvider;
  static const messages = _talkMessagesProvider;
  static const paginatedMessages = _paginatedTalkMessagesNotifierProvider;

  static final talkCreationForm = _createTalkFormProvider;
  static const messageCreationForm = _messageCreationFormNotifierProvider;
  static const messageCreationFees = _messageCreationFeesProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_messengerRepository).clear();
    ref
      ..invalidate(_talkProvider)
      ..invalidate(_createTalkFormProvider)
      ..invalidate(_talkMessagesProvider);
  }
}
