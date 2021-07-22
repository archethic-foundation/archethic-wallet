// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flare_flutter/flare_actor.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_simpledialog.dart';

class AppDialogs {
  static void showConfirmDialog(BuildContext context, String title,
      String content, String buttonText, Function onPressed,
      {String cancelText, Function cancelAction}) {
    cancelText ??= AppLocalization.of(context).cancel.toUpperCase();
    showAppDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: Text(
            title,
            style: AppStyles.textStyleLargeW700Primary(context),
          ),
          content: Text(content, style: AppStyles.textStyleMediumW200Primary(context)),
          actions: <Widget>[
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  cancelText,
                  style: AppStyles.textStyleSmallestW600Primary(context),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (cancelAction != null) {
                  cancelAction();
                }
              },
            ),
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  buttonText,
                  style: AppStyles.textStyleSmallestW600Primary(context),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
            ),
          ],
        );
      },
    );
  }

  static void showInfoDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: Text(
            title,
            style: AppStyles.textStyleLargeW700Primary(context),
          ),
          content: Text(content, style: AppStyles.textStyleMediumW200Primary(context)),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalization.of(context).cancel.toUpperCase(),
                style: AppStyles.textStyleSmallestW600Primary(context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum AnimationType {
  SEND,
  GENERIC,
  TRANSFER_SEARCHING_QR,
  TRANSFER_SEARCHING_MANUAL,
  TRANSFER_TRANSFERRING
}

class AnimationLoadingOverlay extends ModalRoute<void> {
  AnimationLoadingOverlay(this.type, this.overlay85, this.overlay70,
      {this.onPoppedCallback});

  AnimationType type;
  Function onPoppedCallback;
  Color overlay85;
  Color overlay70;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor {
    if (type == AnimationType.TRANSFER_TRANSFERRING ||
        type == AnimationType.TRANSFER_SEARCHING_QR ||
        type == AnimationType.TRANSFER_SEARCHING_MANUAL) {
      return overlay85;
    }
    return overlay70;
  }

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  void didComplete(void result) {
    if (onPoppedCallback != null) {
      onPoppedCallback();
    }
    super.didComplete(result);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _getAnimation(BuildContext context) {
    switch (type) {
      case AnimationType.SEND:
        return const Center();
      case AnimationType.TRANSFER_SEARCHING_QR:
        return Stack(
          children: <Widget>[
            const Center(
              child: FlareActor(
                'assets/searchseedqr_animation_qronly.flr',
                animation: 'main',
                fit: BoxFit.contain,
              ),
            ),
            const Center(
              child: FlareActor(
                'assets/searchseedqr_animation_glassonly.flr',
                animation: 'main',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: FlareActor(
                'assets/searchseedqr_animation_magnifyingglassonly.flr',
                animation: 'main',
                fit: BoxFit.contain,
                color: StateContainer.of(context).curTheme.primary,
              ),
            ),
          ],
        );
      case AnimationType.TRANSFER_SEARCHING_MANUAL:
        return Stack(
          children: <Widget>[
            Center(
              child: FlareActor(
                'assets/searchseedmanual_animation_seedonly.flr',
                animation: 'main',
                fit: BoxFit.contain,
                color: StateContainer.of(context).curTheme.primary30,
              ),
            ),
            const Center(
              child: FlareActor(
                'assets/searchseedmanual_animation_glassonly.flr',
                animation: 'main',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: FlareActor(
                'assets/searchseedmanual_animation_magnifyingglassonly.flr',
                animation: 'main',
                fit: BoxFit.contain,
                color: StateContainer.of(context).curTheme.primary,
              ),
            ),
          ],
        );
      case AnimationType.TRANSFER_TRANSFERRING:
        return Stack(
          children: <Widget>[
            const FlareActor(
              'assets/transfer_animation_paperwalletonly.flr',
              animation: 'main',
              fit: BoxFit.contain,
            ),
          ],
        );
      case AnimationType.GENERIC:
      default:
        return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                StateContainer.of(context).curTheme.primary60));
    }
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: type == AnimationType.SEND
          ? MainAxisAlignment.end
          : MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: type == AnimationType.SEND
              ? const EdgeInsets.only(bottom: 10.0, left: 90, right: 90)
              : EdgeInsets.zero,
          //Widgth/Height ratio is needed because BoxFit is not working as expected
          width: type == AnimationType.SEND ? double.infinity : 100,
          height: type == AnimationType.SEND
              ? MediaQuery.of(context).size.width
              : 100,
          child: _getAnimation(context),
        ),
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
