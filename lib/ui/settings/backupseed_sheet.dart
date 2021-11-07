// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/mnemonic_display.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/keys/mnemonics.dart';

class AppSeedBackupSheet extends StatefulWidget {
  const AppSeedBackupSheet(this.seed);

  final String seed;

  @override
  _AppSeedBackupSheetState createState() => _AppSeedBackupSheetState();
}

class _AppSeedBackupSheetState extends State<AppSeedBackupSheet> {
  List<String>? _mnemonic;
  List<String>? mnemonic;

  @override
  void initState() {
    super.initState();
    _mnemonic = AppMnemomics.seedToMnemonic(widget.seed);
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
        child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.primary10,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        top: 10, start: 60, end: 60),
                    child: Column(
                      children: <Widget>[
                        AutoSizeText(
                          'Recovery Phrase',
                          style: AppStyles.textStyleSize24W700Primary(context),
                          minFontSize: 12,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        MnemonicDisplay(
                          wordList: _mnemonic!,
                          obscureSeed: true,
                        )
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
