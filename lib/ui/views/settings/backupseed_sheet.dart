/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';

class AppSeedBackupSheet extends StatefulWidget {
  const AppSeedBackupSheet(this.seed, {super.key});

  final String seed;

  @override
  State<AppSeedBackupSheet> createState() => _AppSeedBackupSheetState();
}

class _AppSeedBackupSheetState extends State<AppSeedBackupSheet> {
  List<String>? _mnemonic;
  List<String>? mnemonic;

  @override
  void initState() {
    super.initState();
    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        _mnemonic = AppMnemomics.seedToMnemonic(widget.seed,
            languageCode: preferences.getLanguageSeed());
      });
    });
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
                color: StateContainer.of(context).curTheme.text10,
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
                          AppLocalization.of(context)!.recoveryPhrase,
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                              context),
                          minFontSize: 12,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _mnemonic != null
                            ? MnemonicDisplay(
                                wordList: _mnemonic!,
                                obscureSeed: true,
                              )
                            : const SizedBox()
                      ],
                    ),
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
