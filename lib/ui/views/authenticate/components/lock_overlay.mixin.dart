import 'dart:developer';

import 'package:flutter/material.dart';

mixin LockOverlayMixin {
  Widget get child;

  OverlayEntry? _overlayEntry;
  static const _logName = 'LockOverlay';

  bool get isVisible => _overlayEntry != null;

  void show(BuildContext context) {
    log('Show', name: _logName);
    if (_overlayEntry != null) {
      log('... already visible. Abort', name: _logName);
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => child,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    log('Hide', name: _logName);
    if (_overlayEntry == null) {
      log('... not visible. Abort', name: _logName);
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
