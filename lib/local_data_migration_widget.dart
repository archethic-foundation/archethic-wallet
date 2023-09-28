import 'dart:developer';

import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalDataMigrationWidget extends StatelessWidget {
  const LocalDataMigrationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('Migration in progress Widget', name: 'DataMigration');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PulsatingCircleLogo(
          title: AppLocalizations.of(context)!.localDataMigrationMessage,
        ),
      ),
    );
  }
}
