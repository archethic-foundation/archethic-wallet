// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/appstate_container.dart';
import 'package:core/model/setting_item.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/util/ui_util.dart';
import 'package:core/ui/widgets/components/icon_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: avoid_classes_with_only_static_members
class AppSettings {
  //Settings item with a dropdown option
  static Widget buildSettingsListItemWithDefaultValue(
      BuildContext context,
      String heading,
      SettingSelectionItem defaultMethod,
      String icon,
      Color iconColor,
      Function onPressed,
      {bool disabled = false}) {
    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          height: 55.0,
          margin: const EdgeInsetsDirectional.only(start: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsetsDirectional.only(end: 13.0),
                  child:
                      buildIconWidget(context, icon, 30, 30, color: iconColor)),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: UIUtil.drawerWidth(context) - 100,
                      child: Text(
                        heading,
                        style: disabled
                            ? AppStyles.textStyleSize16W600Primary30(context)
                            : AppStyles.textStyleSize16W600Primary(context),
                      ),
                    ),
                    AutoSizeText(
                      defaultMethod.getDisplayName(context),
                      style: disabled
                          ? AppStyles.textStyleSize12W100Primary30(context)
                          : AppStyles.textStyleSize12W100Primary(context),
                      maxLines: 1,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                    ),
                  ]),
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
      String icon,
      Color iconColor,
      Function onPressed,
      {bool disabled = false}) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        height: 65.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsetsDirectional.only(end: 13.0),
                child:
                    buildIconWidget(context, icon, 30, 30, color: iconColor)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: UIUtil.drawerWidth(context) - 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            heading,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                          ),
                          Text(
                            defaultMethod.getDisplayName(context),
                            style: disabled
                                ? AppStyles.textStyleSize12W100Primary30(
                                    context)
                                : AppStyles.textStyleSize12W100Primary(context),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: UIUtil.drawerWidth(context) - 80,
                    child: AutoSizeText(
                      info,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                      style: AppStyles.textStyleSize12W100Primary(context),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSingleLineWithInfos(
    BuildContext context,
    String heading,
    String info, {
    Function? onPressed,
    String? icon,
    Color? iconColor,
  }) {
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
                child:
                    buildIconWidget(context, icon!, 30, 30, color: iconColor)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: Text(
                      heading,
                      style: AppStyles.textStyleSize16W600Primary(context),
                    ),
                  ),
                  SizedBox(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      info,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                      style: AppStyles.textStyleSize12W100Primary(context),
                    ),
                  ),
                ]),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: StateContainer.of(context).curTheme.icon,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  //Settings item without any dropdown option but rather a direct functionality
  static Widget buildSettingsListItemSingleLine(
      BuildContext context, String heading, String icon, Color iconColor,
      {Function? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 50.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                  child:
                      buildIconWidget(context, icon, 30, 30, color: iconColor)),
            ),
            SizedBox(
              width: UIUtil.drawerWidth(context) - 100,
              child: AutoSizeText(
                heading,
                style: AppStyles.textStyleSize16W600Primary(context),
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: StateContainer.of(context).curTheme.icon,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSwitch(BuildContext context,
      String heading, String icon, Color iconColor, bool _isSwitched,
      {Function? onChanged}) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 50.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsetsDirectional.only(end: 13.0),
                child:
                    buildIconWidget(context, icon, 30, 30, color: iconColor)),
            SizedBox(
              width: UIUtil.drawerWidth(context) - 130,
              child: Text(
                heading,
                style: AppStyles.textStyleSize16W600Primary(context),
              ),
            ),
            Switch(
                value: _isSwitched,
                onChanged: (bool value) {
                  if (onChanged != null) {
                    _isSwitched = value;
                    onChanged(_isSwitched);
                  } else {
                    return;
                  }
                },
                activeTrackColor:
                    StateContainer.of(context).curTheme.backgroundDarkest,
                activeColor: Colors.green)
          ],
        ),
      ),
    );
  }
}
