// ignore_for_file: file_names

part of 'migration_manager.dart';

final migration_437 = LocalDataMigration(
  minAppVersion: 437,
  run: (ref) async {
    // We need to reload keychain because of account's name structure change
    // https://github.com/archethic-foundation/archethic-wallet/pull/759
    if (ref.read(SessionProviders.session).isLoggedOut) {
      log(
        'Skipping migration 437 process : user logged out.',
        name: logName,
      );
      return;
    }
    await ref.read(SessionProviders.session.notifier).refresh();
    await ref.read(AccountProviders.selectedAccount.future);
    await ref.read(AccountProviders.selectedAccount.notifier).refreshAll();
  },
);
