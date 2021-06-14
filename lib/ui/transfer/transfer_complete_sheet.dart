// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';

class TransferCompleteSheet extends StatefulWidget {
  const TransferCompleteSheet({this.title}) : super();

  final String? title;

  @override
  _TransferCompleteSheetState createState() => _TransferCompleteSheetState();
}

class _TransferCompleteSheetState extends State<TransferCompleteSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // Sheet handle
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.text10,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            //A main container that holds the amount, address and "SENT TO" texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: const AlignmentDirectional(0, 0),
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Icon(AppIcons.success,
                        size: 100,
                        color: StateContainer.of(context).curTheme.primary),
                  ),
                  Container(
                    alignment: const AlignmentDirectional(0, 0),
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Text(AppLocalization.of(context).transferSuccess,
                        style: AppStyles.textStyleParagraph(context)),
                  ),
                ],
              ),
            ),

            // CLOSE Button
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).close,
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
