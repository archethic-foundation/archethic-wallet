import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

// Used by Authentication screens to ensure they are shown on top of
// the screen.
// And cannot be dismissed by background navigations.
//
// Auth setup screens do not need to use this overlay.
class AuthScreenOverlay {
  AuthScreenOverlay({
    required this.name,
    required this.widgetBuilder,
  }) {
    _logger = Logger(name);
  }

  final String name;
  final Widget Function(
    BuildContext context,
    void Function(Uint8List? result) onDone,
  ) widgetBuilder;

  OverlayEntry? _overlayEntry;
  late final Logger _logger;

  bool get isVisible => _overlayEntry != null;

  Future<Uint8List?> show(BuildContext context) {
    final completer = Completer<Uint8List?>();
    _show(
      context,
      completer.complete,
    );
    return completer.future;
  }

  void _show(
    BuildContext context,
    void Function(Uint8List? result) onDone,
  ) {
    _logger.info('Show');
    if (_overlayEntry != null) {
      _logger.info('... already visible. Abort');
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => widgetBuilder(
        context,
        (result) {
          _hide();
          onDone(result);
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hide() {
    _logger.info('Hide');
    if (_overlayEntry == null) {
      _logger.info('... not visible. Abort');
      return;
    }

    /// That delay prevent user inputs to be caught by underlying
    /// screen during Lock overlay hiding.
    /// https://github.com/archethic-foundation/archethic-wallet/issues/942
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        _overlayEntry?.remove();
        _overlayEntry?.dispose();
        _overlayEntry = null;
      },
    );
  }
}
