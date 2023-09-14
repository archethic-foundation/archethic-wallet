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
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_discussion_form.dart';
part 'discussion_messages.dart';
part 'providers.freezed.dart';
part 'providers.g.dart';
part 'update_discussion_form.dart';

@riverpod
class _Discussions extends AutoDisposeAsyncNotifier<Iterable<Discussion>> {
  @override
  FutureOr<Iterable<Discussion>> build() async {
    final selectedAccount = await ref.watch(
      AccountProviders.selectedAccount.future,
    );
    if (selectedAccount == null) throw const Failure.loggedOut();

    final repository = ref.watch(MessengerProviders._messengerRepository);

    final discussionAddresses = await repository
        .getDiscussionAddresses(
          owner: selectedAccount,
        )
        .valueOrThrow;

    return Future.wait(
      discussionAddresses.map(
        (discussionAddress) =>
            ref.watch(_discussionProvider(discussionAddress).future),
      ),
    );
  }

  Future<Discussion> addRemoteDiscussion(Discussion discussion) async {
    final discussions = state.valueOrNull;
    if (discussions == null) throw const Failure.other();

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    if (selectedAccount == null) throw const Failure.loggedOut();

    final createdDiscussion = await ref
        .read(MessengerProviders._messengerRepository)
        .addRemoteDiscussion(
          creator: selectedAccount,
          discussion: discussion,
        )
        .valueOrThrow;

    ref.invalidateSelf();
    return createdDiscussion;
  }

  Future<void> removeDiscussion(Discussion discussion) async {
    final discussions = state.valueOrNull;
    if (discussions == null) throw const Failure.other();

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    if (selectedAccount == null) throw const Failure.loggedOut();

    await ref
        .read(MessengerProviders._messengerRepository)
        .removeDiscussion(
          owner: selectedAccount,
          discussion: discussion,
        )
        .valueOrThrow;

    ref.invalidateSelf();
  }
}

@riverpod
Future<Discussion> _discussion(_DiscussionRef ref, String address) async {
  final selectedAccount = await ref.watch(
    AccountProviders.selectedAccount.future,
  );
  if (selectedAccount == null) throw const Failure.loggedOut();

  return ref
      .watch(MessengerProviders._messengerRepository)
      .getDiscussion(
        owner: selectedAccount,
        discussionAddress: address,
      )
      .valueOrThrow;
}

@riverpod
String _discussionDisplayName(
  _DiscussionDisplayNameRef ref,
  Discussion discussion,
) {
  if (discussion.name != null && discussion.name!.isNotEmpty) {
    return discussion.name!;
  }
  return ref
          .watch(
            ContactProviders.getSelectedContact,
          )
          .mapOrNull(
            data: (contactData) {
              final memberToDisplayPubKey =
                  discussion.membersPubKeys.firstWhereOrNull(
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
Future<Discussion> _remoteDiscussion(
  _RemoteDiscussionRef ref,
  String address,
) async {
  final selectedAccount = await ref.watch(
    AccountProviders.selectedAccount.future,
  );
  if (selectedAccount == null) throw const Failure.loggedOut();

  final session = ref.read(SessionProviders.session).loggedIn;
  if (session == null) throw const Failure.loggedOut();

  return ref
      .watch(MessengerProviders._messengerRepository)
      .getRemoteDiscussion(
        currentAccount: selectedAccount,
        session: session,
        discussionGenesisAddress: address,
      )
      .valueOrThrow;
}

@riverpod
Future<List<Discussion>> _sortedDiscussions(_SortedDiscussionsRef ref) async {
  final discussions = await ref.watch(_discussionsProvider.future);
  return discussions.sorted((a, b) => b.updateDate.compareTo(a.updateDate));
}

void _subscribeNotificationsWorker(WidgetRef ref) {
  ref.listen(_discussionsProvider, (previous, next) {
    final previousDiscussionsAddress = previous?.value
            ?.map((discussion) => discussion.address.toLowerCase())
            .toSet() ??
        {};
    final nextDiscussionsAddress = next.value
            ?.map((discussion) => discussion.address.toLowerCase())
            .toSet() ??
        {};

    final discussionsToUnsubscribe =
        previousDiscussionsAddress.difference(nextDiscussionsAddress).toList();
    final discussionsToSubscribe =
        nextDiscussionsAddress.difference(previousDiscussionsAddress).toList();

    if (discussionsToUnsubscribe.isNotEmpty) {
      ref
          .read(NotificationProviders.repository)
          .unsubscribe(discussionsToUnsubscribe);
    }
    if (discussionsToSubscribe.isNotEmpty) {
      ref
          .read(NotificationProviders.repository)
          .subscribe(discussionsToSubscribe);
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

  /// Watches Discussions creation/deletion to update notifications subscriptions
  static const subscribeNotificationsWorker = _subscribeNotificationsWorker;
  static final discussions = _discussionsProvider;
  static final sortedDiscussions = _sortedDiscussionsProvider;
  static const discussion = _discussionProvider;
  static const discussionDisplayName = _discussionDisplayNameProvider;
  static const accessRecipientWithPublicKey =
      _accessRecipientWithPublicKeyProvider;
  static const remoteDiscussion = _remoteDiscussionProvider;
  static const messages = _discussionMessagesProvider;
  static const paginatedMessages = _paginatedDiscussionMessagesNotifierProvider;

  static final createDiscussionForm = _createDiscussionFormProvider;
  static const messageCreationForm = _messageCreationFormNotifierProvider;
  static const messageCreationFees = _messageCreationFeesProvider;
  static final updateDiscussionForm = _updateDiscussionFormProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_messengerRepository).clear();
    ref
      ..invalidate(_discussionProvider)
      ..invalidate(_createDiscussionFormProvider)
      ..invalidate(_discussionMessagesProvider);
  }
}
