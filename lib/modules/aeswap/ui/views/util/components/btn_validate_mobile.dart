/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonValidateMobile extends ConsumerWidget {
  const ButtonValidateMobile({
    super.key,
    required this.controlOk,
    required this.labelBtn,
    required this.onPressed,
    required this.isConnected,
    required this.displayWalletConnectOnPressed,
    this.backgroundGradient,
    this.height = 40,
    this.fontSize = 16,
    this.displayWalletConnect = false,
    this.dimens = aedappfm.Dimens.buttonDimens,
  });

  final bool controlOk;
  final String labelBtn;
  final Function onPressed;
  final Gradient? backgroundGradient;
  final double height;
  final double fontSize;
  final bool displayWalletConnect;
  final bool isConnected;
  final VoidCallback displayWalletConnectOnPressed;
  final List<double> dimens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return aedappfm.ButtonValidate(
      controlOk: controlOk,
      labelBtn: labelBtn,
      onPressed: onPressed,
      isConnected: isConnected,
      displayWalletConnectOnPressed: displayWalletConnectOnPressed,
      backgroundGradient: backgroundGradient,
      height: height,
      fontSize: fontSize,
      displayWalletConnect: displayWalletConnect,
      dimens: dimens,
      key: key,
    );
  }
}
