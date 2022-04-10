// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class PickerItem {
  String label;
  String description;
  String icon;
  Object value;
  bool enabled;

  PickerItem(this.label, this.description, this.icon, this.value, this.enabled);
}

class PickerWidget extends StatefulWidget {
  final ValueChanged<PickerItem>? onSelected;
  final List<PickerItem>? pickerItems;

  const PickerWidget({Key? key, this.pickerItems, this.onSelected})
      : super(key: key);

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemBuilder: (context, index) {
                      PickerItem pickerItem = widget.pickerItems![index];
                      bool isItemSelected = index == selectedIndex;
                      return InkWell(
                        onTap: () {
                          if (widget.pickerItems![index].enabled) {
                            sl.get<HapticUtil>().feedback(FeedbackType.light);
                            selectedIndex = index;
                            widget.onSelected!(widget.pickerItems![index]);
                            setState(() {});
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isItemSelected
                                    ? Colors.green
                                    : StateContainer.of(context)
                                        .curTheme
                                        .primary!),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 24,
                                      child: Image.asset(pickerItem.icon,
                                          color:
                                              widget.pickerItems![index].enabled
                                                  ? StateContainer.of(context)
                                                      .curTheme
                                                      .icon
                                                  : StateContainer.of(context)
                                                      .curTheme
                                                      .icon60),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(pickerItem.label,
                                          style: widget
                                                  .pickerItems![index].enabled
                                              ? AppStyles
                                                  .textStyleSize14W600Primary(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize14W600PrimaryDisabled(
                                                      context)),
                                    ),
                                    isItemSelected
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 16,
                                            color: Colors.green,
                                          )
                                        : Container(),
                                  ],
                                ),
                                Text(
                                  pickerItem.description,
                                  style: AppStyles.textStyleSize12W100Primary(
                                      context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.pickerItems!.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
