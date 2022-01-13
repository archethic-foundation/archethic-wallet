// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/util/exceptions.dart';

enum AppButtonType {
  PRIMARY,
  PRIMARY_OUTLINE,
  SUCCESS,
  SUCCESS_OUTLINE,
  TEXT_OUTLINE
}

// ignore: avoid_classes_with_only_static_members
class AppButton {
  // Primary button builder
  static Widget buildAppButton(BuildContext context, AppButtonType type,
      String buttonText, List<double> dimens,
      {required Function onPressed, bool disabled = false, Icon? icon}) {
    switch (type) {
      case AppButtonType.PRIMARY:
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
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.primary
                          : StateContainer.of(context).curTheme.primary,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize20W700Background(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.primary
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
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.PRIMARY_OUTLINE:
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
            child: icon == null
                ? TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.background40
                          : StateContainer.of(context).curTheme.background,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize20W700Primary(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: disabled
                          ? StateContainer.of(context).curTheme.background40
                          : StateContainer.of(context).curTheme.background,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    icon: icon,
                    label: AutoSizeText(buttonText,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize20W700Primary(context),
                        maxLines: 1,
                        stepGranularity: 0.5),
                    onPressed: () {
                      if (!disabled) {
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.SUCCESS:
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
                        onPressed();
                      }
                      return;
                    },
                  )
                : TextButton.icon(
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
                        onPressed();
                      }
                      return;
                    },
                  ),
          ),
        );
      case AppButtonType.SUCCESS_OUTLINE:
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
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSize14W700Success(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                onPressed();
                return;
              },
            ),
          ),
        );
      case AppButtonType.TEXT_OUTLINE:
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
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSize14W700Primary(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
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
