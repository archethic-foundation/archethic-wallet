// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/util/exceptions.dart';

enum AppButtonType {
  PRIMARY,
  PRIMARY_OUTLINE,
  SUCCESS,
  SUCCESS_OUTLINE,
  TEXT_OUTLINE
}

class AppButton {
  // Primary button builder
  static Widget buildAppButton(BuildContext context, AppButtonType type,
      String buttonText, List<double> dimens,
      {Function onPressed, bool disabled = false}) {
    switch (type) {
      case AppButtonType.PRIMARY:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: disabled
                  ? StateContainer.of(context).curTheme.primary60
                  : StateContainer.of(context).curTheme.primary,
              child: AutoSizeText(buttonText,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleButtonPrimary(context),
                  maxLines: 1,
                  stepGranularity: 0.5),
              onPressed: () {
                if (onPressed != null && !disabled) {
                  onPressed();
                }
                return;
              },
              highlightColor: StateContainer.of(context).curTheme.background40,
              splashColor: StateContainer.of(context).curTheme.background40,
            ),
          ),
        );
      case AppButtonType.PRIMARY_OUTLINE:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: OutlineButton(
              color: StateContainer.of(context).curTheme.backgroundDark,
              textColor: disabled
                  ? StateContainer.of(context).curTheme.primary60
                  : StateContainer.of(context).curTheme.primary,
              borderSide: BorderSide(
                  color: disabled
                      ? StateContainer.of(context).curTheme.primary60
                      : StateContainer.of(context).curTheme.primary,
                  width: 2.0),
              highlightedBorderColor: disabled
                  ? StateContainer.of(context).curTheme.primary60
                  : StateContainer.of(context).curTheme.primary,
              splashColor: StateContainer.of(context).curTheme.primary30,
              highlightColor: StateContainer.of(context).curTheme.primary15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: disabled
                    ? AppStyles.textStyleButtonPrimaryOutlineDisabled(context)
                    : AppStyles.textStyleButtonPrimaryOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null && !disabled) {
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
              borderRadius: BorderRadius.circular(100),
              boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: TextButton(
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonPrimary(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null && !disabled) {
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
              borderRadius: BorderRadius.circular(100),
              boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: OutlinedButton(
             child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonSuccessOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
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
              borderRadius: BorderRadius.circular(100),
              boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
                dimens[0], dimens[1], dimens[2], dimens[3]),
            child: OutlineButton(
              color: StateContainer.of(context).curTheme.backgroundDark,
              textColor: StateContainer.of(context).curTheme.text,
              borderSide: BorderSide(
                  color: StateContainer.of(context).curTheme.text, width: 2.0),
              highlightedBorderColor: StateContainer.of(context).curTheme.text,
              splashColor: StateContainer.of(context).curTheme.text30,
              highlightColor: StateContainer.of(context).curTheme.text15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonTextOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
                return;
              },
            ),
          ),
        );
      default:
        throw new UIException("Invalid Button Type $type");
    }
  } //
}
