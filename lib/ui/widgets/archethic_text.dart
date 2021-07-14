// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/styles.dart';

class ArchEthicText {
  static Widget getLabel(BuildContext context) {
    return Container(
        child: SizedBox(
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Arch", style: AppStyles.textArch(context)),
                Text("Ethic", style: AppStyles.textEthic(context))
              ],
            )));
  }
}
