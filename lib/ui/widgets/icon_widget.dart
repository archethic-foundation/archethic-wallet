import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:flutter/material.dart';

Widget buildIconWidget(BuildContext context, String icon) {
  return Container(
    width: 90,
    height: 90,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: StateContainer.of(context).curTheme.background40!,
        ),
      ],
    ),
    alignment: const AlignmentDirectional(0, 0),
    child: Container(
      child: SizedBox(
        child: Image.asset(icon, color: Colors.white),
      ),
    ),
  );
}
