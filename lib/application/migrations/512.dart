// ignore_for_file: file_names

part of 'migration_manager.dart';

final migration_512 = LocalDataMigration(
  minAppVersion: 512,
  run: (ref) async {
    // We need to get the genesis address for contact's list
    // https://github.com/archethic-foundation/archethic-wallet/issues/887

    final contacts = await ref.read(
      ContactProviders.fetchContacts().future,
    );
    for (final contact in contacts) {
      final genesisAddress =
          await sl.get<ApiService>().getGenesisAddress(contact.address);
      contact.genesisAddress = genesisAddress.address;
      await contact.save();
    }
  },
);
