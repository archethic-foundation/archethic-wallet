/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  children: <InlineSpan>[
                    TextSpan(
                      text: content,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    if (additionalContent != null)
                      TextSpan(
                        text: '\n\n$additionalContent',
                        style: additionalContentStyle ??
                            Theme.of(context).textTheme.bodySmallWithOpacity,
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
                  Expanded(
                    child: BtnPrimary(
                      btnPrimaryType: BtnPrimaryType.outlinePrimary,
                      buttonText: AppLocalizations.of(
                        context,
                      )!
                          .no,
                      key: const Key('cancelButton'),
                      onTap: () {
                        context.pop();
                        if (cancelAction != null) {
                          cancelAction();
                        }
                      },
                      widthExpanded: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BtnPrimary(
                      buttonText: AppLocalizations.of(
                        context,
                      )!
                          .yes,
                      key: const Key('yesButton'),
                      onTap: () async {
                        context.pop();
                        onPressed();
                      },
                      widthExpanded: true,
                    ),
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

  static Future showInfoDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    String content, {
    String? buttonLabel,
    Function? onPressed,
  }) async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        buttonLabel = buttonLabel ?? AppLocalizations.of(context)!.ok;
        return aedappfm.PopupTemplate(
          popupContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMediumWithOpacity,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              BtnPrimary(
                buttonText: buttonLabel!,
                key: const Key('yesButton'),
                onTap: () {
                  onPressed?.call();
                  context.pop();
                },
              ),
            ],
          ),
          popupTitle: title,
        );
      },
    );
  }
}

extension ContextLoadingOverlay on BuildContext {
  LoadingOverlay get loadingOverlay => LoadingOverlay.of(this);
}

class LoadingOverlay extends InheritedWidget {
  LoadingOverlay({
    super.key,
    required Widget child,
  }) : super(
          child: _LoadingOverlay(
            key: _loadingOverlayKey,
            child: child,
          ),
        );

  static final _loadingOverlayKey = GlobalKey<_LoadingOverlayState>();

  static LoadingOverlay? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LoadingOverlay>();

  static LoadingOverlay of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No AnimationOverlay found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LoadingOverlay oldWidget) => false;

  void show({String? title}) {
    _loadingOverlayKey.currentState!.show(title: title);
  }

  void hide() {
    _loadingOverlayKey.currentState!.hide();
  }
}

class _LoadingOverlay extends StatefulWidget {
  const _LoadingOverlay({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<_LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<_LoadingOverlay> {
  bool visible = false;
  String? title;

  void show({String? title}) {
    setState(() {
      this.title = title;
      visible = true;
    });
  }

  void hide() {
    setState(() {
      visible = false;
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          widget.child,
          if (visible) LoadingAnimationPage(title: title),
        ],
      );
}

class LoadingAnimationPage extends StatelessWidget {
  const LoadingAnimationPage({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                    fit: BoxFit.cover,
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
      ),
    );
  }
}
