import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  void setName(String name, BuildContext context) {
    state = state.copyWith(name: name, error: '');
  }

  void setAddress(String address, BuildContext context) {
    state = state.copyWith(address: address, error: '');
  }

  void setCreationInProgress(bool creationInProgress) {
    state = state.copyWith(creationInProgress: creationInProgress);
  }

  Future<String> _getGenesisPublicKey(String address) async {
    final connectivityStatusProvider = ref.read(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return '';
    }

    final apiService = ref.read(apiServiceProvider);
    final publicKeyMap = await apiService.getTransactionChain(
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
        error: AppLocalizations.of(context)!.contactNameMissing,
      );
      return false;
    }
    final nameExists = await ref.read(
      ContactProviders.isContactExistsWithName(contactName: '@${state.name}')
          .future,
    );
    if (nameExists) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.contactExistsName,
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
        error: AppLocalizations.of(context)!.addressMissing,
      );
      return false;
    }

    if (!Address(address: state.address).isValid()) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.invalidAddress,
      );
      return false;
    }

    final addressExists = await ref.read(
      ContactProviders.isContactExistsWithAddress(address: state.address)
          .future,
    );

    if (addressExists) {
      state = state.copyWith(
        error: AppLocalizations.of(context)!.contactExistsAddress,
      );
      return false;
    }
    state = state.copyWith(error: '');
    return true;
  }

  Future<Contact> addContact() async {
    final publicKey = await _getGenesisPublicKey(state.address);
    final apiService = ref.read(apiServiceProvider);
    final genesisAddress = await apiService.getGenesisAddress(state.address);

    final newContact = Contact(
      name: '@${Uri.encodeFull(state.name)}',
      address: state.address,
      genesisAddress: genesisAddress.address,
      type: ContactType.externalContact.name,
      publicKey: publicKey.toUpperCase(),
      favorite: false,
    );
    ref.read(
      ContactProviders.saveContact(contact: newContact),
    );
    return newContact;
  }
}

abstract class ContactCreationFormProvider {
  static final initialContactCreationForm = _initialContactCreationFormProvider;
  static final contactCreationForm = _contactCreationFormProvider;
}
