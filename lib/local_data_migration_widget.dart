import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalDataMigrationWidget extends StatelessWidget {
  const LocalDataMigrationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('Migration in progress Widget', name: 'DataMigration');
    // TODO(redwdarf03): improve UI
    return Scaffold(
      backgroundColor: Colors.black,
      body: Text(
        AppLocalizations.of(context)!.localDataMigrationMessage,
      ),
    );
  }
}
