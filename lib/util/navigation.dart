import 'package:flutter/material.dart';

extension MaterialPageRouteX on MaterialPageRoute {
  MaterialPageRoute copyWith({
    WidgetBuilder? builder,
    RouteSettings? settings,
    bool? maintainState,
    bool? fullscreenDialog,
    bool? allowSnapshotting,
  }) =>
      MaterialPageRoute(
        builder: builder ?? this.builder,
        settings: settings ?? this.settings,
        allowSnapshotting: allowSnapshotting ?? this.allowSnapshotting,
        fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
        maintainState: maintainState ?? this.maintainState,
      );
}
