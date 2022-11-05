import 'package:aewallet/application/contact.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
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
  ],
);

class ContactCreationFormNotifier
    extends AutoDisposeNotifier<ContactCreationFormState> {
  ContactCreationFormNotifier();

  @override
  ContactCreationFormState build() => ref.watch(
        ContactCreationFormProvider.initialContactCreationForm,
      );

  void setName(String name) {
    state = state.copyWith(name: name, error: '');
  }

  Future<void> setAddress(String address) async {
    state = state.copyWith(address: address, error: '');

    // TODO(reddwarf03): How to refresh public key field
    final publicKey = (await sl
            .get<ApiService>()
            .getLastTransaction(address, request: 'previousPublicKey'))
        .previousPublicKey;
    if (publicKey != null) {
      state = state.copyWith(publicKey: publicKey);
    } else {
      state = state.copyWith(error: 'Public key not found');
    }
  }

  void setPublicKey(String publicKey) {
    state = state.copyWith(publicKey: publicKey, error: '');
  }

  void setFavorite(bool favorite) {
    state = state.copyWith(favorite: favorite);
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
    final nameExists = ref.read(
      ContactProviders.isContactExistsWithName(name: '@${state.name}'),
    );

    nameExists.maybeWhen(
      data: (data) {
        if (data) {
          state = state.copyWith(
            error: AppLocalization.of(context)!.contactExistsName,
          );
        }
      },
      loading: () {},
      orElse: () {},
    );

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

    if (!Address(state.address).isValid) {
      state = state.copyWith(
        error: AppLocalization.of(context)!.invalidAddress,
      );
      return false;
    }

    final addressExists = ref.read(
      ContactProviders.isContactExistsWithAddress(address: state.address),
    );

    addressExists.maybeWhen(
      data: (data) {
        if (data) {
          state = state.copyWith(
            error: AppLocalization.of(context)!.contactExistsAddress,
          );
        }
      },
      loading: () {},
      orElse: () {},
    );

    return true;
  }
}

abstract class ContactCreationFormProvider {
  static final initialContactCreationForm = _initialContactCreationFormProvider;
  static final contactCreationForm = _contactCreationFormProvider;
}
