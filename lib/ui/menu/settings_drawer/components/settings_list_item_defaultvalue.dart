/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_drawer.dart';

class _SettingsListItemWithDefaultValue extends _SettingsListItem {
  const _SettingsListItemWithDefaultValue({
    required this.heading,
    required this.defaultMethod,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  });

  final String heading;
  final SettingSelectionItem defaultMethod;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(),
          ),
        ),
        onPressed: () {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
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
                child: IconDataWidget(
                  icon: icon,
                  width: AppFontSizes.size24,
                  height: AppFontSizes.size24,
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
                          ? theme.textStyleSize16W600EquinoxPrimary30
                          : theme.textStyleSize16W600EquinoxPrimary,
                    ),
                  ),
                  AutoSizeText(
                    defaultMethod.getDisplayName(context),
                    style: disabled
                        ? theme.textStyleSize12W100Primary30
                        : theme.textStyleSize12W100Primary,
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
}

class _SettingsListItemWithDefaultValueWithInfos extends _SettingsListItem {
  const _SettingsListItemWithDefaultValueWithInfos({
    required this.heading,
    required this.info,
    required this.defaultMethod,
    required this.icon,
    required this.onPressed,
    required this.disabled,
  });

  final String heading;
  final String info;
  final SettingSelectionItem defaultMethod;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

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
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        onPressed();
      },
      child: Container(
        height: 75,
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 12),
              child: IconDataWidget(
                icon: icon,
                width: AppFontSizes.size24,
                height: AppFontSizes.size24,
              ),
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
                        style: theme.textStyleSize16W600EquinoxPrimary,
                      ),
                      Text(
                        defaultMethod.getDisplayName(context),
                        style: disabled
                            ? theme.textStyleSize12W100Primary30
                            : theme.textStyleSize12W100Primary,
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
                    style: theme.textStyleSize12W100Primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
