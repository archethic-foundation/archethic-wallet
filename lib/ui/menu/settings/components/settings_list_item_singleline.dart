/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_sheet.dart';

class _SettingsListItemSingleLineWithInfos extends _SettingsListItem {
  const _SettingsListItemSingleLineWithInfos({
    required this.heading,
    required this.info,
    this.headingStyle,
    this.onPressed,
    this.icon,
    this.displayChevron = true,
  });

  final String heading;
  final String info;
  final TextStyle? headingStyle;
  final Function? onPressed;
  final IconData? icon;
  final bool? displayChevron;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: () {
        if (onPressed == null) return;
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        onPressed?.call();
      },
      child: Container(
        height: 100,
        margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconDataWidget(
                  icon: icon!,
                  width: AppFontSizes.size28,
                  height: AppFontSizes.size28,
                ),
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
                    style: headingStyle ??
                        theme.textStyleSize16W600TelegrafPrimary,
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
            const Spacer(),
            if (displayChevron != null && displayChevron == true)
              Icon(
                Symbols.chevron_right,
                color: theme.iconDrawer,
                weight: IconSize.weightM,
                opticalSize: IconSize.opticalSizeM,
                grade: IconSize.gradeM,
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
    this.onPressed,
  });

  final String heading;
  final TextStyle headingStyle;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
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
        margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 13),
              child: IconDataWidget(
                icon: icon,
                width: AppFontSizes.size28,
                height: AppFontSizes.size28,
              ),
            ),
            SizedBox(
              width: Responsive.drawerWidth(context) - 100,
              child: AutoSizeText(
                heading,
                style: headingStyle,
              ),
            ),
            const Spacer(),
            Icon(
              Symbols.chevron_right,
              color: theme.iconDrawer,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
            ),
          ],
        ),
      ),
    );
  }
}
