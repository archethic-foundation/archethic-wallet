/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/util/preferences.dart';

enum PinOverlayType { newPin, enterPin }

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    //t from 0.0 to 1.0
    return sin(t * 3 * pi);
  }
}

class PinScreen extends StatefulWidget {
  const PinScreen(this.type,
      {this.description = '',
      this.expectedPin = '',
      this.pinScreenBackgroundColor,
      super.key});

  final PinOverlayType type;
  final String expectedPin;
  final String description;
  final Color? pinScreenBackgroundColor;

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    with SingleTickerProviderStateMixin {
  static const int maxAttempts = 5;

  int _pinLength = 6;
  double buttonSize = 70.0;

  String pinEnterTitle = '';
  String pinCreateTitle = '';

  // Stateful data
  List<IconData>? _dotStates;
  String? _pin;
  String? _pinConfirmed;
  bool?
      _awaitingConfirmation; // true if pin has been entered once, false if not entered once
  String? _header;
  int _failedAttempts = 0;
  final List<int> _listPinNumber = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  // Invalid animation
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    // Initialize list all empty
    if (widget.type == PinOverlayType.enterPin) {
      _header = pinEnterTitle;
      _pinLength = widget.expectedPin.length;
    } else {
      _header = pinCreateTitle;
    }
    _dotStates = List<IconData>.filled(_pinLength, FontAwesomeIcons.minus);
    _awaitingConfirmation = false;
    _pin = '';
    _pinConfirmed = '';

    Preferences.getInstance().then((Preferences _preferences) {
      if (_preferences.getPinPadShuffle()) {
        _listPinNumber.shuffle();
      }
      setState(() {
        // Get adjusted failed attempts
        _failedAttempts = _preferences.getLockAttempts() % maxAttempts;
      });
    });

    // Set animation
    _controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: _controller!, curve: ShakeCurve());
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  /// Set next character in the pin set
  /// return true if all characters entered
  bool _setCharacter(String character) {
    if (_awaitingConfirmation!) {
      setState(() {
        _pinConfirmed = _pinConfirmed! + character;
      });
    } else {
      setState(() {
        _pin = _pin! + character;
      });
    }
    for (int i = 0; i < _dotStates!.length; i++) {
      if (_dotStates![i] == FontAwesomeIcons.minus) {
        setState(() {
          _dotStates![i] = FontAwesomeIcons.solidCircle;
        });
        break;
      }
    }
    if (_dotStates!.last == FontAwesomeIcons.solidCircle) {
      return true;
    }
    return false;
  }

  void _backSpace() {
    if (_dotStates![0] != FontAwesomeIcons.minus) {
      int lastFilledIndex = 0;
      for (int i = 0; i < _dotStates!.length; i++) {
        if (_dotStates![i] == FontAwesomeIcons.solidCircle) {
          if (i == _dotStates!.length ||
              _dotStates![i + 1] == FontAwesomeIcons.minus) {
            lastFilledIndex = i;
            break;
          }
        }
      }
      setState(() {
        _dotStates![lastFilledIndex] = FontAwesomeIcons.minus;
        if (_awaitingConfirmation!) {
          _pinConfirmed =
              _pinConfirmed!.substring(0, _pinConfirmed!.length - 1);
        } else {
          _pin = _pin!.substring(0, _pin!.length - 1);
        }
      });
    }
  }

  Widget _buildPinScreenButton(String buttonText, BuildContext context) {
    return SizedBox(
      height: smallScreen(context) ? buttonSize - 15 : buttonSize,
      width: smallScreen(context) ? buttonSize - 15 : buttonSize,
      child: InkWell(
          key: Key('pinButton' + buttonText),
          borderRadius: BorderRadius.circular(200),
          highlightColor: StateContainer.of(context).curTheme.text15,
          splashColor: StateContainer.of(context).curTheme.text30,
          onTap: () {},
          onTapDown: (TapDownDetails details) {
            sl.get<HapticUtil>().feedback(FeedbackType.light);
            if (_controller!.status == AnimationStatus.forward ||
                _controller!.status == AnimationStatus.reverse) {
              return;
            }
            if (_setCharacter(buttonText)) {
              // Mild delay so they can actually see the last dot get filled
              Future<void>.delayed(const Duration(milliseconds: 50), () {
                if (widget.type == PinOverlayType.enterPin) {
                  // Pin is not what was expected
                  if (_pin != widget.expectedPin) {
                    sl.get<HapticUtil>().feedback(FeedbackType.error);
                    _controller!.forward();
                  } else {
                    Preferences.getInstance().then((Preferences _preferences) {
                      _preferences.resetLockAttempts();
                      Navigator.of(context).pop(true);
                    });
                  }
                } else {
                  if (!_awaitingConfirmation!) {
                    // Switch to confirm pin
                    setState(() {
                      _awaitingConfirmation = true;
                      _dotStates = List<IconData>.filled(
                          _pinLength, FontAwesomeIcons.minus);
                      _header = AppLocalization.of(context)!.pinConfirmTitle;
                    });
                  } else {
                    // First and second pins match
                    if (_pin == _pinConfirmed) {
                      Navigator.of(context).pop(_pin);
                    } else {
                      sl.get<HapticUtil>().feedback(FeedbackType.error);
                      _controller!.forward();
                    }
                  }
                }
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: StateContainer.of(context).curTheme.background40!,
                    blurRadius: 15,
                    spreadRadius: -15),
              ],
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: AppStyles.textStyleSize20W700Primary(context),
            ),
          )),
    );
  }

  List<Widget> _buildPinDots() {
    final List<Widget> ret = List<Widget>.empty(growable: true);
    for (int i = 0; i < _pinLength; i++) {
      ret.add(FaIcon(_dotStates![i],
          color: StateContainer.of(context).curTheme.text, size: 15.0));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    if (pinEnterTitle.isEmpty) {
      setState(() {
        pinEnterTitle = AppLocalization.of(context)!.pinEnterTitle;
        if (widget.type == PinOverlayType.enterPin) {
          _header = pinEnterTitle;
        }
      });
    }
    if (pinCreateTitle.isEmpty) {
      setState(() {
        pinCreateTitle = AppLocalization.of(context)!.pinCreateTitle;
        if (widget.type == PinOverlayType.newPin) {
          _header = pinCreateTitle;
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background3Small!),
              fit: BoxFit.fitHeight),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.only(start: 15),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: StateContainer.of(context).curTheme.text,
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                    buildIconWidget(
                        context,
                        'packages/aeuniverse/assets/icons/pin-code.png',
                        90,
                        90),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: AutoSizeText(
                        _header!,
                        style: AppStyles.textStyleSize16W400Primary(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: AutoSizeText(
                        widget.description,
                        style: AppStyles.textStyleSize16W200Primary(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                        start: MediaQuery.of(context).size.width * 0.25,
                        end: MediaQuery.of(context).size.width * 0.25,
                        top: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _buildPinDots()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07,
                      right: MediaQuery.of(context).size.width * 0.07,
                      bottom: smallScreen(context)
                          ? MediaQuery.of(context).size.height * 0.02
                          : MediaQuery.of(context).size.height * 0.05,
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(0).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(1).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(2).toString(),
                                context),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(3).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(4).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(5).toString(),
                                context),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(6).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(7).toString(),
                                context),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(8).toString(),
                                context),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.009),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                              width: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                            ),
                            _buildPinScreenButton(
                                _listPinNumber.elementAt(9).toString(),
                                context),
                            SizedBox(
                              height: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                              width: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(200),
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .text30,
                                  onTap: () {},
                                  onTapDown: (TapDownDetails details) {
                                    sl
                                        .get<HapticUtil>()
                                        .feedback(FeedbackType.light);
                                    _backSpace();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .background40!,
                                            blurRadius: 15,
                                            spreadRadius: -15),
                                      ],
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: FaIcon(Icons.backspace,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .text,
                                        size: 20.0),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
