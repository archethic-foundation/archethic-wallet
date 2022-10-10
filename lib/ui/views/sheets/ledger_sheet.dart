/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';
import 'dart:io';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/ledger/archethic_ledger_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:convert/convert.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class LedgerSheet extends ConsumerStatefulWidget {
  const LedgerSheet({super.key});

  @override
  ConsumerState<LedgerSheet> createState() => _LedgerSheetState();
}

class _LedgerSheetState extends ConsumerState<LedgerSheet> {
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
          response = 'Public Key : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
          break;
        case 'getArchAddress':
          response = 'Address : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
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
          response = 'Transaction : ${hex.encode(sl.get<LedgerNanoSImpl>().response).toUpperCase()}';
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
    final theme = ref.watch(ThemeProviders.theme);
    return SafeArea(
      minimum: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          const SheetHeader(title: 'Ledger - Tests'),
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
                        style: theme.textStyleSize16W600Primary,
                        textAlign: TextAlign.center,
                      ),
                      AppTextField(
                        maxLines: 4,
                        padding: const EdgeInsetsDirectional.only(
                          start: 16,
                          end: 16,
                        ),
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
                        style: theme.textStyleSize16W600Primary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Response',
                        style: theme.textStyleSize16W600Primary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: SelectableText(
                          response,
                          style: theme.textStyleSize16W200Primary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SelectableText(
                        'Info',
                        style: theme.textStyleSize16W600Primary,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        info,
                        style: theme.textStyleSize16W200Primary,
                        textAlign: TextAlign.center,
                      ),
                      SelectableText(
                        labelResponse,
                        style: theme.textStyleSize16W200Primary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (kIsWeb || Platform.isMacOS)
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                      const Key('getPubKey'),
                      context,
                      ref,
                      AppButtonType.primary,
                      'Get pubKey',
                      Dimens.buttonTopDimens,
                      onPressed: () async {
                        setState(() {
                          method = 'getPubKey';
                          info = '';
                        });
                        await sl.get<LedgerNanoSImpl>().connectLedger(getPubKeyAPDU());
                      },
                    ),
                    AppButton.buildAppButton(
                      const Key('getArchAddress'),
                      context,
                      ref,
                      AppButtonType.primary,
                      'Get Arch Address',
                      Dimens.buttonTopDimens,
                      onPressed: () async {
                        setState(() {
                          method = 'getArchAddress';
                          info = '';
                          labelResponse = '';
                        });
                        if (enterPayloadController!.text.trim() == '' || isHex(enterPayloadController!.text) == false) {
                          info = 'The payload is not valid.';
                        } else {
                          final getArchAddress = transport(
                            0xe0,
                            0x04,
                            0x00,
                            0x00,
                            Uint8List.fromList(
                              hex.decode(enterPayloadController!.text),
                            ),
                          );
                          log('getArchAddress: ${uint8ListToHex(getArchAddress)}');
                          await sl.get<LedgerNanoSImpl>().connectLedger(getArchAddress);
                        }
                      },
                    ),
                    AppButton.buildAppButton(
                      const Key('signTransaction'),
                      context,
                      ref,
                      AppButtonType.primary,
                      'Sign Transaction',
                      Dimens.buttonTopDimens,
                      onPressed: () async {
                        setState(() {
                          method = 'signTxn';
                          info = '';
                          labelResponse = '';
                        });
                        if (enterPayloadController!.text.trim() == '' || isHex(enterPayloadController!.text) == false) {
                          info = 'The payload is not valid.';
                        } else {
                          final signTxn = transport(
                            0xe0,
                            0x08,
                            0x00,
                            0x00,
                            Uint8List.fromList(
                              hex.decode(enterPayloadController!.text),
                            ),
                          );
                          await sl.get<LedgerNanoSImpl>().connectLedger(signTxn);
                        }
                      },
                    ),
                  ],
                ),
              ],
            )
          else
            const SizedBox(),
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
