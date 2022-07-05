/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';

/// A widget for displaying a mnemonic phrase
class MnemonicDisplay extends StatefulWidget {
  const MnemonicDisplay(
      {super.key, required this.wordList, this.obscureSeed = false});

  final List<String> wordList;
  final bool obscureSeed;

  @override
  State<MnemonicDisplay> createState() => _MnemonicDisplayState();
}

class _MnemonicDisplayState extends State<MnemonicDisplay> {
  bool? _seedObscured;
  int curWord = 0;

  @override
  void initState() {
    super.initState();
    _seedObscured = true;
    curWord = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          sl.get<HapticUtil>().feedback(
              FeedbackType.light, StateContainer.of(context).activeVibrations);
          if (widget.obscureSeed) {
            setState(() {
              _seedObscured = !_seedObscured!;
            });
          }
        },
        child: Column(
          children: <Widget>[
            Wrap(
                alignment: WrapAlignment.center,
                children: widget.wordList.asMap().entries.map((MapEntry entry) {
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: StateContainer.of(context)
                              .curTheme
                              .numMnemonicBackground,
                          child: Text((entry.key + 1).toString(),
                              style: AppStyles.textStyleSize16W400Primary(
                                  context)),
                        ),
                        label: Text(
                            _seedObscured! && widget.obscureSeed
                                ? '•' * 6
                                : entry.value,
                            style:
                                AppStyles.textStyleSize16W400Primary(context)),
                      ));
                }).toList()),
            // Tap to reveal or hide
            if (widget.obscureSeed)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 8),
                child: _seedObscured!
                    ? AutoSizeText(
                        AppLocalization.of(context)!.tapToReveal,
                        style: AppStyles.textStyleSize14W600Primary(context),
                      )
                    : Text(
                        AppLocalization.of(context)!.tapToHide,
                        style: AppStyles.textStyleSize14W600Primary(context),
                      ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    ]);
  }
}
