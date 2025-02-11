import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class AppTextStyles {
  static const kOpacityText = 0.8;

  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle bodyLargeWithOpacity(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context)
              .textTheme
              .bodyLarge!
              .color
              ?.withOpacity(kOpacityText),
        );
  }

  static TextStyle bodyLargeSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
        );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle bodyMediumWithOpacity(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context)
              .textTheme
              .bodyMedium!
              .color
              ?.withOpacity(kOpacityText),
        );
  }

  static TextStyle bodyMediumSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
        );
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  static TextStyle bodySmallWithOpacity(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context)
              .textTheme
              .bodySmall!
              .color
              ?.withOpacity(kOpacityText),
        );
  }

  static TextStyle bodySmallSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
        );
  }
}
