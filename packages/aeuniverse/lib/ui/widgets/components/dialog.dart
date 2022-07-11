/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';

// ignore: avoid_classes_with_only_static_members
class AppDialogs {
  static void showConfirmDialog(BuildContext context, String title,
      String content, String buttonText, Function onPressed,
      {String? cancelText, Function? cancelAction}) {
    cancelText ??= AppLocalization.of(context)!.cancel.toUpperCase();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppStyles.textStyleSize20W700EquinoxPrimary(context),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              side: BorderSide(
                  color: StateContainer.of(context).curTheme.text45!)),
          content: Text(content,
              style: AppStyles.textStyleSize16W200Primary(context)),
          actions: <Widget>[
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  cancelText!,
                  style: AppStyles.textStyleSize12W600Primary(context),
                ),
              ),
              onPressed: () {
                sl.get<HapticUtil>().feedback(FeedbackType.light,
                    StateContainer.of(context).activeVibrations);
                Navigator.of(context).pop();
                if (cancelAction != null) {
                  cancelAction();
                }
              },
            ),
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  buttonText,
                  style: AppStyles.textStyleSize12W600Primary(context),
                ),
              ),
              onPressed: () {
                sl.get<HapticUtil>().feedback(FeedbackType.light,
                    StateContainer.of(context).activeVibrations);
                Navigator.of(context).pop();
                onPressed();
              },
            ),
          ],
        );
      },
    );
  }

  static void showInfoDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppStyles.textStyleSize20W700Primary(context),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              side: BorderSide(
                  color: StateContainer.of(context).curTheme.text45!)),
          content: Text(content,
              style: AppStyles.textStyleSize16W200Primary(context)),
          actions: <Widget>[
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  AppLocalization.of(context)!.ok,
                  style: AppStyles.textStyleSize12W600Primary(context),
                ),
              ),
              onPressed: () {
                sl.get<HapticUtil>().feedback(FeedbackType.light,
                    StateContainer.of(context).activeVibrations);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum AnimationType {
  send,
}

class AnimationLoadingOverlay extends ModalRoute<void> {
  AnimationLoadingOverlay(this.type, this.overlay85, this.overlay70,
      {this.onPoppedCallback, this.title});

  AnimationType type;
  Function? onPoppedCallback;
  Color overlay85;
  Color overlay70;
  String? title;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor {
    return overlay70;
  }

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  void didComplete(void result) {
    if (onPoppedCallback != null) {
      onPoppedCallback!();
    }
    super.didComplete(result);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _getAnimation(BuildContext context) {
    switch (type) {
      case AnimationType.send:
        return PulsatingCircleLogo(
          title: title,
        );
      default:
        return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                StateContainer.of(context).curTheme.text60!));
    }
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: type == AnimationType.send
              ? const EdgeInsets.only(bottom: 10.0, left: 90, right: 90)
              : EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: _getAnimation(context),
        ),
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class PulsatingCircleLogo extends StatefulWidget {
  final String? title;
  const PulsatingCircleLogo({super.key, this.title});

  @override
  State<PulsatingCircleLogo> createState() => PulsatingCircleLogoState();
}

class PulsatingCircleLogoState extends State<PulsatingCircleLogo>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeOut),
    );
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, _) {
              return Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.iconDrawer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      for (int i = 1; i <= 2; i++)
                        BoxShadow(
                          color: StateContainer.of(context)
                              .curTheme
                              .iconDrawer!
                              .withOpacity(_animationController!.value / 2),
                          spreadRadius: _animation!.value * i,
                        )
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.png',
                        height: 80,
                      ),
                    ],
                  ));
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          widget.title != null
              ? widget.title!
              : AppLocalization.of(context)!.pleaseWait,
          textAlign: TextAlign.center,
          style: AppStyles.textStyleSize16W600EquinoxPrimary(context),
        )
      ],
    );
  }
}
