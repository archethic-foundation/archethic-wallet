/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:convert/convert.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/ledger/archethic_ledger_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

/*final getArchAddress = transport(
    0xe0,
    0x04,
    0x00,
    0x00,
    Uint8List.fromList(hex.decode(
        '9C000000000401EC530D1BBDF3B1B3E18C6E2330E5CFD1BFD88EB6D84102184CB39EC271793578B469ACBD8EB4F684C41B5DA87712A203AAA910B7964218794E3D3F343835843C44AFFE281D750E6CA526C6FC265167FE37DB9E47828BF80964DAC837E1072CA9954FF1852FF71865B9043BC117BC001C47D76A326A2A2F7CF6B16AB49E9E57F9D5E6D8E1D00D7F1B7E2F986C711DCA060005B2C8F485')));
*/
/*final signTxn = transport(
    0xe0,
    0x08,
    0x00,
    0x00,
    Uint8List.fromList(hex.decode(
        'C600000000020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313000000038407B7000401EC530D1BBDF3B1B3E18C6E2330E5CFD1BFD88EB6D84102184CB39EC271793578B469ACBD8EB4F684C41B5DA87712A203AAA910B7964218794E3D3F343835843C44AFFE281D750E6CA526C6FC265167FE37DB9E47828BF80964DAC837E1072CA9954FF1852FF71865B9043BC117BC001C47D76A326A2A2F7CF6B16AB49E9E57F9D5E6D8E1D00D7F1B7E2F986C711DCA060005B2C8F485')));
*/

class LedgerSheet extends StatefulWidget {
  const LedgerSheet({super.key});

  @override
  State<LedgerSheet> createState() => _LedgerSheetState();
}

class _LedgerSheetState extends State<LedgerSheet> {
  FocusNode? enterPayloadFocusNode;
  TextEditingController? enterPayloadController;
  String response = '';
  String labelResponse = '';
  String info = '';
  String method = '';

  void update() {
    setState(() {
      labelResponse = sl.get<LedgerNanoSImpl>().getLabelFromCode();

      switch (method) {
        case 'getPubKey':
          response =
              'Public Key : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
          break;
        case 'getArchAddress':
          response =
              'Address : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
          break;
        case 'signTxn':
          /*String responseHex = hex.encode(event.apdu!);
            String rawTxn = responseHex.substring(0, responseHex.length - 4);
            int offset = 64;
            String curveType = rawTxn.substring(offset, offset + 2);
            offset += 2;
            String originType = rawTxn.substring(offset, offset + 2);
            offset += 2;
            String pubKey = rawTxn.substring(offset, rawTxn.length);*/
          response =
              'Transaction : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      sl<LedgerNanoSImpl>().addListener(update);
    }

    enterPayloadFocusNode = FocusNode();
    enterPayloadController = TextEditingController();
    enterPayloadController!.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    if (kIsWeb) {
      sl<LedgerNanoSImpl>().removeListener(update);
      sl.get<LedgerNanoSImpl>().disconnectLedger();
    }
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
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                              context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (kIsWeb || Platform.isMacOS || Platform.isWindows)
                Stack(
                  children: <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 40,
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Payload',
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          AppTextField(
                            maxLines: 4,
                            padding: const EdgeInsetsDirectional.only(
                                start: 16, end: 16),
                            focusNode: enterPayloadFocusNode,
                            controller: enterPayloadController,
                            textInputAction: TextInputAction.go,
                            autofocus: true,
                            onSubmitted: (_) async {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (String value) async {
                              setState(() {});
                            },
                            inputFormatters: <LengthLimitingTextInputFormatter>[
                              LengthLimitingTextInputFormatter(500),
                            ],
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Response',
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: SelectableText(
                              response,
                              style:
                                  AppStyles.textStyleSize16W200Primary(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SelectableText(
                            'Info',
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            info,
                            style:
                                AppStyles.textStyleSize16W200Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          SelectableText(
                            labelResponse,
                            style:
                                AppStyles.textStyleSize16W200Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))),
          ),
          kIsWeb || Platform.isMacOS
              ? Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            const Key('getPubKey'),
                            context,
                            AppButtonType.primary,
                            'Get pubKey',
                            Dimens.buttonTopDimens, onPressed: () async {
                          setState(() {
                            method = 'getPubKey';
                            info = '';
                          });
                          await sl
                              .get<LedgerNanoSImpl>()
                              .connectLedger(getPubKeyAPDU());
                        }),
                        AppButton.buildAppButton(
                            const Key('getArchAddress'),
                            context,
                            AppButtonType.primary,
                            'Get Arch Address',
                            Dimens.buttonTopDimens, onPressed: () async {
                          setState(() {
                            method = 'getArchAddress';
                            info = '';
                            labelResponse = '';
                          });
                          if (enterPayloadController!.text.trim() == '' ||
                              isHex(enterPayloadController!.text) == false) {
                            info = 'The payload is not valid.';
                          } else {
                            Uint8List getArchAddress = transport(
                                0xe0,
                                0x04,
                                0x00,
                                0x00,
                                Uint8List.fromList(
                                    hex.decode(enterPayloadController!.text)));
                            print(
                                'getArchAddress: ${uint8ListToHex(getArchAddress)}');
                            await sl
                                .get<LedgerNanoSImpl>()
                                .connectLedger(getArchAddress);
                          }
                        }),
                        AppButton.buildAppButton(
                            const Key('signTransaction'),
                            context,
                            AppButtonType.primary,
                            'Sign Transaction',
                            Dimens.buttonTopDimens, onPressed: () async {
                          setState(() {
                            method = 'signTxn';
                            info = '';
                            labelResponse = '';
                          });
                          if (enterPayloadController!.text.trim() == '' ||
                              isHex(enterPayloadController!.text) == false) {
                            info = 'The payload is not valid.';
                          } else {
                            Uint8List signTxn = transport(
                                0xe0,
                                0x08,
                                0x00,
                                0x00,
                                Uint8List.fromList(
                                    hex.decode(enterPayloadController!.text)));
                            await sl
                                .get<LedgerNanoSImpl>()
                                .connectLedger(signTxn);
                          }
                        }),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void addLog(String log) {
    setState(() {
      info = '$info\n$log';
    });
  }
}
