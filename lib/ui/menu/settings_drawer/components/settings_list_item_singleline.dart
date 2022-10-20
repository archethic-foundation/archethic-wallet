/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_drawer.dart';

class _SettingsListItemSingleLineWithInfos extends _SettingsListItem {
  const _SettingsListItemSingleLineWithInfos({
    required this.heading,
    required this.info,
    this.headingStyle,
    this.onPressed,
    this.icon,
    this.iconColor,
  });

  final String heading;
  final String info;
  final TextStyle? headingStyle;
  final Function? onPressed;
  final String? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return TextButton(
      onPressed: () {
        if (onPressed == null) return;
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        onPressed?.call();
      },
      child: Container(
        height: 65,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconWidget(
                icon: icon!,
                width: 30,
                height: 30,
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
                    style:
                        headingStyle ?? theme.textStyleSize16W600EquinoxPrimary,
                  ),
                ),
                SizedBox(
                  width: Responsive.drawerWidth(context) - 100,
                  child: AutoSizeText(
                    info,
                    maxLines: 5,
                    stepGranularity: 0.1,
                    minFontSize: 8,
                    style: theme.textStyleSize12W100Primary,
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: ref.watch(ThemeProviders.selectedTheme).iconDrawer,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsListItemSingleLine extends _SettingsListItem {
  const _SettingsListItemSingleLine({
    required this.heading,
    required this.headingStyle,
    required this.icon,
    required this.iconColor,
    this.onPressed,
  });

  final String heading;
  final TextStyle headingStyle;
  final String icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return TextButton(
      onPressed: () {
        if (onPressed == null) return;

        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        onPressed?.call();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconWidget(
                icon: icon,
                width: 30,
                height: 30,
                color: iconColor,
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
              color: ref.watch(ThemeProviders.selectedTheme).iconDrawer,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
