/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_sheet.dart';

class _SettingsListItemWithDefaultValue extends _SettingsListItem {
  const _SettingsListItemWithDefaultValue({
    required this.heading,
    required this.defaultValue,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  });

  final String heading;
  final SettingSelectionItem defaultValue;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      ignoring: disabled,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(),
          ),
        ),
        // ignore: unnecessary_lambdas
        onPressed: () {
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
                      style: disabled
                          ? ArchethicThemeStyles.textStyleSize16W600Primary30
                          : ArchethicThemeStyles.textStyleSize16W600Primary,
                    ),
                    AutoSizeText(
                      defaultValue.getDisplayName(context),
                      style: disabled
                          ? ArchethicThemeStyles.textStyleSize12W100Primary30
                          : ArchethicThemeStyles.textStyleSize12W100Primary,
                      maxLines: 1,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                    ),
                  ],
                ),
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
    required this.defaultValue,
    required this.icon,
    required this.onPressed,
    required this.disabled,
  });

  final String heading;
  final String info;
  final SettingSelectionItem defaultValue;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      // ignore: unnecessary_lambdas
      onPressed: () {
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
                width: AppFontSizes.size28,
                height: AppFontSizes.size28,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        heading,
                        style: ArchethicThemeStyles.textStyleSize16W600Primary,
                      ),
                      Text(
                        defaultValue.getDisplayName(context),
                        style: disabled
                            ? ArchethicThemeStyles.textStyleSize12W100Primary30
                            : ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: AutoSizeText(
                      info,
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
          ],
        ),
      ),
    );
  }
}
