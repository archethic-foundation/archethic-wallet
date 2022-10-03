/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class PickerItem {
  PickerItem(
    this.label,
    this.description,
    this.icon,
    this.iconColor,
    this.value,
    this.enabled, {
    this.displayed = true,
    this.decorationImageItem,
    this.subLabel,
  });
  String label;
  String? description;
  String? icon;
  Color? iconColor;
  Object value;
  DecorationImage? decorationImageItem;
  bool enabled;
  bool displayed;
  String? subLabel;
}

// TODO(Chralu): specify [PickerItem.value] types (thanks to Generics)
class PickerWidget extends StatefulWidget {
  const PickerWidget({
    super.key,
    this.pickerItems,
    this.onSelected,
    this.selectedIndex = -1,
  });
  final ValueChanged<PickerItem>? onSelected;
  final List<PickerItem>? pickerItems;
  final int selectedIndex;

  @override
  State<PickerWidget> createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final pickerItem = widget.pickerItems![index];
          bool isItemSelected;
          if (selectedIndex != -1) {
            isItemSelected = index == selectedIndex;
          } else {
            isItemSelected = index == widget.selectedIndex;
          }
          if (widget.pickerItems![index].displayed) {
            return InkWell(
              onTap: () {
                if (widget.pickerItems![index].enabled) {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        StateContainer.of(context).activeVibrations,
                      );
                  selectedIndex = index;
                  widget.onSelected!(widget.pickerItems![index]);
                  setState(() {});
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  image: pickerItem.decorationImageItem,
                  border: Border.all(
                    color: isItemSelected
                        ? Colors.green
                        : StateContainer.of(context).curTheme.text30!,
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
                          pickerItem.icon == null
                              ? const SizedBox(
                                  width: 0,
                                  height: 24,
                                )
                              : SizedBox(
                                  height: 24,
                                  child: widget.pickerItems![index].iconColor ==
                                          null
                                      ? Image.asset(pickerItem.icon!)
                                      : Image.asset(
                                          pickerItem.icon!,
                                          color:
                                              widget.pickerItems![index].enabled
                                                  ? widget.pickerItems![index]
                                                      .iconColor
                                                  : StateContainer.of(context)
                                                      .curTheme
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
                                    style: widget.pickerItems![index].enabled
                                        ? AppStyles.textStyleSize14W600Primary(
                                            context,
                                          )
                                        : AppStyles
                                            .textStyleSize14W600PrimaryDisabled(
                                            context,
                                          ),
                                  ),
                                ),
                                widget.pickerItems![index].subLabel != null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.pickerItems![index].subLabel!,
                                          style: widget
                                                  .pickerItems![index].enabled
                                              ? AppStyles
                                                  .textStyleSize12W400Primary(
                                                  context,
                                                )
                                              : AppStyles
                                                  .textStyleSize12W400PrimaryDisabled(
                                                  context,
                                                ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          isItemSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                )
                              : Container(),
                        ],
                      ),
                      if (pickerItem.description != null)
                        const SizedBox(height: 5),
                      if (pickerItem.description != null)
                        Text(
                          pickerItem.description!,
                          style: AppStyles.textStyleSize12W100Primary(context),
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
