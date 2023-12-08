/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

// Project imports:
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

enum PinOverlayType { newPin, enterPin }

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    //t from 0.0 to 1.0
    return sin(t * 2.5 * pi);
  }
}

class PinScreen extends ConsumerStatefulWidget {
  const PinScreen(
    this.type, {
    this.description = '',
    this.pinScreenBackgroundColor,
    this.canNavigateBack = true,
    super.key,
  });

  static const name = 'PinScreen';
  static const routerPage = '/pin';

  final bool canNavigateBack;
  final PinOverlayType type;
  final String description;
  final Color? pinScreenBackgroundColor;

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen>
    with SingleTickerProviderStateMixin, LockGuardMixin {
  static const int _pinLength = 6;
  double buttonSize = 70;

  String pinEnterTitle = '';
  String pinCreateTitle = '';

  // Stateful data
  String _pin = '';
  String _pinConfirmed = '';
  late bool _awaitingConfirmation;
  late String _header;
  final List<int> _listPinNumber = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  // Invalid animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize list all empty
    if (widget.type == PinOverlayType.enterPin) {
      _header = pinEnterTitle;
    } else {
      _header = pinCreateTitle;
    }
    _awaitingConfirmation = false;
    _pin = '';
    _pinConfirmed = '';

    final shouldShuffle = ref.read(
      AuthenticationProviders.settings.select(
        (settings) => settings.pinPadShuffle,
      ),
    );

    if (shouldShuffle) {
      _listPinNumber.shuffle();
    }

    // Set animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    final Animation<double> curve = CurvedAnimation(
      parent: _controller,
      curve: ShakeCurve(),
    );
    _animation = Tween<double>(begin: 0, end: 25).animate(curve);

    showLockCountdownScreenIfNeeded(context, ref);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// The pin being entered
  ///
  /// It returns either pin or confirmation pin.
  String get displayedPin => _awaitingConfirmation ? _pinConfirmed : _pin;

  /// return true if entered pin is long enough
  bool get allExpectedCharactersEntered {
    return displayedPin.length >= _pinLength;
  }

  /// Set next character in the pin set
  void _setCharacter(String character) {
    if (_awaitingConfirmation) {
      if (_pinConfirmed.length >= _pinLength) return;
      setState(() {
        _pinConfirmed = _pinConfirmed + character;
      });
    } else {
      if (_pin.length >= _pinLength) return;
      setState(() {
        _pin = _pin + character;
      });
    }
  }

  void _backSpace() {
    setState(() {
      if (_awaitingConfirmation) {
        _pinConfirmed = _pinConfirmed.substring(0, _pinConfirmed.length - 1);
      } else {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  // TODO(Chralu): Convert to [Widget] subclass. (3)
  Widget _buildPinScreenButton(
    String buttonText,
    BuildContext context,
  ) {
    final preferences = ref.watch(SettingsProviders.settings);

    return SizedBox(
      height: smallScreen(context) ? buttonSize - 15 : buttonSize,
      width: smallScreen(context) ? buttonSize - 15 : buttonSize,
      child: InkWell(
        key: Key('pinButton$buttonText'),
        borderRadius: BorderRadius.circular(200),
        highlightColor: ArchethicTheme.text15,
        splashColor: ArchethicTheme.text30,
        onTap: () {},
        onTapDown: (TapDownDetails details) {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          if (_controller.status == AnimationStatus.forward ||
              _controller.status == AnimationStatus.reverse) {
            return;
          }

          _setCharacter(buttonText);
          if (allExpectedCharactersEntered) {
            // Mild delay so they can actually see the last dot get filled
            Future<void>.delayed(
              const Duration(milliseconds: 50),
              () async {
                if (widget.type == PinOverlayType.enterPin) {
                  await _checkPin(context, preferences);
                } else {
                  if (!_awaitingConfirmation) {
                    // Switch to confirm pin
                    setState(() {
                      _awaitingConfirmation = true;
                      _header = AppLocalizations.of(context)!.pinConfirmTitle;
                    });
                  } else {
                    // First and second pins match
                    await _submitNewPin(context, ref, preferences);
                  }
                }
              },
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ArchethicTheme.background40,
                blurRadius: 15,
                spreadRadius: -15,
              ),
            ],
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: ArchethicThemeStyles.textStyleSize20W700Primary,
          ),
        ),
      ),
    );
  }

  Future<void> _submitNewPin(
    BuildContext context,
    WidgetRef ref,
    Settings preferences,
  ) async {
    final updatePinResult = await ref
        .read(AuthenticationProviders.pinAuthentication.notifier)
        .updatePin(
          pin: _pin,
          pinConfirmation: _pinConfirmed,
        );

    await updatePinResult.map(
      pinsDoNotMatch: (value) {
        sl.get<HapticUtil>().feedback(
              FeedbackType.error,
              preferences.activeVibrations,
            );
        _controller.forward().then((_) {
          setState(() {
            _awaitingConfirmation = false;
            _pin = '';
            _pinConfirmed = '';
            _header = AppLocalizations.of(context)!.pinConfirmError;
            _controller.value = 0;
          });
        });
      },
      success: (value) async {
        await ref
            .read(
              AuthenticationProviders.settings.notifier,
            )
            .setAuthMethod(AuthMethod.pin);
        context.pop(true);
      },
    );
  }

  Future<void> _checkPin(BuildContext context, Settings preferences) async {
    final result = await ref
        .read(
          AuthenticationProviders.pinAuthentication.notifier,
        )
        .authenticateWithPin(
          PinCredentials(pin: _pin),
        );

    result.maybeMap(
      success: (_) async {
        context.pop(true);
        return;
      },
      orElse: () {
        showLockCountdownScreenIfNeeded(context, ref);
        sl.get<HapticUtil>().feedback(
              FeedbackType.error,
              preferences.activeVibrations,
            );
        _controller.forward().then((_) async {
          final isLocked = await ref.read(
            AuthenticationProviders.isLockCountdownRunning.future,
          );

          if (isLocked) {
            setState(() {
              _pin = '';
              _controller.value = 0;
              _header = pinEnterTitle;
            });
          } else {
            setState(() {
              _pin = '';
              _header = AppLocalizations.of(context)!.pinInvalid;
              _controller.value = 0;
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final preferences = ref.watch(SettingsProviders.settings);

    final pinAuthentication = ref.watch(
      AuthenticationProviders.pinAuthentication,
    );

    if (pinEnterTitle.isEmpty) {
      setState(() {
        pinEnterTitle = localizations.pinEnterTitle;
        if (widget.type == PinOverlayType.enterPin) {
          _header = pinEnterTitle;
        }
      });
    }
    if (pinCreateTitle.isEmpty) {
      setState(() {
        pinCreateTitle = localizations.pinCreateTitle;
        if (widget.type == PinOverlayType.newPin) {
          _header = pinCreateTitle;
        }
      });
    }

    return WillPopScope(
      onWillPop: () async => widget.canNavigateBack,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ArchethicTheme.backgroundSmall,
              ),
              fit: BoxFit.fitHeight,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                ArchethicTheme.backgroundDark,
                ArchethicTheme.background,
              ],
            ),
          ),
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
                          child: widget.canNavigateBack
                              ? BackButton(
                                  key: const Key('back'),
                                  color: ArchethicTheme.text,
                                  onPressed: () {
                                    context.pop(false);
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: AutoSizeText(
                        _header,
                        style: ArchethicThemeStyles.textStyleSize24W700Primary,
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
                          style:
                              ArchethicThemeStyles.textStyleSize16W200Primary,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) => Container(
                        margin: EdgeInsetsDirectional.only(
                          start: MediaQuery.of(context).size.width * 0.25 +
                              _animation.value,
                          end: MediaQuery.of(context).size.width * 0.25 -
                              _animation.value,
                          top: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...List.generate(
                              displayedPin.length,
                              (index) => Icon(
                                Symbols.circle,
                                fill: 1,
                                color: ArchethicTheme.text,
                                size: 15,
                              ),
                            ),
                            ...List.generate(
                              max(_pinLength - displayedPin.length, 0),
                              (index) => Icon(
                                Symbols.remove,
                                color: ArchethicTheme.text,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (pinAuthentication.failedAttemptsCount > 0)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: AutoSizeText(
                          '${localizations.attempt}${pinAuthentication.failedAttemptsCount}/${pinAuthentication.maxAttemptsCount}',
                          style:
                              ArchethicThemeStyles.textStyleSize16W200Primary,
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
                                highlightColor: ArchethicTheme.text15,
                                splashColor: ArchethicTheme.text30,
                                onTap: () {},
                                onTapDown: (TapDownDetails details) {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        preferences.activeVibrations,
                                      );
                                  _backSpace();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: ArchethicTheme.background40,
                                        blurRadius: 15,
                                        spreadRadius: -15,
                                      ),
                                    ],
                                  ),
                                  alignment: AlignmentDirectional.center,
                                  child: Icon(
                                    Symbols.backspace,
                                    color: ArchethicTheme.text,
                                    size: 26,
                                    weight: IconSize.weightM,
                                    opticalSize: IconSize.opticalSizeM,
                                    grade: IconSize.gradeM,
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
