/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';

class AppSeedBackupSheet extends StatelessWidget {
  const AppSeedBackupSheet(this.mnemonic, {super.key});

  final List<String>? mnemonic;

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
          ),
          child: Column(
            children: <Widget>[
              SheetHeader(
                title: AppLocalization.of(context)!.recoveryPhrase,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          if (mnemonic != null) Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: MnemonicDisplay(
                                    wordList: mnemonic!,
                                    obscureSeed: true,
                                  ),
                                ) else const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
