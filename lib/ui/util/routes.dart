/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';

extension NavigatorPushOnceExt on NavigatorState {
  /// Pushes a new route. Ensures that route is present only once.
  /// This requires [newRoute.settings.name] to be defined.
  Future<T?> pushOnce<T extends Object?>(Route<T> newRoute) {
    assert(
      newRoute.settings.name != null,
      '[Navigator.pushOnce] required [newRoute.settings.name] to be defined',
    );
    return pushAndRemoveUntil(
      newRoute,
      (route) => route.settings.name != newRoute.settings.name,
    );
  }
}

/// NoTransitionRoute
/// Custom route which has no transitions
class NoTransitionRoute<T> extends MaterialPageRoute<T> {
  NoTransitionRoute({required super.builder, required super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

/// NoPushTransitionRoute
/// Custom route which has no transition when pushed, but has a pop animation
class NoPushTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPushTransitionRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // is popping
    if (animation.status == AnimationStatus.reverse) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

/// NoPopTransitionRoute
/// Custom route which has no transition when popped, but has a push animation
class NoPopTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPopTransitionRoute({required super.builder, required super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // is pushing
    if (animation.status == AnimationStatus.forward) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

class RouteUtils {
  static RoutePredicate withNameLike(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name != null &&
          route.settings.name!.contains(name);
    };
  }
}
