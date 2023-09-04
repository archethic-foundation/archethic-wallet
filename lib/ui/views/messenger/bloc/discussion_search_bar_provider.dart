import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_state.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_search_bar_provider.g.dart';

abstract class DiscussionSearchBarProvider {
  static final discussionSearchBar = _discussionSearchBarNotifierProvider;
}

@riverpod
class _DiscussionSearchBarNotifier
    extends AutoDisposeNotifier<DiscussionSearchBarState> {
  @override
  DiscussionSearchBarState build() => const DiscussionSearchBarState();

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
      discussion: null,
      searchCriteria: '',
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
      discussion: null,
    );

    try {
      final discussion = await ref.read(
        MessengerProviders.remoteDiscussion(
          searchCriteria,
        ).future,
      );

      if (discussion.address.isEmpty) {
        state = state.copyWith(
          error: localizations!.invalidAddress,
          loading: false,
        );
        return;
      }
      state = state.copyWith(
        discussion: discussion,
        searchCriteria: '',
        error: '',
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: localizations!.messengerDiscussionNotFound,
        loading: false,
      );
    }
  }
}
