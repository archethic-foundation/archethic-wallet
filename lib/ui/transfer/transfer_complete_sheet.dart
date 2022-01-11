// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/widgets/buttons.dart';

// Package imports:

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
                color: StateContainer.of(context).curTheme.primary60,
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
                    child: FaIcon(FontAwesomeIcons.link,
                        size: 100,
                        color: StateContainer.of(context).curTheme.primary),
                  ),
                  Container(
                    alignment: const AlignmentDirectional(0, 0),
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Text(AppLocalization.of(context)!.transferSuccess,
                        style: AppStyles.textStyleSize16W200Primary(context)),
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
                          AppLocalization.of(context)!.close,
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
