import 'package:flutter/material.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

class ArchethicThemeBase {
  /// Neutral
  static final Color neutral0 = const HSLColor.fromAHSL(1, 0, 0, 1).toColor();
  static final Color neutral10 =
      const HSLColor.fromAHSL(0.5, 0, 0, 1).toColor();
  static final Color neutral40 =
      const HSLColor.fromAHSL(1, 210, 0, 0.96).toColor();
  static final Color neutral50 =
      const HSLColor.fromAHSL(1, 220, 0, 0.95).toColor();
  static final Color neutral100 =
      const HSLColor.fromAHSL(1, 225, 0, 0.90).toColor();
  static final Color neutral200 =
      const HSLColor.fromAHSL(1, 210, 0, 0.80).toColor();
  static final Color neutral300 =
      const HSLColor.fromAHSL(1, 0, 0, 0.70).toColor();
  static final Color neutral400 =
      const HSLColor.fromAHSL(1, 0, 0, 0.60).toColor();
  static final Color neutral500 =
      const HSLColor.fromAHSL(1, 0, 0, 0.50).toColor();
  static final Color neutral600 =
      const HSLColor.fromAHSL(1, 0, 0, 0.40).toColor();
  static final Color neutral700 =
      const HSLColor.fromAHSL(1, 0, 0, 0.30).toColor();
  static final Color neutral800 =
      const HSLColor.fromAHSL(1, 0, 0, 0.20).toColor();
  static final Color neutral850 =
      const HSLColor.fromAHSL(1, 0, 0, 0.15).toColor();
  static final Color neutral900 =
      const HSLColor.fromAHSL(1, 0, 0, 0.10).toColor();

  /// Brand
  static Color purple500 = const HSLColor.fromAHSL(1, 250, 0.5, 0.2).toColor();
  static Color purple800 = const HSLColor.fromAHSL(1, 250, 0.5, 0.5).toColor();

  static Color blue400 = const HSLColor.fromAHSL(1, 255, 0.85, 0.6).toColor();
  static Color blue600 = const HSLColor.fromAHSL(1, 255, 0.85, 0.4).toColor();
  static Color blue700 = const HSLColor.fromAHSL(1, 255, 0.86, 0.3).toColor();

  static Color raspberry50 =
      const HSLColor.fromAHSL(1, 275, 0.5, 0.95).toColor();
  static Color raspberry200 =
      const HSLColor.fromAHSL(1, 275, 0.5, 0.8).toColor();
  static Color raspberry300 =
      const HSLColor.fromAHSL(1, 275, 0.5, 0.7).toColor();
  static Color raspberry500 =
      const HSLColor.fromAHSL(1, 275, 0.5, 0.5).toColor();

  static Color dropdownBackground =
      const HSLColor.fromAHSL(1, 255, 0.2, 0.15).toColor();
  static Color dropdownBackgroundBorder =
      const HSLColor.fromAHSL(1, 255, 0.2, 0.225).toColor();

  // Cards
  // - Transparent
  static Color paleTransparentBackground =
      const HSLColor.fromAHSL(0.1, 0, 0, 0.1).toColor();
  static Color paleTransparentBorder =
      const HSLColor.fromAHSL(0.1, 0, 0, 0.9).toColor();
  static Color paleTransparentHoverBackground =
      const HSLColor.fromAHSL(0.2, 0, 0, 1).toColor();
  static Color paleTransparentHoverBorder =
      const HSLColor.fromAHSL(0.2, 0, 0, 0.9).toColor();
  // - Pale Purple
  static Color palePurpleBackground =
      const HSLColor.fromAHSL(0.1, 250, 0.5, 0.5).toColor();
  static Color palePurpleBorder =
      const HSLColor.fromAHSL(0.2, 250, 0.5, 0.5).toColor();
  // - Bright Purple
  static Color brightPurpleBackground =
      const HSLColor.fromAHSL(0.3, 250, 0.5, 0.5).toColor();
  static Color brightPurpleBorder =
      const HSLColor.fromAHSL(0.4, 250, 0.5, 0.5).toColor();
  static Color brightPurpleHoverBackground =
      const HSLColor.fromAHSL(0.4, 250, 0.5, 0.5).toColor();
  static Color brightPurpleHoverBorder =
      const HSLColor.fromAHSL(0.5, 250, 0.5, 0.5).toColor();

  /// System
  static Color systemInfo50 =
      const HSLColor.fromAHSL(1, 210, 0.8, 0.95).toColor();
  static Color systemInfo100 =
      const HSLColor.fromAHSL(1, 210, 0.8, 0.90).toColor();
  static Color systemInfo300 =
      const HSLColor.fromAHSL(1, 210, 0.8, 0.7).toColor();
  static Color systemInfo500 =
      const HSLColor.fromAHSL(1, 210, 0.8, 0.5).toColor();
  static Color systemInfo600 =
      const HSLColor.fromAHSL(1, 210, 0.8, 0.4).toColor();

  static Color systemDanger50 =
      const HSLColor.fromAHSL(1, 355, 0.8, 0.95).toColor();
  static Color systemDanger100 =
      const HSLColor.fromAHSL(1, 355, 0.8, 0.9).toColor();
  static Color systemDanger300 =
      const HSLColor.fromAHSL(1, 355, 0.8, 0.7).toColor();
  static Color systemDanger500 =
      const HSLColor.fromAHSL(1, 355, 0.8, 0.5).toColor();
  static Color systemDanger600 =
      const HSLColor.fromAHSL(1, 355, 0.8, 0.4).toColor();

  static Color systemWarning50 =
      const HSLColor.fromAHSL(1, 50, 0.8, 0.95).toColor();
  static Color systemWarning100 =
      const HSLColor.fromAHSL(1, 50, 0.8, 0.9).toColor();
  static Color systemWarning300 =
      const HSLColor.fromAHSL(1, 50, 0.8, 0.7).toColor();
  static Color systemWarning500 =
      const HSLColor.fromAHSL(1, 50, 0.8, 0.5).toColor();
  static Color systemWarning600 =
      const HSLColor.fromAHSL(1, 50, 0.8, 0.4).toColor();

  static Color systemPositive50 =
      const HSLColor.fromAHSL(1, 140, 0.8, 0.95).toColor();
  static Color systemPositive100 =
      const HSLColor.fromAHSL(1, 140, 0.8, 0.9).toColor();
  static Color systemPositive300 =
      const HSLColor.fromAHSL(1, 140, 0.8, 0.7).toColor();
  static Color systemPositive500 =
      const HSLColor.fromAHSL(1, 140, 0.8, 0.5).toColor();
  static Color systemPositive600 =
      const HSLColor.fromAHSL(1, 140, 0.8, 0.4).toColor();
}
