import 'dart:developer';

import 'package:flutter/material.dart';

class LockOverlay {
  LockOverlay(this.child);

  final Widget child;

  OverlayEntry? _overlayEntry;
  static const _logName = 'LockOverlay';

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

    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
}

mixin LockOverlayMixin {
  Widget get child;

  OverlayEntry? _overlayEntry;
  static const _logName = 'LockOverlay';

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

    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
}
