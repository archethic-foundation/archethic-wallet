import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConnectivityWarning extends ConsumerWidget
    implements SheetSkeletonInterface {
  const ConnectivityWarning({super.key});

  static const routerPage = '/connectivity_warning';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return Row(
      children: <Widget>[
        AppButtonTiny(
          AppButtonTinyType.primary,
          AppLocalizations.of(context)!.understandButton,
          Dimens.buttonBottomDimens,
          key: const Key('Understand'),
          onPressed: () async {
            context.pop();
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: AppLocalizations.of(context)!.information,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        Row(
          children: [
            const Icon(Symbols.warning, color: Colors.red),
            const SizedBox(width: 10),
            Text(
              localizations.connectivityWarningHeader,
              style: ArchethicThemeStyles.textStyleSize14W600Primary,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          localizations.connectivityWarningDesc,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
        ),
      ],
    );
  }
}
