/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum AppButtonTinyType { primary, primaryOutline }

class AppButtonTiny extends ConsumerWidget {
  const AppButtonTiny(
    this.type,
    this.buttonText,
    this.dimens, {
    required this.onPressed,
    this.disabled = false,
    this.icon,
    super.key,
  });

  final AppButtonTinyType type;
  final String buttonText;
  final List<double> dimens;
  final Function onPressed;
  final bool disabled;
  final Icon? icon;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    switch (type) {
      case AppButtonTinyType.primary:
        return Expanded(
          child: Container(
            width: 400,
            decoration: ShapeDecoration(
              gradient: theme.gradientMainButton,
              shape: const StadiumBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            height: 35,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: icon == null
                ? TextButton(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: theme.textStyleSize12W400EquinoxMainButtonLabel,
                      maxLines: 1,
                      stepGranularity: 0.5,
                    ),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    key: key,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.text,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: icon!,
                    label: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: theme.textStyleSize12W400EquinoxMainButtonLabel,
                      maxLines: 1,
                      stepGranularity: 0.5,
                    ),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonTinyType.primaryOutline:
        return Expanded(
          child: Container(
            width: 400,
            decoration: ShapeDecoration(
              gradient: theme.gradientMainButton,
              shape: const StadiumBorder(),
            ),
            height: 35,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: icon == null
                ? TextButton(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: theme
                          .textStyleSize12W400EquinoxMainButtonLabelDisabled,
                      maxLines: 1,
                      stepGranularity: 0.5,
                    ),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: icon!,
                    label: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: theme
                          .textStyleSize12W400EquinoxMainButtonLabelDisabled,
                      maxLines: 1,
                      stepGranularity: 0.5,
                    ),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
    }
  } //
}
