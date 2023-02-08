import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _initialContactCreationFormProvider = Provider<ContactCreationFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _contactCreationFormProvider = NotifierProvider.autoDispose<
    ContactCreationFormNotifier, ContactCreationFormState>(
  () {
    return ContactCreationFormNotifier();
  },
  dependencies: [
    ContactCreationFormProvider.initialContactCreationForm,
    ContactProviders.isContactExistsWithName,
    ContactProviders.isContactExistsWithAddress,
    connectivityStatusProviders,
  ],
);

class ContactCreationFormNotifier
    extends AutoDisposeNotifier<ContactCreationFormState> {
  ContactCreationFormNotifier();

  @override
  ContactCreationFormState build() => ref.watch(
        ContactCreationFormProvider.initialContactCreationForm,
      );

  Future<void> setName(String name, BuildContext context) async {
    state = state.copyWith(name: name, error: '');

    if ((state.publicKey.isEmpty && state.publicKeyRecovered.isEmpty) &&
        Address(address: state.address).isValid()) {
      final publicKey = await _getGenesisPublicKey(state.address);
      if (publicKey.isNotEmpty) {
        state = state.copyWith(publicKeyRecovered: publicKey);
      } else {
        state = state.copyWith(
          publicKeyRecovered: '',
          error: AppLocalization.of(context)!.contactPublicKeyNotFound,
        );
      }
    }
  }

  Future<void> setAddress(String address, BuildContext context) async {
    state = state.copyWith(address: address, error: '');

    if (Address(address: address).isValid()) {
      final publicKey = await _getGenesisPublicKey(state.address);
      if (publicKey.isNotEmpty) {
        state = state.copyWith(publicKeyRecovered: publicKey);
      } else {
        state = state.copyWith(
          publicKeyRecovered: '',
          error: AppLocalization.of(context)!.contactPublicKeyNotFound,
        );
      }
    } else {
      state = state.copyWith(
        publicKeyRecovered: '',
      );
    }
  }

  Future<String> _getGenesisPublicKey(String address) async {
    final connectivityStatusProvider = ref.read(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return '';
    }

    final publicKeyMap = await sl.get<ApiService>().getTransactionChain(
      {address: ''},
      request: 'previousPublicKey',
    );
    var publicKey = '';
    if (publicKeyMap.isNotEmpty &&
        publicKeyMap[state.address] != null &&
        publicKeyMap[state.address]!.isNotEmpty) {
      publicKey = publicKeyMap[state.address]![0].previousPublicKey!;
    }

    return publicKey;
  }

  void setPublicKey(String publicKey) {
    state = state.copyWith(publicKey: publicKey, error: '');
  }

  void setFavorite(bool favorite) {
    state = state.copyWith(favorite: favorite);
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  Future<bool> controlName(
    BuildContext context,
  ) async {
    if (state.name.isEmpty) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.contactNameMissing,
      );
      return false;
    }
    final nameExists = await ref.read(
      ContactProviders.isContactExistsWithName(name: '@${state.name}').future,
    );
    if (nameExists) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.contactExistsName,
      );
      return false;
    }

    return true;
  }

  Future<bool> controlAddress(
    BuildContext context,
  ) async {
    if (state.address.isEmpty) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.addressMissing,
      );
      return false;
    }

    if (!Address(address: state.address).isValid()) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.invalidAddress,
      );
      return false;
    }

    final addressExists = await ref.read(
      ContactProviders.isContactExistsWithAddress(address: state.address)
          .future,
    );

    if (addressExists) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.contactExistsAddress,
      );
      return false;
    }
    state = state.copyWith(error: '');
    return true;
  }
}

abstract class ContactCreationFormProvider {
  static final initialContactCreationForm = _initialContactCreationFormProvider;
  static final contactCreationForm = _contactCreationFormProvider;
}
