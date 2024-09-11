import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/ui/views/nft_search/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _nftSearchBarProvider =
    NotifierProvider.autoDispose<NftSearchBarNotifier, NftSearchBarFormState>(
  () {
    return NftSearchBarNotifier();
  },
);

class NftSearchBarNotifier extends AutoDisposeNotifier<NftSearchBarFormState> {
  NftSearchBarNotifier();

  @override
  NftSearchBarFormState build() => const NftSearchBarFormState();

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
      tokenInformation: null,
      error: '',
    );
  }

  Future<void> searchNFT(
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
      tokenInformation: null,
    );

    final tokenInformation = await ref.read(
      NFTProviders.getNFTInfo(
        searchCriteria,
        keychainServiceKeyPair,
      ).future,
    );

    if (tokenInformation == null) {
      state =
          state.copyWith(error: localizations!.invalidAddress, loading: false);
      return;
    }
    state = state.copyWith(
      tokenInformation: tokenInformation,
      searchCriteria: '',
      error: '',
      loading: false,
    );
  }
}

abstract class NftSearchBarFormProvider {
  static final nftSearchBar = _nftSearchBarProvider;
}
