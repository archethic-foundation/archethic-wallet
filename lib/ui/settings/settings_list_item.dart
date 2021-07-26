// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/model/setting_item.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';

class AppSettings {
  //Settings item with a dropdown option
  static Widget buildSettingsListItemWithDefaultValue(
      BuildContext context,
      String heading,
      SettingSelectionItem defaultMethod,
      IconData icon,
      Function onPressed,
      {bool disabled = false}) {
    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          height: 30.0,
          margin: const EdgeInsetsDirectional.only(start: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsetsDirectional.only(end: 13.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(icon,
                          color: disabled
                              ? StateContainer.of(context).curTheme.icon45
                              : StateContainer.of(context).curTheme.icon,
                          size: 24),
                      const SizedBox(width: 16),
                      AutoSizeText(
                        heading,
                        style: disabled
                            ? AppStyles.textStyleMediumW600Text45(context)
                            : AppStyles.textStyleMediumW600Primary(context),
                        maxLines: 1,
                        stepGranularity: 0.1,
                        minFontSize: 8,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      top: 3, left: 3, bottom: 3, right: 3),
                ),
              ),
              AutoSizeText(
                defaultMethod.getDisplayName(context),
                style: disabled
                    ? AppStyles.textStyleSmallestW100Text30(context)
                    : AppStyles.textStyleSmallestW100Text60(context),
                maxLines: 1,
                stepGranularity: 0.1,
                minFontSize: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildSettingsListItemWithDefaultValueWithInfos(
      BuildContext context,
      String heading,
      String info,
      SettingSelectionItem defaultMethod,
      IconData icon,
      Function onPressed,
      {bool disabled = false}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 60.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  icon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: const EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: UIUtil.drawerWidth(context) - 69,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            heading,
                            style:
                                AppStyles.textStyleMediumW600Primary(context),
                          ),
                          Text(
                            defaultMethod.getDisplayName(context),
                            style: disabled
                                ? AppStyles.textStyleSmallestW100Text30(
                                    context)
                                : AppStyles.textStyleSmallestW100Text60(
                                    context),
                          ),
                        ],
                      )),
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      info,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                      style: AppStyles.textStyleSmallestW100Text60(context),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSingleLineWithInfos(
      BuildContext context, String heading, String info, IconData settingIcon,
      {Function onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 60.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: const EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: Text(
                      heading,
                      style: AppStyles.textStyleMediumW600Primary(context),
                    ),
                  ),
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      info,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                      style: AppStyles.textStyleSmallestW100Text60(context),
                    ),
                  ),
                ]),
            Container(
              child: Icon(
                FontAwesome5.chevron_right,
                color: StateContainer.of(context).curTheme.icon,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Settings item without any dropdown option but rather a direct functionality
  static Widget buildSettingsListItemSingleLine(
      BuildContext context, String heading, IconData settingIcon,
      {Function onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 30.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: const EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Container(
              width: UIUtil.drawerWidth(context) - 100,
              child: Text(
                heading,
                style: AppStyles.textStyleMediumW600Primary(context),
              ),
            ),
            Container(
              child: Icon(
                FontAwesome5.chevron_right,
                color: StateContainer.of(context).curTheme.icon,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSwitch(BuildContext context,
      String heading, IconData settingIcon, bool _isSwitched,
      {Function onChanged}) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 30.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: const EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Container(
                width: UIUtil.drawerWidth(context) - 100,
                child: Row(
                  children: [
                    Text(
                      heading,
                      style: AppStyles.textStyleMediumW600Primary(context),
                    ),
                    Switch(
                        value: _isSwitched == null ? false : _isSwitched,
                        onChanged: (value) {
                          if (onChanged != null) {
                            _isSwitched = value;
                            onChanged(_isSwitched);
                          } else {
                            return;
                          }
                        },
                        activeTrackColor: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        activeColor: Colors.green),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
