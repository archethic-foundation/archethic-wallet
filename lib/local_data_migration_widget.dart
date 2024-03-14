import 'dart:developer';

import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalDataMigrationWidget extends StatelessWidget {
  const LocalDataMigrationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('Migration in progress Widget', name: 'DataMigration');
    return SheetSkeleton(
      appBar: AppBar(),
      menu: true,
      sheetContent: Text(
        AppLocalizations.of(context)!.localDataMigrationMessage,
      ),
    );
  }
}
