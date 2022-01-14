// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/widgets/components/app_text_field.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';

class LedgerSheet extends StatefulWidget {
  const LedgerSheet() : super();

  @override
  _LedgerSheetState createState() => _LedgerSheetState();
}

class _LedgerSheetState extends State<LedgerSheet> {
  FocusNode? enterAPDUFocusNode;
  TextEditingController? enterAPDUController;

  @override
  void initState() {
    super.initState();

    enterAPDUFocusNode = FocusNode();
    enterAPDUController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          // A row for the address text and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Empty SizedBox
              const SizedBox(
                width: 60,
                height: 0,
              ),
              Column(
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
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140),
                    child: Column(
                      children: <Widget>[
                        // Header
                        AutoSizeText(
                          'Ledger - Tests',
                          style: AppStyles.textStyleSize24W700Primary(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (kIsWeb || Platform.isMacOS)
                Stack(
                  children: <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 40,
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10, right: 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: <Widget>[
                                buildIconDataWidget(
                                    context, Icons.close_outlined, 30, 30),
                              ],
                            ))),
                  ],
                )
              else
                const SizedBox(
                  width: 60,
                  height: 40,
                ),
            ],
          ),

          Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 60, bottom: 10),
                child: SafeArea(
                  minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'APDU',
                        style: AppStyles.textStyleSize16W600Primary(context),
                        textAlign: TextAlign.center,
                      ),
                      AppTextField(
                        maxLines: 1,
                        padding: const EdgeInsetsDirectional.only(
                            start: 16, end: 16),
                        focusNode: enterAPDUFocusNode,
                        controller: enterAPDUController,
                        textInputAction: TextInputAction.go,
                        autofocus: true,
                        onSubmitted: (_) async {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (String value) async {},
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(45),
                        ],
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize16W600Primary(context),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Response',
                        style: AppStyles.textStyleSize16W600Primary(context),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'XXXXXXXXXXXXXXXXXXXXXX',
                        style: AppStyles.textStyleSize16W200Primary(context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context)!.send,
                        Dimens.BUTTON_TOP_DIMENS,
                        onPressed: () async {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
