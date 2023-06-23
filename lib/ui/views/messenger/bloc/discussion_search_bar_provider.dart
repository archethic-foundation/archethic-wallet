import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_state.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _initialDiscussionSearchBarProvider = Provider<DiscussionSearchBarState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _discussionSearchBarProvider = NotifierProvider.autoDispose<
    DiscussionSearchBarNotifier, DiscussionSearchBarState>(
  () {
    return DiscussionSearchBarNotifier();
  },
  dependencies: [
    MessengerProviders.remoteTalk,
    DiscussionSearchBarProvider.initialDiscussionSearchBar,
  ],
);

abstract class DiscussionSearchBarProvider {
  static final discussionSearchBar = _discussionSearchBarProvider;
  static final initialDiscussionSearchBar = _initialDiscussionSearchBarProvider;
}

class DiscussionSearchBarNotifier
    extends AutoDisposeNotifier<DiscussionSearchBarState> {
  DiscussionSearchBarNotifier();

  @override
  DiscussionSearchBarState build() => ref.watch(
        DiscussionSearchBarProvider.initialDiscussionSearchBar,
      );

  void setError(String error) {
    state = state.copyWith(
      error: error,
    );
  }

  void setSearchCriteria(String searchCriteria) {
    state = state.copyWith(
      searchCriteria: searchCriteria,
    );
  }

  void reset() {
    state = state.copyWith(
      loading: false,
      talk: null,
      error: '',
    );
  }

  Future<void> searchDiscussion(
    String searchCriteria,
    BuildContext context,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final localizations = AppLocalizations.of(context);
    if (searchCriteria.isEmpty) {
      state = state.copyWith(error: localizations!.addressMissing);
      return;
    }

    if (!Address(
      address: searchCriteria,
    ).isValid()) {
      state = state.copyWith(error: localizations!.invalidAddress);
      return;
    }

    state = state.copyWith(
      loading: true,
      talk: null,
    );

    final talk = await ref.read(
      MessengerProviders.remoteTalk(
        searchCriteria,
      ).future,
    );

    if (talk.address.isEmpty) {
      state =
          state.copyWith(error: localizations!.invalidAddress, loading: false);
      return;
    }
    state = state.copyWith(
      talk: talk,
      searchCriteria: '',
      error: '',
      loading: false,
    );
  }
}
