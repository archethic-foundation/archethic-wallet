/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

/// A widget for displaying a mnemonic phrase
class MnemonicDisplay extends ConsumerStatefulWidget {
  const MnemonicDisplay({
    super.key,
    required this.wordList,
    required this.seed,
    this.obscureSeed = false,
    required this.explanation,
  });

  final List<String> wordList;
  final bool obscureSeed;
  final Widget explanation;
  final String seed;

  @override
  ConsumerState<MnemonicDisplay> createState() => _MnemonicDisplayState();
}

class _MnemonicDisplayState extends ConsumerState<MnemonicDisplay> {
  late bool _seedObscured;
  int curWord = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _seedObscured = true;
    curWord = 0;
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(SettingsProviders.settings);
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  preferences.activeVibrations,
                );
            if (widget.obscureSeed) {
              setState(() {
                _seedObscured = !_seedObscured;
              });
            }
          },
          child: Column(
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.center,
                children: widget.wordList.asMap().entries.map((MapEntry entry) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: ArchethicTheme.sheetBackground,
                            border: Border.all(
                              color: ArchethicTheme.sheetBorder,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 7,
                              left: 10,
                              right: 7,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  maxRadius: 10,
                                  child: Text(
                                    (entry.key + 1).toString(),
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary60,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _seedObscured && widget.obscureSeed
                                      ? '•' * 6
                                      : entry.value,
                                  style: ArchethicThemeStyles
                                      .textStyleSize12W400Primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Tap to reveal or hide
              if (widget.obscureSeed)
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 8),
                  child: _seedObscured
                      ? AutoSizeText(
                          AppLocalizations.of(context)!.tapToReveal,
                          style:
                              ArchethicThemeStyles.textStyleSize14W600Primary,
                        )
                      : Text(
                          AppLocalizations.of(context)!.tapToHide,
                          style:
                              ArchethicThemeStyles.textStyleSize14W600Primary,
                        ),
                ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded = isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: ArchethicTheme.seedInfoBackground,
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.seedHex,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W400Primary,
                            ),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SelectableText(
                            widget.seed,
                            style:
                                ArchethicThemeStyles.textStyleSize12W400Primary,
                          ),
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: widget.explanation,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
