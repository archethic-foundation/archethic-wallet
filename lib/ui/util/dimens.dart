import 'package:flutter/material.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

enum Dimens {
  buttonTopDimens(
    EdgeInsetsDirectional.fromSTEB(28, 0, 28, 0),
  ),
  buttonBottomDimens(
    EdgeInsetsDirectional.fromSTEB(28, 8, 28, 0),
  ),
  none(
    EdgeInsetsDirectional.zero,
  );

  const Dimens(this.edgeInsetsDirectional);

  final EdgeInsetsDirectional edgeInsetsDirectional;
}
