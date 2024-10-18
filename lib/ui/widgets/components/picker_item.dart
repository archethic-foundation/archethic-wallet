/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:ui';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class PickerItem<T> {
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
class PickerWidget<T> extends ConsumerStatefulWidget {
  PickerWidget({
    super.key,
    required this.pickerItems,
    this.onSelected,
    this.onUnselected,
    List<int>? selectedIndexes,
    this.multipleSelectionsAllowed = false,
    this.height,
    this.scrollable = false,
  }) {
    this.selectedIndexes = selectedIndexes ?? [];
  }

  final FutureOr<void> Function(PickerItem<T>)? onSelected;
  final FutureOr<void> Function(PickerItem<T>)? onUnselected;
  final List<PickerItem<T>> pickerItems;
  late final List<int> selectedIndexes;
  final bool multipleSelectionsAllowed;
  final double? height;
  final bool scrollable;

  @override
  ConsumerState<PickerWidget> createState() => _PickerWidgetState();
}

class _PickerWidgetState extends ConsumerState<PickerWidget> {
  late List<int> selectedIndexes;

  @override
  void initState() {
    super.initState();
    selectedIndexes = [...widget.selectedIndexes];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: widget.height,
      child: ListView.builder(
        shrinkWrap: true,
        physics:
            widget.scrollable ? null : const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final pickerItem = widget.pickerItems[index];
          final isItemSelected = selectedIndexes.contains(index);
          if (widget.pickerItems[index].displayed) {
            return InkWell(
              onTap: () async {
                if (widget.pickerItems[index].enabled) {
                  if (widget.multipleSelectionsAllowed == false) {
                    selectedIndexes.clear();
                  }
                  // If the user taps again on a previous selection, we will unselect it to him
                  if (selectedIndexes.contains(index)) {
                    selectedIndexes.remove(index);
                    widget.onUnselected?.call(widget.pickerItems[index]);
                  } else {
                    selectedIndexes.add(index);
                    widget.onSelected?.call(widget.pickerItems[index]);
                  }
                  setState(() {});
                }
              },
              key: pickerItem.key,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ArchethicTheme.sheetBackground,
                        border: Border.all(
                          color: isItemSelected
                              ? Colors.green
                              : ArchethicTheme.sheetBorder,
                        ),
                        borderRadius: BorderRadius.circular(10),
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
                                    child:
                                        widget.pickerItems[index].iconColor ==
                                                null
                                            ? Image.asset(pickerItem.icon!)
                                            : Image.asset(
                                                pickerItem.icon!,
                                                color: widget.pickerItems[index]
                                                        .enabled
                                                    ? widget.pickerItems[index]
                                                        .iconColor
                                                    : ArchethicTheme
                                                        .pickerItemIconDisabled,
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
                                          style: widget
                                                  .pickerItems[index].enabled
                                              ? ArchethicThemeStyles
                                                  .textStyleSize14W600Primary
                                              : ArchethicThemeStyles
                                                  .textStyleSize14W600PrimaryDisabled,
                                        ),
                                      ),
                                      if (widget.pickerItems[index].subLabel !=
                                          null)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.pickerItems[index].subLabel!,
                                            style: widget
                                                    .pickerItems[index].enabled
                                                ? ArchethicThemeStyles
                                                    .textStyleSize14W600Primary
                                                : ArchethicThemeStyles
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
                                    Symbols.check_circle,
                                    fill: 1,
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
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
        itemCount: widget.pickerItems.length,
      ),
    );
  }
}
