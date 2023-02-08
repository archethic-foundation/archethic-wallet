import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _initialNftSearchBarProvider = Provider<NftSearchBarState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _nftSearchBarProvider =
    NotifierProvider.autoDispose<NftSearchBarNotifier, NftSearchBarState>(
  () {
    return NftSearchBarNotifier();
  },
  dependencies: [
    NFTProviders.getNFT,
    NftSearchBarProvider.initialNftSearchBar,
  ],
);

abstract class NftSearchBarProvider {
  static final nftSearchBar = _nftSearchBarProvider;
  static final initialNftSearchBar = _initialNftSearchBarProvider;
}

class NftSearchBarNotifier extends AutoDisposeNotifier<NftSearchBarState> {
  NftSearchBarNotifier();

  @override
  NftSearchBarState build() => ref.watch(
        NftSearchBarProvider.initialNftSearchBar,
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
      tokenInformations: null,
      error: '',
    );
  }

  Future<void> searchNFT(
    String searchCriteria,
    BuildContext context,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final localizations = AppLocalization.of(context);
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
      tokenInformations: null,
    );

    final tokenInformations = await ref.read(
      NFTProviders.getNFT(
        searchCriteria,
        keychainServiceKeyPair,
      ).future,
    );

    if (tokenInformations == null) {
      state =
          state.copyWith(error: localizations!.invalidAddress, loading: false);
      return;
    }
    state = state.copyWith(
      tokenInformations: tokenInformations,
      searchCriteria: '',
      error: '',
      loading: false,
    );
  }
}
