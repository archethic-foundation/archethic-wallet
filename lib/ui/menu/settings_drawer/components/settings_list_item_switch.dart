part of '../settings_drawer_wallet_mobile.dart';

class _SettingsListItemSwitch extends _SettingsListItem {
  const _SettingsListItemSwitch({
    required this.heading,
    required this.icon,
    required this.iconColor,
    required this.isSwitched,
    this.onChanged,
    super.key,
  });

  final String heading;
  final String icon;
  final Color iconColor;
  final bool isSwitched;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
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
                if (onChanged == null) return;
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
                    );
                onChanged?.call(value);
              },
              inactiveTrackColor: StateContainer.of(context).curTheme.inactiveTrackColorSwitch,
              activeTrackColor: StateContainer.of(context).curTheme.activeTrackColorSwitch,
              activeColor: StateContainer.of(context).curTheme.backgroundDark,
            )
          ],
        ),
      ),
    );
  }
}
