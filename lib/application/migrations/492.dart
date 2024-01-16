// ignore_for_file: file_names

part of 'migration_manager.dart';

final migration_492 = LocalDataMigration(
  minAppVersion: 492,
  run: (ref) async {
    // We need to get the genesis address for contact's list
    // https://github.com/archethic-foundation/archethic-wallet/issues/887
    if (ref.read(SessionProviders.session).isLoggedOut) {
      log(
        'Skipping migration 492 process : user logged out.',
        name: logName,
      );
      return;
    }
    final contacts = await ref.read(
      ContactProviders.fetchContacts().future,
    );
    for (final contact in contacts) {
      final genesisAddress =
          await sl.get<ApiService>().getGenesisAddress(contact.address);
      contact
        ..genesisAddress = genesisAddress.address
        ..save();
    }
  },
);
