/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:ui';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

// ignore: avoid_classes_with_only_static_members
class Sheets {
  //App Ninty Height Sheet
  static Future<T?>? showAppHeightNineSheet<T>({
    required BuildContext context,
    required Widget widget,
    Color? color,
    double radius = 25.0,
    Color? bgColor,
    int animationDurationMs = 250,
    bool closeOnTap = false,
    Function? onDisposed,
  }) {
    assert(radius > 0.0);
    color ??= StateContainer.of(context).curTheme.backgroundDark;
    bgColor ??= StateContainer.of(context).curTheme.sheetBackground;
    final route = _AppHeightNineModalRoute<T>(
      builder: (BuildContext context) {
        return DecoratedBox(
          decoration: StateContainer.of(context).curTheme.getDecorationSheet(),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            builder: (context, double value, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return RadialGradient(
                    radius: value * 5,
                    colors: const [
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                      Colors.transparent
                    ],
                    stops: const [0.0, 0.55, 0.6, 1.0],
                    center: const FractionalOffset(0.95, 0.95),
                  ).createShader(rect);
                },
                child: widget,
              );
            },
          ),
        );
      },
      color: color,
      radius: radius,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      bgColor: bgColor,
      animationDurationMs: animationDurationMs,
      closeOnTap: closeOnTap,
      onDisposed: onDisposed,
    );

    return Navigator.push<T>(context, route);
  }

  //App Height Eigth Sheet
  static Future<T?> showAppHeightEightSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? color,
    double radius = 25.0,
    Color? bgColor,
    int animationDurationMs = 225,
  }) {
    assert(radius > 0.0);
    color ??= StateContainer.of(context).curTheme.backgroundDark;
    bgColor ??= StateContainer.of(context).curTheme.sheetBackground;
    return Navigator.push<T>(
      context,
      _AppHeightEightModalRoute<T>(
        builder: builder,
        color: color,
        radius: radius,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        bgColor: bgColor,
        animationDurationMs: animationDurationMs,
      ),
    );
  }
}

class _AppHeightNineSheetLayout extends SingleChildLayoutDelegate {
  _AppHeightNineSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (constraints.maxHeight < 667) {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.95,
      );
    }
    if ((constraints.maxHeight / constraints.maxWidth > 2.1 &&
            !kIsWeb &&
            Platform.isAndroid) ||
        constraints.maxHeight > 812) {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.8,
      );
    } else {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.9,
      );
    }
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_AppHeightNineSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _AppHeightNineModalRoute<T> extends PopupRoute<T> {
  _AppHeightNineModalRoute({
    this.builder,
    this.barrierLabel,
    this.color,
    this.radius,
    super.settings,
    this.bgColor,
    this.animationDurationMs,
    this.closeOnTap,
    this.onDisposed,
  });

  final WidgetBuilder? builder;
  final double? radius;
  final Color? color;
  final Color? bgColor;
  final int? animationDurationMs;
  final bool? closeOnTap;
  final Function? onDisposed;

  @override
  Color get barrierColor => bgColor!;

  @override
  bool get barrierDismissible => true;

  @override
  String? barrierLabel;

  @override
  void didComplete(T? result) {
    if (onDisposed != null) {
      onDisposed?.call();
    }
    super.didComplete(result);
  }

  AnimationController? _animationController;
  CurvedAnimation? appSheetAnimation;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    _animationController!.duration =
        Duration(milliseconds: animationDurationMs!);
    appSheetAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
      reverseCurve: Curves.linear,
    )..addStatusListener((AnimationStatus animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          appSheetAnimation!.curve = Curves.linear;
        }
      });
    return _animationController!;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        onTap: () {
          if (closeOnTap!) {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  StateContainer.of(context).activeVibrations,
                );
            // Close when tapped anywhere
            Navigator.of(context).pop();
          }
        },
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: AnimatedBuilder(
            animation: appSheetAnimation!,
            builder: (BuildContext context, Widget? child) =>
                CustomSingleChildLayout(
              delegate: _AppHeightNineSheetLayout(appSheetAnimation!.value),
              child: BottomSheet(
                animationController: _animationController,
                onClosing: () => Navigator.pop(context),
                builder: (BuildContext context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color!.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius!),
                        topRight: Radius.circular(radius!),
                      ),
                    ),
                    child: Builder(builder: builder!),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs!);
}

class _AppHeightEightSheetLayout extends SingleChildLayoutDelegate {
  _AppHeightEightSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (constraints.maxHeight < 667) {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.9,
      );
    }
    if (constraints.maxHeight / constraints.maxWidth > 2.1) {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.7,
      );
    } else {
      return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.8,
      );
    }
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_AppHeightEightSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _AppHeightEightModalRoute<T> extends PopupRoute<T> {
  _AppHeightEightModalRoute({
    this.builder,
    this.barrierLabel,
    this.color,
    this.radius,
    super.settings,
    this.bgColor,
    this.animationDurationMs,
  });

  final WidgetBuilder? builder;
  final double? radius;
  final Color? color;
  final Color? bgColor;
  final int? animationDurationMs;

  @override
  Color get barrierColor => bgColor!;

  @override
  bool get barrierDismissible => true;

  @override
  String? barrierLabel;

  AnimationController? _animationController;
  CurvedAnimation? appSheetAnimation;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    _animationController!.duration =
        Duration(milliseconds: animationDurationMs!);
    appSheetAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
      reverseCurve: Curves.linear,
    )..addStatusListener((AnimationStatus animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          appSheetAnimation!.curve = Curves.linear;
        }
      });
    return _animationController!;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: AnimatedBuilder(
          animation: appSheetAnimation!,
          builder: (BuildContext context, Widget? child) =>
              CustomSingleChildLayout(
            delegate: _AppHeightEightSheetLayout(appSheetAnimation!.value),
            child: BottomSheet(
              animationController: _animationController,
              onClosing: () => Navigator.pop(context),
              builder: (BuildContext context) => DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius!),
                    topRight: Radius.circular(radius!),
                  ),
                ),
                child: Builder(builder: builder!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs!);
}
//App HeightEight Sheet End
