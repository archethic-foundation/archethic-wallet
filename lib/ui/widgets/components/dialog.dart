/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

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
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return aedappfm.PopupTemplate(
          popupContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  text: '',
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
          popupTitle: title,
          displayCloseButton: false,
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
      useRootNavigator: false,
      builder: (BuildContext context) {
        buttonLabel = buttonLabel ?? AppLocalizations.of(context)!.ok;

        final preferences = ref.watch(SettingsProviders.settings);

        return aedappfm.PopupTemplate(
          popupContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      buttonLabel!,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
              ),
            ],
          ),
          popupTitle: title,
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
    return Scaffold(
      backgroundColor: Colors.black,
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ArchethicTheme.backgroundWelcome,
                  ),
                  fit: kIsWeb ? BoxFit.cover : BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
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
          /*Opacity(
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
          ),*/
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
