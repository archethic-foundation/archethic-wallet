/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_sheet.dart';

class _SettingsListItemSwitch extends _SettingsListItem {
  const _SettingsListItemSwitch({
    required this.heading,
    required this.icon,
    required this.isSwitched,
    this.info,
    this.onChanged,
    this.background,
  });

  final String heading;
  final String? info;
  final IconData icon;
  final bool isSwitched;
  final Function? onChanged;
  final String? background;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (background != null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              background!,
            ),
            fit: BoxFit.fitWidth,
            alignment: Alignment.centerRight,
            opacity: 0.5,
          ),
        ),
        child: _detail(context, ref),
      );
    } else {
      return _detail(context, ref);
    }
  }

  Widget _detail(BuildContext context, WidgetRef ref) {
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
        height: info == null ? 50 : 100,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    heading,
                    style: ArchethicThemeStyles.textStyleSize16W600Primary,
                  ),
                  if (info != null)
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: AutoSizeText(
                        info!,
                        maxLines: 5,
                        stepGranularity: 0.1,
                        minFontSize: 8,
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                    ),
                ],
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
