import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ValidateSessionForm extends ConsumerWidget {
  const ValidateSessionForm({
    required this.origin,
    required this.challenge,
    super.key,
  });

  final awc.RPCSessionOrigin origin;
  final String challenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Column(
          children: <Widget>[
            const SheetHeader(
              title: 'Demande de vérification',
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Le challenge suivant est il affiché par votre application "${origin.name}" ?',
                        style: ArchethicThemeStyles.textStyleSize12W400Primary,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        challenge,
                        style: ArchethicThemeStyles.textStyleSize12W400Primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.no,
                  Dimens.buttonBottomDimens,
                  onPressed: () {
                    _showRejectedSession(context, ref);
                    Navigator.of(context).pop(false);
                  },
                ),
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.yes,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    _showAcceptedSession(context, ref, origin);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAcceptedSession(
    BuildContext context,
    WidgetRef ref,
    awc.RPCSessionOrigin origin,
  ) {
    UIUtil.showSnackbar(
      'Session sécurisée établie avec ${origin.name}',
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
    );
  }

  void _showRejectedSession(
    BuildContext context,
    WidgetRef ref,
  ) {
    UIUtil.showSnackbar(
      'Session refusée',
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(seconds: 5),
    );
  }
}
