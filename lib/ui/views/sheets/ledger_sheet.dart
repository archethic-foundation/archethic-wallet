// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'dart:html' show EventListener;
import 'dart:js' show allowInterop;
import 'dart:js_util' show getProperty;

// Flutter imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet/bus/events.dart';
import 'package:convert/convert.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/widgets/components/app_text_field.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';

import 'package:web_hid/web_hid.dart';

final ledgerDeviceIds = RequestOptionsFilter(
  vendorId: 0x2c97,
);

Uint8List transport(
  int cla,
  int ins,
  int p1,
  int p2, [
  Uint8List? payload,
]) {
  payload ??= Uint8List.fromList([]);
  return Uint8List.fromList([cla, ins, p1, p2, ...payload]);
}

final getAppAndVersion = transport(0xb0, 0x01, 0x00, 0x00);
final getAppVersion = transport(0xe0, 0x01, 0x00, 0x00);
final getPubKey =
    transport(0xe0, 0x02, 0x00, 0x00, Uint8List.fromList(hex.decode('00')));
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
List<int> data = List.empty(growable: true);
int lastBlockSeqId = -1;
int dataLength = -1;

class LedgerSheet extends StatefulWidget {
  const LedgerSheet({Key? key}) : super(key: key);

  @override
  _LedgerSheetState createState() => _LedgerSheetState();
}

class _LedgerSheetState extends State<LedgerSheet> {
  StreamSubscription<APDUReceiveEvent>? _apduReceiveSub;

  FocusNode? enterPayloadFocusNode;
  TextEditingController? enterPayloadController;
  HidDevice? _device;
  String response = '';
  String labelResponse = '';
  String info = '';
  String method = '';

  final EventListener _handleConnect = allowInterop((event) {});
  final EventListener _handleDisconnect = allowInterop((event) {});

  final EventListener _handleInputReport = allowInterop((event) {
    ByteData blockData = getProperty(event, 'data');
    var _data = parseBlock(blockData);
    //print('_data' + _data.toString());
    //print('_data (length) = ' + _data.length.toString());

    if (_data.length >= dataLength) {
      EventTaxiImpl.singleton()
          .fire(APDUReceiveEvent(apdu: Uint8List.fromList(_data)));
      data = List.empty(growable: true);
      lastBlockSeqId = -1;
      dataLength = -1;
    }
  });

  void _registerBus() {
    _apduReceiveSub = EventTaxiImpl.singleton()
        .registerTo<APDUReceiveEvent>()
        .listen((APDUReceiveEvent event) {
      setState(() {
        switch (method) {
          case 'getAppAndVersion':
            var readBuffer = ReadBuffer(event.apdu!.buffer.asByteData());
            if (readBuffer.getUint8() != 1) {
              throw ArgumentError('format');
            }
            var nameLength = readBuffer.getUint8();
            var appName =
                String.fromCharCodes(readBuffer.getUint8List(nameLength));
            var versionLength = readBuffer.getUint8();
            var version =
                String.fromCharCodes(readBuffer.getUint8List(versionLength));

            response = appName + ' ' + version;
            break;
          case 'getPubKey':
            response = 'Public Key : ' + hex.encode(event.apdu!).toUpperCase();
            break;
          case 'getArchAddress':
            response = 'Address : ' + hex.encode(event.apdu!).toUpperCase();
            break;
          case 'signTxn':
            response = 'Transaction : ' + hex.encode(event.apdu!).toUpperCase();
            break;
          default:
        }
        getLabel();
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBus();

    enterPayloadFocusNode = FocusNode();
    enterPayloadController = TextEditingController();
    enterPayloadController!.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    if (_apduReceiveSub != null) {
      _apduReceiveSub!.cancel();
    }
    if (_device != null) {
      _device?.close().then((value) {}).catchError((error) {});
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
              if (kIsWeb || Platform.isMacOS || Platform.isWindows)
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
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /*AppButton.buildAppButton(
                      context,
                      AppButtonType.primary,
                      'Get app and version',
                      Dimens.buttonTopDimens, onPressed: () async {
                    setState(() {
                      method = 'getAppAndVersion';
                      info = '';
                    });

                    await sendAPDU(getAppAndVersion);
                  }),*/
                ],
              ),
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      AppButtonType.primary,
                      'Get pubKey',
                      Dimens.buttonTopDimens, onPressed: () async {
                    setState(() {
                      method = 'getPubKey';
                      info = '';
                    });

                    await sendAPDU(getPubKey);
                  }),
                  AppButton.buildAppButton(
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
                      await sendAPDU(getArchAddress);
                    }
                  }),
                  AppButton.buildAppButton(
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
                      await sendAPDU(signTxn);
                    }
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addLog(String log) {
    setState(() {
      info = info + '\n' + log;
    });
  }

  void getLabel() {
    if (response.length >= 4) {
      switch (response.substring(response.length - 4)) {
        case '6d00':
          labelResponse = 'Invalid parameter received';
          break;
        case '670A':
          labelResponse = 'Lc is 0x00 whereas an application name is required';
          break;
        case '6807':
          labelResponse = 'The requested application is not present';
          break;
        case '6985':
          labelResponse = 'Cancel the operation';
          break;
        case '9000':
          labelResponse = 'Success of the operation';
          break;
        case '0000':
          labelResponse = 'Success of the operation';
          break;
        default:
          labelResponse = response.substring(response.length - 4);
      }
      response = response.substring(0, response.length - 4);
      info = '';
    }
  }

  Future<void> sendAPDU(Uint8List apdu) async {
    labelResponse = '';
    response = '';
    info = '';
    setState(() {});

    if (_device != null) {
      //addLog('Device opened before started ? ' + _device!.opened.toString());
      if (_device!.opened) {
        if (_device != null) {
          _device?.close().then((value) {}).catchError((error) {});
        }
      }
    }

    hid.subscribeConnect(_handleConnect);

    List<HidDevice> requestDevice = await hid.requestDevice(RequestOptions(
      filters: [ledgerDeviceIds],
    ));
    _device = requestDevice[0];

    await _device?.open();
    if (_device != null && _device!.opened) {
      addLog('Please, approve the transaction on your ledger...');
      _device?.subscribeInputReport(_handleInputReport);

      List<int> _apduPart;
      int remainingLength = apdu.length;
      int blockSeqId = 0;

      //print('apdu: ' + apdu.toString());
      while (remainingLength > 0) {
        _apduPart = List<int>.filled(64, 0, growable: false);
        //print('remainingLength: ' + remainingLength.toString());

        while (remainingLength > 0) {
          if (blockSeqId == 0) {
            if (apdu.length > 57) {
              _apduPart = apdu.sublist(0, 57);
            } else {
              _apduPart = concatUint8List(<Uint8List>[
                apdu.sublist(0, apdu.length),
                Uint8List.fromList(List.filled(59 - remainingLength - 2, 0))
              ]);
            }
          } else {
            if (remainingLength > 59) {
              _apduPart = apdu.sublist(
                  57 + (59 * (blockSeqId - 1)), 57 + (59 * blockSeqId));
            } else {
              _apduPart = concatUint8List(<Uint8List>[
                apdu.sublist(57 + (59 * (blockSeqId - 1)),
                    57 + (59 * (blockSeqId - 1)) + remainingLength),
                Uint8List.fromList(List.filled(59 - remainingLength, 0))
              ]);
            }
          }

          //print('apduPart: ' + _apduPart.toString());
          //print('apduPartHex: ' + hex.encode(_apduPart));
          //print('apduPartLength: ' + _apduPart.length.toString());
          Uint8List blockBytes =
              makeBlock(Uint8List.fromList(_apduPart), blockSeqId, apdu.length);
          //print('blockBytes: ' + blockBytes.toString());
          //print('blockBytes length: ' + blockBytes.length.toString());
          await _device?.sendReport(0, blockBytes);
          blockSeqId++;

          remainingLength = remainingLength - _apduPart.length;
        }
      }
      setState(() {});
      hid.subscribeDisconnect(_handleDisconnect);
    }
  }
}

const packetSize = 64;
final channel = Random().nextInt(0xffff);
const Tag = 0x05;

///
/// +---------+--------+------------+-----------+
/// | channel |  Tag   | blockSeqId | blockData |
/// +---------+--------+------------+-----------+
/// | 2 bytes | 1 byte | 2 bytes    |       ... |
/// +---------+--------+------------+-----------+
Uint8List makeBlock(Uint8List apdu, int blockSeqId, int totalLengthApdu) {
  var apduBuffer = WriteBuffer();
  if (blockSeqId == 0) {
    apduBuffer.putUint16(totalLengthApdu, endian: Endian.big);
  }
  apduBuffer.putUint8List(apdu);
  var apduData = apduBuffer.done();

  var writeBuffer = WriteBuffer();
  writeBuffer.putUint16(channel, endian: Endian.big);
  writeBuffer.putUint8(Tag);
  writeBuffer.putUint16(blockSeqId, endian: Endian.big);
  writeBuffer.putUint8List(apduData.buffer.asUint8List());
  return writeBuffer.done().buffer.asUint8List();
}

Uint8List parseBlock(ByteData block) {
  //print('parse: ' + block.buffer.asUint8List().toString());
  //print('parse (length): ' + block.buffer.asUint8List().length.toString());
  var readBuffer = ReadBuffer(block);

  int channelParse = readBuffer.getUint16(endian: Endian.big);
  if (channelParse != channel) {
    //print(channelParse.toString() + ' / ' + channel.toString());
    //throw ArgumentError('channel');
  }
  int tagParse = readBuffer.getUint8();
  if (tagParse != Tag) {
    //print(tagParse.toString() + ' / ' + Tag.toString());
    //throw ArgumentError('Tag');
  }
  int blockSeqIdParse = readBuffer.getUint16(endian: Endian.big);
  if (lastBlockSeqId + 1 != blockSeqIdParse) {
    //print(blockSeqIdParse.toString() + ' / ' + (lastBlockSeqId + 1).toString());
    //throw ArgumentError('blockSeqId');
  }
  lastBlockSeqId = blockSeqIdParse;

  if (lastBlockSeqId == 0) {
    dataLength = readBuffer.getUint16(endian: Endian.big);
    //print('datalength = ' + dataLength.toString());
  }

  if (lastBlockSeqId == 0) {
    if (dataLength >= 57) {
      data.addAll(readBuffer.getUint8List(57));
    } else {
      data.addAll(readBuffer.getUint8List(dataLength));
    }
  } else {
    if (dataLength > (57 + (lastBlockSeqId) * 59)) {
      data.addAll(readBuffer.getUint8List(59));
    } else {
      data.addAll(readBuffer
          .getUint8List(dataLength - (57 + (lastBlockSeqId - 1) * 59)));
    }
  }
  return Uint8List.fromList(data);
}
