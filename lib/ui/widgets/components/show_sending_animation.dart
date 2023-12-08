import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowSendingAnimation {
  static const routerPage = '/sendingAnimation';

  static void build(
    BuildContext context, {
    String? title,
  }) {
    context.push(ShowSendingAnimation.routerPage, extra: title);
  }
}

class AnimationLoadingPage extends StatelessWidget {
  const AnimationLoadingPage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        AnimationLoadingOverlay(
          AnimationType.send,
          ArchethicTheme.animationOverlayStrong,
          title: title,
        ),
      );
    });

    return Container();
  }
}
