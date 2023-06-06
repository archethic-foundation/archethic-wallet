import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/repositories/messenger_repository.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/messenger/talk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

@riverpod
Future<Talk> _talk(_TalkRef ref, String talkId) async => ref
    .watch(MessengerProviders._messengerRepository)
    .getTalk(talkId)
    .valueOrThrow;

@riverpod
Future<List<String>> _talkIds(_TalkIdsRef ref) async => ref
    .watch(MessengerProviders._messengerRepository)
    .getTalkIds()
    .valueOrThrow;

abstract class MessengerProviders {
  static final _messengerRepository = Provider<MessengerRepositoryInterface>(
    (ref) => MessengerRepository(),
  );

  static final talkIds = _talkIdsProvider;

  static final talk = _talkProvider;

  static Future<Result<Talk, Failure>> createTalk({
    required WidgetRef ref,
    required String groupName,
    required List<Contact> admins,
    required List<Contact> members,
  }) =>
      Result.guard(() async {
        final session = ref.watch(SessionProviders.session).loggedIn;
        if (session == null) throw const Failure.loggedOut();

        final selectedAccount =
            await ref.watch(AccountProviders.selectedAccount.future);
        if (selectedAccount == null) throw const Failure.loggedOut();

        final talk = await ref
            .watch(_messengerRepository)
            .createTalk(
              networkSettings: ref.watch(SettingsProviders.settings).network,
              admins: admins,
              members: members,
              creator: selectedAccount,
              session: session,
              groupName: groupName,
            )
            .valueOrThrow;
        ref.invalidate(talkIds);

        return talk;
      });
}
