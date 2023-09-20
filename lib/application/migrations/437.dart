part of './migration_manager.dart';

final migration_437 = LocalDataMigration(
  minAppVersion: 437,
  run: (ref) async {
    // We need to reload keychain because of account's name structure change
    // https://github.com/archethic-foundation/archethic-wallet/pull/759
    await ref.read(SessionProviders.session.notifier).refresh();
    await ref.read(AccountProviders.selectedAccount.notifier).refreshAll();
  },
);
