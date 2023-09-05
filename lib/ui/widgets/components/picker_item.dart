/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class PickerItem<T extends Object> {
  PickerItem(
    this.label,
    this.description,
    this.icon,
    this.iconColor,
    this.value,
    this.enabled, {
    this.key,
    this.displayed = true,
    this.decorationImageItem,
    this.subLabel,
  });
  Key? key;
  String label;
  String? description;
  String? icon;
  Color? iconColor;
  T value;
  DecorationImage? decorationImageItem;
  bool enabled;
  bool displayed;
  String? subLabel;
}

// TODO(reddwarf03): specify [PickerItem.value] types (thanks to Generics) (3)
class PickerWidget<T extends Object> extends ConsumerStatefulWidget {
  PickerWidget({
    super.key,
    this.pickerItems,
    this.onSelected,
    this.onUnselected,
    this.selectedIndexes,
    this.multipleSelectionsAllowed = false,
  }) {
    // the list cannot have a const value because we will always need (even for mono selection cases) to add/remove elements within it
    if (this.selectedIndexes == null) {
      this.selectedIndexes = [];
    }
  }
  final ValueChanged<PickerItem<T>>? onSelected;
  final ValueChanged<PickerItem<T>>? onUnselected;
  final List<PickerItem<T>>? pickerItems;
  late List<int>? selectedIndexes;
  final bool multipleSelectionsAllowed;

  @override
  ConsumerState<PickerWidget> createState() => _PickerWidgetState();
}

class _PickerWidgetState extends ConsumerState<PickerWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final pickerItem = widget.pickerItems![index];
          final isItemSelected = widget.selectedIndexes!.contains(index);
          if (widget.pickerItems![index].displayed) {
            return InkWell(
              onTap: () {
                if (widget.pickerItems![index].enabled) {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  if (widget.multipleSelectionsAllowed == false) {
                    widget.selectedIndexes!.clear();
                  }
                  // If the user taps again on a previous selection, we will unselect it to him
                  if (widget.selectedIndexes!.contains(index)) {
                    widget.selectedIndexes!.remove(index);
                    widget.onUnselected?.call(widget.pickerItems![index]);
                  } else {
                    widget.selectedIndexes!.add(index);
                    widget.onSelected?.call(widget.pickerItems![index]);
                  }
                  setState(() {});
                }
              },
              key: pickerItem.key,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  image: pickerItem.decorationImageItem,
                  border: Border.all(
                    color: isItemSelected ? Colors.green : theme.text30!,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (pickerItem.icon == null)
                            const SizedBox(
                              width: 0,
                              height: 24,
                            )
                          else
                            SizedBox(
                              height: 24,
                              child: widget.pickerItems![index].iconColor ==
                                      null
                                  ? Image.asset(pickerItem.icon!)
                                  : Image.asset(
                                      pickerItem.icon!,
                                      color: widget.pickerItems![index].enabled
                                          ? widget.pickerItems![index].iconColor
                                          : theme.pickerItemIconDisabled,
                                    ),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    pickerItem.label,
                                    style: widget.pickerItems![index].enabled
                                        ? theme.textStyleSize14W600Primary
                                        : theme
                                            .textStyleSize14W600PrimaryDisabled,
                                  ),
                                ),
                                if (widget.pickerItems![index].subLabel != null)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.pickerItems![index].subLabel!,
                                      style: widget.pickerItems![index].enabled
                                          ? theme.textStyleSize14W600Primary
                                          : theme
                                              .textStyleSize14W600PrimaryDisabled,
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            ),
                          ),
                          if (isItemSelected)
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green,
                            )
                          else
                            Container(),
                        ],
                      ),
                      if (pickerItem.description != null)
                        const SizedBox(height: 5),
                      if (pickerItem.description != null)
                        Text(
                          pickerItem.description!,
                          style: theme.textStyleSize12W100Primary,
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
        itemCount: widget.pickerItems!.length,
      ),
    );
  }
}
