/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:flutter/material.dart';

class IconWidget {
  // TODO(Chralu): convert to [Widget] subclass
  static Widget build(
    BuildContext context,
    String icon,
    double width,
    double height, {
    Color? color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: StateContainer.of(context).curTheme.iconDrawerBackground!,
          ),
        ],
      ),
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        child: Image.asset(
          icon,
          color: color ?? StateContainer.of(context).curTheme.iconDrawer,
        ),
      ),
    );
  }

  // TODO(Chralu): convert to [Widget] subclass
  static Widget buildIconDataWidget(
    BuildContext context,
    IconData icon,
    double width,
    double height, {
    bool enabled = true,
  }) {
    return enabled
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: StateContainer.of(context)
                      .curTheme
                      .iconDataWidgetIconBackground!,
                ),
              ],
            ),
            alignment: AlignmentDirectional.center,
            child: ShaderMask(
              child: SizedBox(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: width,
                ),
              ),
              shaderCallback: (Rect bounds) {
                final rect = Rect.fromLTRB(0, 0, width, width);
                return StateContainer.of(context)
                    .curTheme
                    .gradient!
                    .createShader(rect);
              },
            ),
          )
        : Container(
            width: width,
            height: height,
            alignment: AlignmentDirectional.center,
            child: SizedBox(
              child: Icon(
                icon,
                color:
                    StateContainer.of(context).curTheme.text!.withOpacity(0.3),
                size: width,
              ),
            ),
          );
  }
}
