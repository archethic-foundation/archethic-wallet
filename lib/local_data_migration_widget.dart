import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:logging/logging.dart';

class LocalDataMigrationWidget extends StatelessWidget {
  const LocalDataMigrationWidget({
    super.key,
  });

  static final _logger = Logger('DataMigration');

  @override
  Widget build(BuildContext context) {
    _logger.info('Migration in progress Widget');
    return SheetSkeleton(
      appBar: AppBar(),
      menu: true,
      sheetContent: Text(
        AppLocalizations.of(context)!.localDataMigrationMessage,
      ),
    );
  }
}
