import 'package:aewallet/ui/views/add_custom_token/layouts/add_custom_token_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomTokenAddBtn extends ConsumerWidget {
  const CustomTokenAddBtn({
    this.myTokens,
    super.key,
  });

  final List<aedappfm.AEToken>? myTokens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CustomSmallBtn(
        buttonText: AppLocalizations.of(context)!.token,
        icon: const Icon(
          Symbols.add,
          color: Colors.white,
          size: 17,
        ),
        onPressed: () async {
          await CupertinoScaffold.showCupertinoModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 1,
                child: Scaffold(
                  backgroundColor: aedappfm.AppThemeBase.sheetBackground
                      .withValues(alpha: 0.2),
                  body: AddCustomTokenSheet(
                    myTokens: myTokens,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
