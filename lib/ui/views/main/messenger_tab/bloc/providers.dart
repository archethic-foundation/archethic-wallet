import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/repositories/messenger_repository.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/create_talk_form.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<Talk> _talk(_TalkRef ref, String talkId) async => ref
    .watch(MessengerProviders.messengerRepository)
    .getTalk(talkId)
    .valueOrThrow;

@riverpod
Future<List<String>> _talkIds(_TalkIdsRef ref) async =>
    ref.watch(MessengerProviders.messengerRepository).getTalkIds().valueOrThrow;

abstract class MessengerProviders {
  static final messengerRepository = Provider<MessengerRepositoryInterface>(
    (ref) => MessengerRepository(),
  );

  static final talkIds = _talkIdsProvider;

  static const talk = _talkProvider;

  static final creationForm = createTalkFormProvider;
}
