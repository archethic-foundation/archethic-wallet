import 'package:flutter/material.dart';

extension CustomTextStyles on TextTheme {
  TextStyle get bodySmallWithOpacity => bodySmall!.copyWith(
        color: bodySmall!.color?.withOpacity(0.8),
      );

  TextStyle get bodyMediumlWithOpacity => bodyMedium!.copyWith(
        color: bodyMedium!.color?.withOpacity(0.8),
      );

  TextStyle get titleSmallSemiBold => titleSmall!.copyWith(
        fontWeight: FontWeightTelegraf.fontWeightSemibold,
      );

  TextStyle get bodySmallLink => bodySmallWithOpacity.copyWith(
        decoration: TextDecoration.underline,
        color: const Color(0xFF8A40BF),
      );
}

extension ArchethicGradients on LinearGradient {
  static LinearGradient get archethicLinearBlue => const LinearGradient(
        colors: [
          Color(0xFF6E42F0),
          Color(0xFF3B0FBD),
        ],
      );

  static LinearGradient get gradientArchethic => const LinearGradient(
        colors: [
          Color(0xFF8A40BF),
          Color(0xFFB98CD9),
        ],
      );
}

extension FontWeightTelegraf on FontWeight {
  // TODO(reddwarf03): Use in project
  static FontWeight get fontWeightUltralight => FontWeight.w200;
  static FontWeight get fontWeightLight => FontWeight.w300;
  static FontWeight get fontWeightRegular => FontWeight.w400;
  static FontWeight get fontWeightMedium => FontWeight.w500;
  static FontWeight get fontWeightSemibold => FontWeight.w600;
  static FontWeight get fontWeightBold => FontWeight.w700;
  static FontWeight get fontWeightUltrabold => FontWeight.w800;
  static FontWeight get fontWeightBlack => FontWeight.w900;
}
