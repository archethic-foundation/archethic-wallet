/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';

enum PinOverlayType { newPin, enterPin }

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    //t from 0.0 to 1.0
    return sin(t * 2.5 * pi);
  }
}

class PinScreen extends StatefulWidget {
  const PinScreen(
    this.type, {
    this.description = '',
    this.expectedPin = '',
    this.pinScreenBackgroundColor,
    super.key,
  });

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
  double buttonSize = 70;

  String pinEnterTitle = '';
  String pinCreateTitle = '';

  // Stateful data
  late List<IconData> _dotStates;
  String? _pin;
  String? _pinConfirmed;
  late bool
      _awaitingConfirmation; // true if pin has been entered once, false if not entered once
  late String _header;
  int _failedAttempts = 0;
  final List<int> _listPinNumber = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  // Invalid animation
  late AnimationController _controller;
  Animation<double>? _animation;

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

    Preferences.getInstance().then((Preferences preferences) {
      if (preferences.getPinPadShuffle()) {
        _listPinNumber.shuffle();
      }
      setState(() {
        // Get adjusted failed attempts
        _failedAttempts = preferences.getLockAttempts() % maxAttempts;
      });

      // Set animation
      _controller = AnimationController(
        duration: const Duration(milliseconds: 350),
        vsync: this,
      );
      final Animation<double> curve =
          CurvedAnimation(parent: _controller, curve: ShakeCurve());
      _animation = Tween<double>(begin: 0, end: 25).animate(curve)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            if (widget.type == PinOverlayType.enterPin) {
              preferences.incrementLockAttempts().then((_) {
                _failedAttempts++;
                if (_failedAttempts >= maxAttempts) {
                  setState(() {
                    _controller.value = 0;
                  });
                  preferences.updateLockDate().then((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/lock_screen_transition',
                      (Route<dynamic> route) => false,
                    );
                  });
                } else {
                  setState(() {
                    _pin = '';
                    _header = AppLocalization.of(context)!.pinInvalid;
                    _dotStates =
                        List.filled(_pinLength, FontAwesomeIcons.minus);
                    _controller.value = 0;
                  });
                }
              });
            } else {
              setState(() {
                _awaitingConfirmation = false;
                _dotStates = List.filled(_pinLength, FontAwesomeIcons.minus);
                _pin = '';
                _pinConfirmed = '';
                _header = AppLocalization.of(context)!.pinConfirmError;
                _controller.value = 0;
              });
            }
          }
        })
        ..addListener(() {
          setState(() {
            // the animation object’s value is the changed state
          });
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Set next character in the pin set
  /// return true if all characters entered
  bool _setCharacter(String character) {
    if (_awaitingConfirmation) {
      setState(() {
        _pinConfirmed = _pinConfirmed! + character;
      });
    } else {
      setState(() {
        _pin = _pin! + character;
      });
    }
    for (var i = 0; i < _dotStates.length; i++) {
      if (_dotStates[i] == FontAwesomeIcons.minus) {
        setState(() {
          _dotStates[i] = FontAwesomeIcons.solidCircle;
        });
        break;
      }
    }
    if (_dotStates.last == FontAwesomeIcons.solidCircle) {
      return true;
    }
    return false;
  }

  void _backSpace() {
    if (_dotStates[0] != FontAwesomeIcons.minus) {
      var lastFilledIndex = 0;
      for (var i = 0; i < _dotStates.length; i++) {
        if (_dotStates[i] == FontAwesomeIcons.solidCircle) {
          if (i == _dotStates.length ||
              _dotStates[i + 1] == FontAwesomeIcons.minus) {
            lastFilledIndex = i;
            break;
          }
        }
      }
      setState(() {
        _dotStates[lastFilledIndex] = FontAwesomeIcons.minus;
        if (_awaitingConfirmation) {
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
        key: Key('pinButton$buttonText'),
        borderRadius: BorderRadius.circular(200),
        highlightColor: StateContainer.of(context).curTheme.text15,
        splashColor: StateContainer.of(context).curTheme.text30,
        onTap: () {},
        onTapDown: (TapDownDetails details) {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          if (_controller.status == AnimationStatus.forward ||
              _controller.status == AnimationStatus.reverse) {
            return;
          }
          if (_setCharacter(buttonText)) {
            // Mild delay so they can actually see the last dot get filled
            Future<void>.delayed(const Duration(milliseconds: 50), () async {
              if (widget.type == PinOverlayType.enterPin) {
                // Pin is not what was expected
                if (_pin != widget.expectedPin) {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.error,
                        StateContainer.of(context).activeVibrations,
                      );
                  _controller.forward();
                } else {
                  Preferences.getInstance().then((Preferences preferences) {
                    preferences.resetLockAttempts();
                    Navigator.of(context).pop(true);
                  });
                }
              } else {
                if (!_awaitingConfirmation) {
                  // Switch to confirm pin
                  setState(() {
                    _awaitingConfirmation = true;
                    _dotStates = List<IconData>.filled(
                      _pinLength,
                      FontAwesomeIcons.minus,
                    );
                    _header = AppLocalization.of(context)!.pinConfirmTitle;
                  });
                } else {
                  // First and second pins match
                  if (_pin == _pinConfirmed) {
                    final vault = await Vault.getInstance();
                    vault.setPin(_pin!);
                    Navigator.of(context).pop(true);
                  } else {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.error,
                          StateContainer.of(context).activeVibrations,
                        );
                    _controller.forward();
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
                spreadRadius: -15,
              ),
            ],
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppStyles.textStyleSize20W700Primary(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPinDots() {
    final ret = List<Widget>.empty(growable: true);
    for (var i = 0; i < _pinLength; i++) {
      ret.add(
        FaIcon(
          _dotStates[i],
          color: StateContainer.of(context).curTheme.text,
          size: 15,
        ),
      );
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
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              StateContainer.of(context).curTheme.background3Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
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
                  top: MediaQuery.of(context).size.height * 0.06,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: AutoSizeText(
                        _header,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    if (widget.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
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
                        start: _animation == null
                            ? MediaQuery.of(context).size.width * 0.25
                            : MediaQuery.of(context).size.width * 0.25 +
                                _animation!.value,
                        end: _animation == null
                            ? MediaQuery.of(context).size.width * 0.25
                            : MediaQuery.of(context).size.width * 0.25 -
                                _animation!.value,
                        top: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _buildPinDots(),
                      ),
                    ),
                    if (_failedAttempts > 0)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: AutoSizeText(
                          '${AppLocalization.of(context)!.attempt}$_failedAttempts/$maxAttempts',
                          style: AppStyles.textStyleSize16W200Primary(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
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
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(0).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(1).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(2).toString(),
                              context,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(3).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(4).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(5).toString(),
                              context,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(6).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(7).toString(),
                              context,
                            ),
                            _buildPinScreenButton(
                              _listPinNumber.elementAt(8).toString(),
                              context,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.009,
                        ),
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
                              context,
                            ),
                            SizedBox(
                              height: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                              width: smallScreen(context)
                                  ? buttonSize - 15
                                  : buttonSize,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(200),
                                highlightColor:
                                    StateContainer.of(context).curTheme.text15,
                                splashColor:
                                    StateContainer.of(context).curTheme.text30,
                                onTap: () {},
                                onTapDown: (TapDownDetails details) {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        StateContainer.of(context)
                                            .activeVibrations,
                                      );
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
                                        spreadRadius: -15,
                                      ),
                                    ],
                                  ),
                                  alignment: AlignmentDirectional.center,
                                  child: FaIcon(
                                    Icons.backspace,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    size: 20,
                                  ),
                                ),
                              ),
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
