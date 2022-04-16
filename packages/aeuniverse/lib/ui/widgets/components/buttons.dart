/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/ui/util/exceptions.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum AppButtonType {
  primary,
  primaryOutline,
  success,
  successOutline,
  textOutline
}

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
                        style: AppStyles.textStyleSize18W600Primary(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
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
                        style: AppStyles.textStyleSize18W600Primary(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
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
                        style: AppStyles.textStyleSize18W600PrimaryDisabled(
                            context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
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
                        style: AppStyles.textStyleSize18W600PrimaryDisabled(
                            context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.success:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                StateContainer.of(context).curTheme.boxShadowButton!
              ],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: icon == null
                ? TextButton(
                    key: key,
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.primary60
                          : StateContainer.of(context).curTheme.primary,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleSize20W700Background(context),
                      maxLines: 1,
                      stepGranularity: 0.5,
                    ),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    key: key,
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.primary60
                          : StateContainer.of(context).curTheme.primary,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    icon: icon,
                    label: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize20W700Background(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.successOutline:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                StateContainer.of(context).curTheme.boxShadowButton!
              ],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: OutlinedButton(
              key: key,
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSize14W700Success(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                sl.get<HapticUtil>().feedback(FeedbackType.light);
                onPressed();
                return;
              },
            ),
          ),
        );
      case AppButtonType.textOutline:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                StateContainer.of(context).curTheme.boxShadowButton!
              ],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: OutlinedButton(
              key: key,
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSize20W700Primary(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                sl.get<HapticUtil>().feedback(FeedbackType.light);
                onPressed();
                return;
              },
            ),
          ),
        );
      default:
        throw UIException('Invalid Button Type $type');
    }
  } //
}
