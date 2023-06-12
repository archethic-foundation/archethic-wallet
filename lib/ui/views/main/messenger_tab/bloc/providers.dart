import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/repositories/messenger_repository.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:aewallet/ui/views/main/messenger_tab/components/add_public_key_textfield_pk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_talk_form.dart';
part 'providers.freezed.dart';
part 'providers.g.dart';
part 'talk_messages.dart';

@riverpod
Future<Talk> _talk(_TalkRef ref, String talkId) async => ref
    .watch(MessengerProviders._messengerRepository)
    .getTalk(talkId)
    .valueOrThrow;

@riverpod
Future<List<String>> _talkAddresses(_TalkAddressesRef ref) async => ref
    .watch(MessengerProviders._messengerRepository)
    .getTalkAddresses()
    .valueOrThrow;

abstract class MessengerProviders {
  static final _messengerRepository = Provider<MessengerRepositoryInterface>(
    (ref) => MessengerRepository(),
  );

  static final talkAddresses = _talkAddressesProvider;

  static const talk = _talkProvider;

  static final creationForm = _createTalkFormProvider;
  static const messages = _talkMessagesNotifierProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_messengerRepository).clear();
    ref
      ..invalidate(talkAddresses)
      ..invalidate(talk)
      ..invalidate(creationForm)
      ..invalidate(messages);
  }
}
