/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_sheet.dart';

class _SettingsListItemSwitch extends _SettingsListItem {
  const _SettingsListItemSwitch({
    required this.heading,
    required this.icon,
    required this.isSwitched,
    this.onChanged,
  });

  final String heading;
  final IconData icon;
  final bool isSwitched;
  final Function? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Symbols.check);
        }
        return const Icon(Symbols.close);
      },
    );
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
              width: Responsive.drawerWidth(context) - 130,
              child: Text(
                heading,
                style: theme.textStyleSize16W600TelegrafPrimary,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 2),
              height: 30,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: isSwitched,
                  thumbIcon: thumbIcon,
                  onChanged: (bool value) {
                    if (onChanged == null) return;
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    onChanged?.call(value);
                  },
                  inactiveTrackColor: theme.inactiveTrackColorSwitch,
                  activeTrackColor: theme.activeTrackColorSwitch,
                  activeColor: theme.activeColorSwitch,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
