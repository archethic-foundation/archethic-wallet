import 'dart:developer';

import 'package:aewallet/util/list_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// An [AppLifecycleRecognizer] recognizes a lifecycle pattern.
/// [onRecognize] is then called.
abstract class AppLifecycleRecognizer {
  const AppLifecycleRecognizer({
    required this.onRecognize,
  });

  final void Function() onRecognize;

  bool didRecognize(List<AppLifecycleState> states);
  bool shouldStopRecognition(List<AppLifecycleState> states);
}

/// Recognizes when the app goes state [AppLifecycleState.inactive].
class AppBecomeInactiveRecognizer extends AppLifecycleRecognizer {
  const AppBecomeInactiveRecognizer({
    required super.onRecognize,
  });

  @override
  bool didRecognize(List<AppLifecycleState> states) => states.endsWith([
        AppLifecycleState.inactive,
      ]);

  @override
  bool shouldStopRecognition(List<AppLifecycleState> states) =>
      states.contains(AppLifecycleState.inactive);
}

/// Recognizes when the app goes to background (invisible to user).
class AppToBackgroundRecognizer extends AppLifecycleRecognizer {
  const AppToBackgroundRecognizer({
    required super.onRecognize,
  });

  @override
  bool didRecognize(List<AppLifecycleState> states) =>
      states.last == AppLifecycleState.paused;

  @override
  bool shouldStopRecognition(List<AppLifecycleState> states) =>
      states.contains(AppLifecycleState.paused);
}

/// Recognizes a first startup of the application.
class AppStartupRecognizer extends AppLifecycleRecognizer {
  const AppStartupRecognizer({
    required super.onRecognize,
  });

  static const _pattern = [AppLifecycleState.resumed];

  @override
  bool didRecognize(List<AppLifecycleState> states) => states.equals(_pattern);

  @override
  bool shouldStopRecognition(List<AppLifecycleState> states) =>
      states.contains(AppLifecycleState.resumed);
}

/// Recognizes when the application was in background (not visible) and
/// comes back to foreground
///
/// System popups (TouchID) do not trigger that recognizer.
class AppResumeFromBackgroundRecognizer extends AppLifecycleRecognizer {
  const AppResumeFromBackgroundRecognizer({
    required super.onRecognize,
  });

  @override
  bool didRecognize(List<AppLifecycleState> states) =>
      states.contains(AppLifecycleState.paused) &&
      states.last == AppLifecycleState.resumed;

  @override
  bool shouldStopRecognition(List<AppLifecycleState> states) =>
      states.contains(AppLifecycleState.resumed);
}

/// Internal state of an [AppLifecycleRecognizer].
class _AppLifecycleRecognizerState {
  _AppLifecycleRecognizerState(this.recognizer);

  final _states = <AppLifecycleState>[];

  final AppLifecycleRecognizer recognizer;

  void didChangeAppLifecycle(AppLifecycleState state) {
    log(
      'Did change appLifecycle : $state',
      name: recognizer.runtimeType.toString(),
    );
    _states.add(state);

    if (recognizer.didRecognize(_states)) {
      log(
        'Recognized with $_states',
        name: recognizer.runtimeType.toString(),
      );
      recognizer.onRecognize();
      _states.clear();
      return;
    }

    if (recognizer.shouldStopRecognition(_states)) {
      log(
        'Reset recognition with $_states',
        name: recognizer.runtimeType.toString(),
      );
      _states.clear();
      return;
    }
  }
}

/// Listens to app state changes and triggers
/// [AppLifecycleRecognizer]s accordingly.
class AppLifecycleStateListener extends StatefulWidget {
  const AppLifecycleStateListener({
    super.key,
    required this.child,
    required this.recognizers,
  });

  final Widget child;
  final List<AppLifecycleRecognizer> recognizers;

  @override
  State<StatefulWidget> createState() => _AutoLockGuardState();
}

class _AutoLockGuardState extends State<AppLifecycleStateListener>
    with WidgetsBindingObserver {
  List<_AppLifecycleRecognizerState> _recognizersStates = [];

  @override
  void initState() {
    super.initState();
    _recognizersStates =
        widget.recognizers.map(_AppLifecycleRecognizerState.new).toList();

    WidgetsBinding.instance.addObserver(this);
    _didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _didChangeAppLifecycleState(state);
    super.didChangeAppLifecycleState(state);
  }

  void _didChangeAppLifecycleState(AppLifecycleState state) {
    for (final recognizer in _recognizersStates) {
      recognizer.didChangeAppLifecycle(state);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
