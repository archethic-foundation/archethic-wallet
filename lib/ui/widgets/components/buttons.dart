/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

enum AppButtonType { primary, primaryOutline }

// ignore: avoid_classes_with_only_static_members
class AppButton {
  // Primary button builder
  static Widget buildAppButton(Key key, BuildContext context,
      AppButtonType type, String buttonText, List<double> dimens,
      {required Function onPressed, bool disabled = false, Icon? icon}) {
    switch (type) {
      case AppButtonType.primary:
        return Expanded(
          child: Container(
            width: 400,
            decoration: ShapeDecoration(
              gradient: StateContainer.of(context).curTheme.gradientMainButton!,
              shape: const StadiumBorder(),
              shadows: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: icon == null
                ? TextButton(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style:
                            AppStyles.textStyleSize18W600EquinoxMainButtonLabel(
                                context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light,
                            StateContainer.of(context).activeVibrations);
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    icon: icon,
                    label: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style:
                            AppStyles.textStyleSize18W600EquinoxMainButtonLabel(
                                context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light,
                            StateContainer.of(context).activeVibrations);
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.primaryOutline:
        return Expanded(
          child: Container(
            width: 400,
            decoration: ShapeDecoration(
                gradient: StateContainer.of(context).curTheme.gradient!,
                shape: const StadiumBorder()),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: icon == null
                ? TextButton(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles
                            .textStyleSize18W600EquinoxMainButtonLabelDisabled(
                                context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light,
                            StateContainer.of(context).activeVibrations);
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    key: key,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    icon: icon,
                    label: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles
                            .textStyleSize18W600EquinoxMainButtonLabelDisabled(
                                context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light,
                            StateContainer.of(context).activeVibrations);
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      default:
        throw Exception('Invalid Button Type $type');
    }
  } //
}
