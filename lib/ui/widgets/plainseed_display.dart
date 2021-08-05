// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';

/// A widget for displaying a mnemonic phrase
class PlainSeedDisplay extends StatefulWidget {
  const PlainSeedDisplay(
      {@required this.seed, this.obscureSeed = false, this.showButton = true});

  final String seed;
  final bool obscureSeed;
  final bool showButton;

  @override
  _PlainSeedDisplayState createState() => _PlainSeedDisplayState();
}

class _PlainSeedDisplayState extends State<PlainSeedDisplay> {
  static final String _obscuredSeed = '•' * 64;

  bool _seedCopied;
  bool _seedObscured;
  Timer _seedCopiedTimer;

  @override
  void initState() {
    super.initState();
    _seedCopied = false;
    _seedObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // The paragraph
        Container(
          margin: EdgeInsets.only(
              left: smallScreen(context) ? 30 : 40,
              right: smallScreen(context) ? 30 : 40,
              top: 15.0),
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            AppLocalization.of(context).seedDescription,
            style: AppStyles.textStyleSize16W200Primary(context),
            maxLines: 5,
            stepGranularity: 0.5,
          ),
        ),
        // Container for the seed
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (widget.obscureSeed) {
                setState(() {
                  _seedObscured = !_seedObscured;
                });
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  margin: const EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: UIUtil.threeLineSeedText(
                      context,
                      widget.obscureSeed && _seedObscured
                          ? _obscuredSeed
                          : widget.seed,
                      textStyle: _seedCopied
                          ? AppStyles.textStyleSize14W100Success(context)
                          : AppStyles.textStyleSize14W100Primary(context)),
                ),
                // Tap to reveal or hide
                if (widget.obscureSeed)
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 8),
                    child: _seedObscured
                        ? AutoSizeText(
                            AppLocalization.of(context).tapToReveal,
                            style:
                                AppStyles.textStyleSize14W600Primary(context),
                          )
                        : Text(
                            AppLocalization.of(context).tapToHide,
                            style:
                                AppStyles.textStyleSize14W600Primary(context),
                          ),
                  )
                else
                  const SizedBox(),
              ],
            )),
        // Container for the copy button
        if (widget.showButton)
          Container(
            margin: const EdgeInsetsDirectional.only(top: 5),
            padding: const EdgeInsets.all(0.0),
            child: OutlinedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.seed));
                //UserDataUtil.setSecureClipboardItem(widget.seed);
                setState(() {
                  _seedCopied = true;
                });
                if (_seedCopiedTimer != null) {
                  _seedCopiedTimer.cancel();
                }
                _seedCopiedTimer =
                    Timer(const Duration(milliseconds: 1500), () {
                  setState(() {
                    _seedCopied = false;
                  });
                });
              },
              child: AutoSizeText(
                _seedCopied
                    ? AppLocalization.of(context).copied
                    : AppLocalization.of(context).copy,
                textAlign: TextAlign.center,
                style: _seedCopied
                    ? AppStyles.textStyleSize14W700Success(context)
                    : AppStyles.textStyleSize14W700Primary(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
