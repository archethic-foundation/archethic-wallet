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
    final thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Symbols.check);
        }
        return const Icon(Symbols.close);
      },
    );
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: () {},
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
            Expanded(
              child: Text(
                heading,
                style: ArchethicThemeStyles.textStyleSize16W600Primary,
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              height: 30,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Switch(
                  value: isSwitched,
                  thumbIcon: thumbIcon,
                  onChanged: (bool value) {
                    if (onChanged == null) return;
                    onChanged?.call(value);
                  },
                  inactiveTrackColor: ArchethicTheme.inactiveTrackColorSwitch,
                  activeTrackColor: ArchethicTheme.activeTrackColorSwitch,
                  activeColor: ArchethicTheme.activeColorSwitch,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
