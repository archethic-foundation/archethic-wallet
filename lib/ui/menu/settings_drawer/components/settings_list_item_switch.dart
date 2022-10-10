/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_drawer.dart';

class _SettingsListItemSwitch extends _SettingsListItem {
  const _SettingsListItemSwitch({
    required this.heading,
    required this.icon,
    required this.iconColor,
    required this.isSwitched,
    this.onChanged,
  });

  final String heading;
  final String icon;
  final Color iconColor;
  final bool isSwitched;
  final Function? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
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
              child: IconWidget(
                icon: icon,
                width: 30,
                height: 30,
                color: iconColor,
              ),
            ),
            SizedBox(
              width: Responsive.drawerWidth(context) - 130,
              child: Text(
                heading,
                style: theme.textStyleSize16W600EquinoxPrimary,
              ),
            ),
            Switch(
              value: isSwitched,
              onChanged: (bool value) {
                if (onChanged == null) return;
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
                    );
                onChanged?.call(value);
              },
              inactiveTrackColor: theme.inactiveTrackColorSwitch,
              activeTrackColor: theme.activeTrackColorSwitch,
              activeColor: theme.backgroundDark,
            )
          ],
        ),
      ),
    );
  }
}
