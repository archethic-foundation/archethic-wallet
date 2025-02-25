import 'package:flutter/material.dart';

extension CustomTextStyles on TextTheme {
  TextStyle get bodySmallWithOpacity => bodySmall!.copyWith(
        color: bodySmall!.color?.withOpacity(0.8),
      );

  TextStyle get bodyMediumlWithOpacity => bodyMedium!.copyWith(
        color: bodyMedium!.color?.withOpacity(0.8),
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
