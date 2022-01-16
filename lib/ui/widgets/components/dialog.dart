// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';

// ignore: avoid_classes_with_only_static_members
class AppDialogs {
  static void showConfirmDialog(BuildContext context, String title,
      String content, String buttonText, Function onPressed,
      {String? cancelText, Function? cancelAction}) {
    cancelText ??= AppLocalization.of(context)!.cancel.toUpperCase();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppStyles.textStyleSize20W700Primary(context),
          ),
          content: Text(content,
              style: AppStyles.textStyleSize16W200Primary(context)),
          actions: <Widget>[
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  cancelText!,
                  style: AppStyles.textStyleSize12W600Primary(context),
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
                  style: AppStyles.textStyleSize12W600Primary(context),
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
}

enum AnimationType {
  send,
}

class AnimationLoadingOverlay extends ModalRoute<void> {
  AnimationLoadingOverlay(this.type, this.overlay85, this.overlay70,
      {this.onPoppedCallback});

  AnimationType type;
  Function? onPoppedCallback;
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
    return overlay70;
  }

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  void didComplete(void result) {
    if (onPoppedCallback != null) {
      onPoppedCallback!();
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
      case AnimationType.send:
        return const Center();
      default:
        return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                StateContainer.of(context).curTheme.primary60!));
    }
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: type == AnimationType.send
          ? MainAxisAlignment.end
          : MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: type == AnimationType.send
              ? const EdgeInsets.only(bottom: 10.0, left: 90, right: 90)
              : EdgeInsets.zero,
          //Widgth/Height ratio is needed because BoxFit is not working as expected
          width: type == AnimationType.send ? double.infinity : 100,
          height: type == AnimationType.send
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
