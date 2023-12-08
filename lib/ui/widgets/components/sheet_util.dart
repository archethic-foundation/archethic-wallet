/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:io';
import 'dart:ui';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Sheets {
  //App Ninty Height Sheet
  static Future<T?>? showAppHeightNineSheet<T>({
    required BuildContext context,
    required WidgetRef ref,
    required Widget widget,
    List<Override> overrides = const [],
    Color? color,
    double radius = 25.0,
    Color? bgColor,
    int animationDurationMs = 250,
    bool closeOnTap = false,
    Function? onDisposed,
  }) {
    assert(radius > 0.0);

    color ??= ArchethicTheme.backgroundDark;
    bgColor ??= ArchethicTheme.sheetBackground;
    final route = _AppHeightNineModalRoute<T>(
      builder: (BuildContext context) {
        return DecoratedBox(
          decoration: ArchethicTheme.getDecorationSheet(),
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
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 0.6, 1.0],
                    center: const FractionalOffset(0.95, 0.95),
                  ).createShader(rect);
                },
                child: overrides.isEmpty
                    ? widget
                    : ProviderScope(
                        overrides: overrides,
                        child: widget,
                      ),
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
            // Close when tapped anywhere
            context.pop();
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
                onClosing: () => context.pop(),
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
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs!);
}
