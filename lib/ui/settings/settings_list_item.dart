// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/model/setting_item.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/icon_widget.dart';

class AppSettings {
  //Settings item with a dropdown option
  static Widget buildSettingsListItemWithDefaultValue(
      BuildContext context,
      String heading,
      SettingSelectionItem defaultMethod,
      String icon,
      Function onPressed,
      {bool disabled = false}) {
    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          height: 40.0,
          margin: const EdgeInsetsDirectional.only(start: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(child: buildIconWidget(context, icon, 30, 30)),
                      const SizedBox(width: 13),
                      AutoSizeText(
                        heading,
                        style: disabled
                            ? AppStyles.textStyleSize16W600Primary30(context)
                            : AppStyles.textStyleSize16W600Primary(context),
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
                    ? AppStyles.textStyleSize12W100Primary30(context)
                    : AppStyles.textStyleSize12W100Primary(context),
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
      String icon,
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
              child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 13.0),
                  child: buildIconWidget(context, icon, 30, 30)),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
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
                  Container(
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
      BuildContext context, String heading, String info,
      {Function onPressed, String icon}) {
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
                child: buildIconWidget(context, icon, 30, 30)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: Text(
                      heading,
                      style: AppStyles.textStyleSize16W600Primary(context),
                    ),
                  ),
                  Container(
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
            Container(
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
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
      BuildContext context, String heading, String icon,
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
              child: Container(child: buildIconWidget(context, icon, 30, 30)),
            ),
            Container(
              width: UIUtil.drawerWidth(context) - 100,
              child: AutoSizeText(
                heading,
                style: AppStyles.textStyleSize16W600Primary(context),
              ),
            ),
            Container(
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: StateContainer.of(context).curTheme.icon,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSwitch(
      BuildContext context, String heading, String icon, bool _isSwitched,
      {Function onChanged}) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 30.0,
        margin: const EdgeInsetsDirectional.only(start: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 13.0),
                  child: buildIconWidget(context, icon, 30, 30)),
            ),
            Container(
                width: UIUtil.drawerWidth(context) - 70,
                child: Row(
                  children: <Widget>[
                    Text(
                      heading,
                      style: AppStyles.textStyleSize16W600Primary(context),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Switch(
                        value: _isSwitched ?? false,
                        onChanged: (bool value) {
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
