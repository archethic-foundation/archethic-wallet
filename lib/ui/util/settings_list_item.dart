/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

// ignore: avoid_classes_with_only_static_members
class AppSettings {
  //Settings item with a dropdown option
  static Widget buildSettingsListItemWithDefaultValue(
    BuildContext context,
    String heading,
    SettingSelectionItem defaultMethod,
    String icon,
    Color iconColor,
    Function onPressed, {
    bool disabled = false,
  }) {
    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        onPressed: () {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          onPressed();
        },
        child: Container(
          height: 55,
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsetsDirectional.only(end: 13),
                child: IconWidget.build(
                  context,
                  icon,
                  30,
                  30,
                  color: iconColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: Responsive.drawerWidth(context) - 100,
                    child: Text(
                      heading,
                      style: disabled
                          ? AppStyles.textStyleSize16W600EquinoxPrimary30(
                              context,
                            )
                          : AppStyles.textStyleSize16W600EquinoxPrimary(
                              context,
                            ),
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
    Function onPressed, {
    bool disabled = false,
  }) {
    return TextButton(
      onPressed: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
        onPressed();
      },
      child: Container(
        height: 65,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconWidget.build(context, icon, 30, 30, color: iconColor),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: Responsive.drawerWidth(context) - 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        heading,
                        style: AppStyles.textStyleSize16W600EquinoxPrimary(
                          context,
                        ),
                      ),
                      Text(
                        defaultMethod.getDisplayName(context),
                        style: disabled
                            ? AppStyles.textStyleSize12W100Primary30(
                                context,
                              )
                            : AppStyles.textStyleSize12W100Primary(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Responsive.drawerWidth(context) - 80,
                  child: AutoSizeText(
                    info,
                    maxLines: 5,
                    stepGranularity: 0.1,
                    minFontSize: 8,
                    style: AppStyles.textStyleSize12W100Primary(context),
                  ),
                ),
              ],
            ),
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
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 60,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconWidget.build(context, icon!, 30, 30, color: iconColor),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: Responsive.drawerWidth(context) - 100,
                  child: Text(
                    heading,
                    style: AppStyles.textStyleSize16W600EquinoxPrimary(context),
                  ),
                ),
                SizedBox(
                  width: Responsive.drawerWidth(context) - 100,
                  child: AutoSizeText(
                    info,
                    maxLines: 5,
                    stepGranularity: 0.1,
                    minFontSize: 8,
                    style: AppStyles.textStyleSize12W100Primary(context),
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: StateContainer.of(context).curTheme.iconDrawer,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  //Settings item without any dropdown option but rather a direct functionality
  static Widget buildSettingsListItemSingleLine(
    BuildContext context,
    String heading,
    TextStyle headingStyle,
    String icon,
    Color iconColor, {
    Function? onPressed,
  }) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
        height: 50,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: Container(
                child: IconWidget.build(
                  context,
                  icon,
                  30,
                  30,
                  color: iconColor,
                ),
              ),
            ),
            SizedBox(
              width: Responsive.drawerWidth(context) - 100,
              child: AutoSizeText(
                heading,
                style: headingStyle,
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: StateContainer.of(context).curTheme.iconDrawer,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSwitch(
    BuildContext context,
    String heading,
    String icon,
    Color iconColor,
    bool isSwitched, {
    Function? onChanged,
  }) {
    return TextButton(
      onPressed: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
      },
      child: Container(
        height: 50,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconWidget.build(context, icon, 30, 30, color: iconColor),
            ),
            SizedBox(
              width: Responsive.drawerWidth(context) - 130,
              child: Text(
                heading,
                style: AppStyles.textStyleSize16W600EquinoxPrimary(context),
              ),
            ),
            Switch(
              value: isSwitched,
              onChanged: (bool value) {
                if (onChanged != null) {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        StateContainer.of(context).activeVibrations,
                      );
                  onChanged(value);
                } else {
                  return;
                }
              },
              inactiveTrackColor:
                  StateContainer.of(context).curTheme.inactiveTrackColorSwitch,
              activeTrackColor:
                  StateContainer.of(context).curTheme.activeTrackColorSwitch,
              activeColor: StateContainer.of(context).curTheme.backgroundDark,
            )
          ],
        ),
      ),
    );
  }
}
