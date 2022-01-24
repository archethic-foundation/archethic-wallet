// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';

Widget buildIconWidget(
    BuildContext context, String icon, double width, double height,
    {Color? color}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: StateContainer.of(context).curTheme.iconDrawerBackgroundColor!,
        ),
      ],
    ),
    alignment: const AlignmentDirectional(0, 0),
    child: SizedBox(
      child: Image.asset(icon, color: color ?? Colors.white),
    ),
  );
}

Widget buildIconDataWidget(
    BuildContext context, IconData icon, double width, double height,
    {bool enabled = true}) {
  return enabled
      ? Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: StateContainer.of(context).curTheme.primary10!,
              ),
            ],
          ),
          alignment: const AlignmentDirectional(0, 0),
          child: ShaderMask(
            child: SizedBox(
              child: Icon(
                icon,
                color: Colors.white,
                size: width,
              ),
            ),
            shaderCallback: (Rect bounds) {
              final Rect rect = Rect.fromLTRB(0, 0, width, width);
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
          alignment: const AlignmentDirectional(0, 0),
          child: SizedBox(
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.3),
              size: width,
            ),
          ),
        );
}
