import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

mixin LockOverlayMixin {
  Widget get child;

  OverlayEntry? _overlayEntry;
  static final _logger = Logger('LockOverlay');

  bool get isVisible => _overlayEntry != null;

  void show(BuildContext context) {
    _logger.info('Show');
    if (_overlayEntry != null) {
      _logger.info('... already visible. Abort');
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => child,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
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
