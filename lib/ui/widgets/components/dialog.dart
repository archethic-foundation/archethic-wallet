/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AppDialogs {
  static Future showConfirmDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    String content,
    String buttonText,
    Function onPressed, {
    String? cancelText,
    Function? cancelAction,
    TextStyle? titleStyle,
    String? additionalContent,
    TextStyle? additionalContentStyle,
  }) async {
    final preferences = ref.watch(SettingsProviders.settings);
    cancelText ??= AppLocalizations.of(context)!.cancel;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style:
                titleStyle ?? ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: ArchethicTheme.text45,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: content,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                    if (additionalContent != null)
                      TextSpan(
                        text: '\n\n$additionalContent',
                        style: additionalContentStyle ??
                            ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _AppDialogsButton(
                    key: const Key('cancelButton'),
                    textButton: cancelText!,
                    onPressed: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Navigator.of(context).pop();
                      if (cancelAction != null) {
                        cancelAction();
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _AppDialogsButton(
                    key: const Key('yesButton'),
                    textButton: buttonText,
                    onPressed: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Navigator.of(context).pop();
                      onPressed();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showInfoDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    String content, {
    String? buttonLabel,
    Function? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        buttonLabel = buttonLabel ?? AppLocalizations.of(context)!.ok;

        final preferences = ref.watch(SettingsProviders.settings);
        return AlertDialog(
          title: Text(
            title,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: ArchethicTheme.text45,
            ),
          ),
          content: Text(
            content,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
          ),
          actions: <Widget>[
            TextButton(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  buttonLabel!,
                  style: ArchethicThemeStyles.textStyleSize12W400Primary,
                ),
              ),
              onPressed: () {
                onPressed?.call();
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _AppDialogsButton extends ConsumerWidget {
  const _AppDialogsButton({
    required this.textButton,
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;
  final String textButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 90),
        child: Text(
          textButton,
          textAlign: TextAlign.center,
          style: ArchethicThemeStyles.textStyleSize12W400Primary,
        ),
      ),
    );
  }
}

enum AnimationType {
  send,
}

class AnimationLoadingOverlay extends ModalRoute<void> {
  AnimationLoadingOverlay(
    this.type,
    this.overlay70, {
    this.onPoppedCallback,
    this.title,
  });

  AnimationType type;
  Function? onPoppedCallback;
  Color overlay70;
  String? title;

  @override
  Duration get transitionDuration => Duration.zero;

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
      onPoppedCallback?.call();
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
        child: _AnimationLoadingOverlayContent(
          type: type,
          title: title,
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class PulsatingCircleLogo extends ConsumerStatefulWidget {
  const PulsatingCircleLogo({super.key, this.title});
  final String? title;

  @override
  ConsumerState<PulsatingCircleLogo> createState() =>
      PulsatingCircleLogoState();
}

class PulsatingCircleLogoState extends ConsumerState<PulsatingCircleLogo>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeOut,
      ),
    );
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      ArchethicTheme.iconDrawer.withOpacity(0.3),
      ArchethicTheme.iconDrawer.withOpacity(0.15),
      ArchethicTheme.iconDrawer.withOpacity(0.05),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ArchethicTheme.iconDrawer,
                shape: BoxShape.circle,
                boxShadow: [
                  for (int i = 0; i < colors.length; i++)
                    BoxShadow(
                      color: colors[i],
                      spreadRadius: _animation.value * (i + 1),
                    ),
                ],
              ),
              child: SvgPicture.asset(
                '${ArchethicTheme.assetsFolder}${ArchethicTheme.logoAlone}.svg',
                height: 30,
              ),
            );
          },
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          widget.title != null
              ? widget.title!
              : AppLocalizations.of(context)!.pleaseWait,
          textAlign: TextAlign.center,
          style: ArchethicThemeStyles.textStyleSize16W600Primary,
        ),
      ],
    );
  }
}

class _AnimationLoadingOverlayGetAnimation extends StatelessWidget {
  const _AnimationLoadingOverlayGetAnimation({
    required this.type,
    this.title,
  });

  final AnimationType type;
  final String? title;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AnimationType.send:
        return PulsatingCircleLogo(
          title: title,
        );
    }
  }
}

class _AnimationLoadingOverlayContent extends StatelessWidget {
  const _AnimationLoadingOverlayContent({
    required this.type,
    this.title,
  });

  final AnimationType type;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      margin: type == AnimationType.send
          ? const EdgeInsets.only(bottom: 10, left: 90, right: 90)
          : EdgeInsets.zero,
      child: Center(
        child: _AnimationLoadingOverlayGetAnimation(
          type: type,
          title: title,
        ),
      ),
    );
  }
}
