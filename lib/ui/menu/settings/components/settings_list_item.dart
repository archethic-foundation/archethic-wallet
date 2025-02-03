/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../settings_sheet.dart';

abstract class _SettingsListItem extends ConsumerWidget {
  const _SettingsListItem();

  const factory _SettingsListItem.spacer() = _SettingsListSpacer;
  const factory _SettingsListItem.title({
    required String text,
  }) = _SettingsListTitle;

  /// Settings item without any dropdown option but rather a direct functionality
  const factory _SettingsListItem.singleLine({
    required String heading,
    required TextStyle headingStyle,
    required IconData icon,
    bool? displayChevron,
    VoidCallback? onPressed,
  }) = _SettingsListItemSingleLine;

  /// Settings item with a dropdown option
  const factory _SettingsListItem.withDefaultValue({
    required String heading,
    required SettingSelectionItem defaultValue,
    required IconData icon,
    required Function onPressed,
  }) = _SettingsListItemWithDefaultValue;

  const factory _SettingsListItem.singleLineWithInfos({
    required String heading,
    required String info,
    TextStyle? headingStyle,
    Function? onPressed,
    IconData? icon,
    bool? displayChevron,
    String? background,
  }) = _SettingsListItemSingleLineWithInfos;

  const factory _SettingsListItem.withSwitch({
    required String heading,
    required IconData icon,
    required bool isSwitched,
    String info,
    Function? onChanged,
    String? background,
  }) = _SettingsListItemSwitch;
}

class _SettingsListSpacer extends _SettingsListItem {
  const _SettingsListSpacer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Divider(
      height: 2,
      color: ArchethicTheme.text15,
    );
  }
}

class _SettingsListTitle extends _SettingsListItem {
  const _SettingsListTitle({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ArchethicTheme.text05,
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.only(
          top: 15,
          bottom: 15,
        ),
        child: Text(
          text,
          style: ArchethicThemeStyles.textStyleSize20W700Primary,
        ),
      ),
    );
  }
}
