/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppButtonTinyType { primary, primaryOutline }

class AppButtonTinyConnectivity extends ConsumerWidget {
  const AppButtonTinyConnectivity(
    this.buttonText,
    this.dimens, {
    required this.onPressed,
    this.showProgressIndicator = false,
    this.disabled = false,
    this.width = 400,
    super.key,
  });

  final bool showProgressIndicator;
  final String buttonText;
  final Dimens dimens;
  final Function onPressed;
  final bool disabled;
  final double? width;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    final isConnected =
        connectivityStatusProvider == ConnectivityStatus.isConnected;

    return AppButtonTiny(
      (!disabled && isConnected)
          ? AppButtonTinyType.primary
          : AppButtonTinyType.primaryOutline,
      buttonText,
      dimens,
      width: width,
      key: key,
      onPressed: isConnected && !disabled ? onPressed : null,
      disabled: disabled,
      showProgressIndicator: showProgressIndicator,
    );
  }
}

class AppButtonTiny extends ConsumerWidget {
  const AppButtonTiny(
    this.type,
    this.buttonText,
    this.dimens, {
    this.onPressed,
    this.showProgressIndicator = false,
    this.disabled = false,
    this.width = 400,
    super.key,
  });

  final bool showProgressIndicator;
  final AppButtonTinyType type;
  final String buttonText;
  final Dimens dimens;
  final Function? onPressed;
  final bool disabled;
  final double? width;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Expanded(
      child: AppButtonTinyWithoutExpanded(
        type,
        buttonText,
        dimens,
        onPressed: onPressed,
        showProgressIndicator: showProgressIndicator,
        disabled: disabled,
        width: width,
      ),
    );
  } //
}

class AppButtonTinyWithoutExpanded extends ConsumerWidget {
  const AppButtonTinyWithoutExpanded(
    this.type,
    this.buttonText,
    this.dimens, {
    this.onPressed,
    this.showProgressIndicator = false,
    this.disabled = false,
    this.width = 400,
    super.key,
  });

  final bool showProgressIndicator;
  final AppButtonTinyType type;
  final String buttonText;
  final Dimens dimens;
  final Function? onPressed;
  final bool disabled;
  final double? width;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    void handlePressed() {
      if (!disabled) {
        onPressed!();
      }
      return;
    }

    switch (type) {
      case AppButtonTinyType.primary:
        return Container(
          width: width,
          decoration: ShapeDecoration(
            gradient: ArchethicTheme.gradientMainButton,
            shape: const StadiumBorder(),
            shadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 7,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          height: 50,
          margin: dimens.edgeInsetsDirectional,
          child: _NoIconButton(
            showProgressIndicator: showProgressIndicator,
            buttonText: buttonText,
            onPressed: disabled == true ? null : handlePressed,
          ),
        );
      case AppButtonTinyType.primaryOutline:
        return Container(
          width: width,
          decoration: ShapeDecoration(
            gradient: ArchethicTheme.gradientMainButton,
            shape: const StadiumBorder(),
          ),
          height: 50,
          margin: dimens.edgeInsetsDirectional,
          child: _NoIconButton(
            showProgressIndicator: showProgressIndicator,
            buttonText: buttonText,
            onPressed: disabled == true ? null : handlePressed,
          ),
        );
    }
  } //
}

class _NoIconButton extends ConsumerWidget {
  const _NoIconButton({
    required this.showProgressIndicator,
    required this.buttonText,
    required this.onPressed,
  });

  final bool showProgressIndicator;
  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      key: key,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            buttonText,
            textAlign: TextAlign.center,
            style: onPressed == null
                ? ArchethicThemeStyles
                    .textStyleSize16W400MainButtonLabelDisabled
                : ArchethicThemeStyles.textStyleSize16W400MainButtonLabel,
            maxLines: 1,
            stepGranularity: 0.5,
          ),
          if (showProgressIndicator)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox.square(
                dimension: 10,
                child: CircularProgressIndicator(
                  color: ArchethicThemeStyles
                      .textStyleSize16W400MainButtonLabel.color,
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomSmallBtn extends ConsumerWidget {
  const CustomSmallBtn({
    required this.buttonText,
    required this.onPressed,
    this.icon,
    super.key,
  });
  final String buttonText;
  final Function()? onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: aedappfm.AppThemeBase.gradientBtn,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) const SizedBox(width: 5),
                Text(
                  buttonText,
                  style: AppTextStyles.bodySmall(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
