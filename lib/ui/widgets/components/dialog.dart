/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:lit_starfield/lit_starfield.dart';

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
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ArchethicTheme.sheetBackground.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ArchethicTheme.sheetBorder,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '',
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                        children: <InlineSpan>[
                          TextSpan(
                            text: content,
                            style:
                                ArchethicThemeStyles.textStyleSize12W100Primary,
                          ),
                          if (additionalContent != null)
                            TextSpan(
                              text: '\n\n$additionalContent',
                              style: additionalContentStyle ??
                                  ArchethicThemeStyles
                                      .textStyleSize12W100Primary,
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
                        AppButton(
                          key: const Key('cancelButton'),
                          labelBtn: AppLocalizations.of(
                            context,
                          )!
                              .no,
                          onPressed: () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            context.pop();
                            if (cancelAction != null) {
                              cancelAction();
                            }
                          },
                        ),
                        AppButton(
                          key: const Key('yesButton'),
                          labelBtn: AppLocalizations.of(
                            context,
                          )!
                              .yes,
                          onPressed: () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            context.pop();
                            onPressed();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
          insetPadding: EdgeInsets.zero,
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
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
                context.pop();
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ArchethicTheme.backgroundWelcome,
                  ),
                  fit: MediaQuery.of(context).size.width >= 440
                      ? BoxFit.fitWidth
                      : BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                color: ArchethicTheme.text30,
                strokeWidth: 1,
              ),
            ),
          ),
          Opacity(
            opacity: 0.8,
            child: LitStarfieldContainer(
              velocity: 0.2,
              number: 600,
              starColor: ArchethicThemeBase.neutral0,
              scale: 3,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Opacity(
            opacity: 0.3,
            child: LitStarfieldContainer(
              velocity: 0.5,
              number: 300,
              scale: 6,
              starColor: ArchethicThemeBase.blue600,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '${ArchethicTheme.assetsFolder}logo_crystal.png',
                width: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title != null
                    ? title!
                    : AppLocalizations.of(context)!.pleaseWait,
                textAlign: TextAlign.center,
                style: ArchethicThemeStyles.textStyleSize16W600Primary,
              ),
            ],
          ),
        ],
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
