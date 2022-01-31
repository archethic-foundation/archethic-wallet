// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'dart:html' show EventListener;
import 'dart:js' show allowInterop;
import 'dart:js_util' show getProperty;

// Flutter imports:
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
import 'package:archethic_wallet/localization.dart';
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
  Uint8List? data,
]) {
  data ??= Uint8List.fromList([]);
  return Uint8List.fromList([cla, ins, p1, p2, data.length, ...data]);
}

String parseResponse(Uint8List data) {
  return hex.encode(data);
}

class LedgerSheet extends StatefulWidget {
  const LedgerSheet({Key? key}) : super(key: key);

  @override
  _LedgerSheetState createState() => _LedgerSheetState();
}

class _LedgerSheetState extends State<LedgerSheet> {
  StreamSubscription<APDUReceiveEvent>? _apduReceiveSub;

  FocusNode? enterAPDUFocusNode;
  TextEditingController? enterAPDUController;
  HidDevice? _device;
  var response = '';
  var labelResponse = '';
  var info = '';

  final EventListener _handleInputReport = allowInterop((event) {
    print("debut de _handleInputReport");
    ByteData blockData = getProperty(event, 'data');
    print("recup de blockdata" + blockData.elementSizeInBytes.toString());
    var data = parseBlock(blockData);

    EventTaxiImpl.singleton().fire(APDUReceiveEvent(apdu: parseResponse(data)));
  });

  void _registerBus() {
    _apduReceiveSub = EventTaxiImpl.singleton()
        .registerTo<APDUReceiveEvent>()
        .listen((APDUReceiveEvent event) {
      setState(() {
        response = event.apdu!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    enterAPDUFocusNode = FocusNode();
    enterAPDUController = TextEditingController();
    enterAPDUController!.text = 'e0c4000000';
  }

  @override
  void dispose() {
    super.dispose();
    if (_apduReceiveSub != null) {
      _apduReceiveSub!.cancel();
    }
    if (_device != null) {
      _device?.close().then((value) {
        print('device.close success');
      }).catchError((error) {
        print('device.close $error');
      });
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
                            'APDU',
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.center,
                          ),
                          AppTextField(
                            maxLines: 2,
                            padding: const EdgeInsetsDirectional.only(
                                start: 16, end: 16),
                            focusNode: enterAPDUFocusNode,
                            controller: enterAPDUController,
                            textInputAction: TextInputAction.go,
                            autofocus: true,
                            onSubmitted: (_) async {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (String value) async {
                              setState(() {});
                            },
                            inputFormatters: <LengthLimitingTextInputFormatter>[
                              LengthLimitingTextInputFormatter(300),
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
                          SelectableText(
                            response,
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
                        ],
                      ),
                    ))),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  enterAPDUController!.text.isEmpty
                      ? AppButton.buildAppButton(
                          context,
                          AppButtonType.textOutline,
                          AppLocalization.of(context)!.send,
                          Dimens.buttonTopDimens,
                          onPressed: () async {})
                      : AppButton.buildAppButton(
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.send,
                          Dimens.buttonTopDimens, onPressed: () async {
                          setState(() {
                            info = '';
                          });

                          if (_device != null) {
                            addLog('Device opened before started ? ' +
                                _device!.opened.toString());
                            if (_device!.opened) {
                              if (_device != null) {
                                _device?.close().then((value) {
                                  print('device.close success');
                                }).catchError((error) {
                                  print('device.close $error');
                                });
                              }
                            }
                          }

                          List<HidDevice> requestDevice =
                              await hid.requestDevice(RequestOptions(
                            filters: [ledgerDeviceIds],
                          ));
                          print('requestDevice $requestDevice');
                          _device = requestDevice[0];

                          _device?.open().then((value) {
                            addLog('Device session has started');
                            addLog('Device opened after started ? ' +
                                _device!.opened.toString());
                            int? cla = int.tryParse(
                                enterAPDUController!.text.substring(0, 2),
                                radix: 16);
                            int? ins = int.tryParse(
                                enterAPDUController!.text.substring(2, 4),
                                radix: 16);
                            int? p1 = int.tryParse(
                                enterAPDUController!.text.substring(4, 6),
                                radix: 16);
                            int? p2 = int.tryParse(
                                enterAPDUController!.text.substring(6, 8),
                                radix: 16);
                            final apdu = transport(
                                cla!,
                                ins!,
                                p1!,
                                p2!,
                                Uint8List.fromList(hex.decode(
                                    enterAPDUController!.text.substring(8))));
                            var blockBytes = makeBlock(apdu);
                            _device?.sendReport(0, blockBytes).then((value) {
                              print(
                                  'device.sendReport getAppAndVersion success');
                              addLog('Command sent to Nano S ');

                              _device?.subscribeInputReport(_handleInputReport);
                              addLog('Result received from Nano S');

                              setState(() {});

                              getLabelError();
                            }).catchError((error) {
                              print(
                                  'device.sendReport getAppAndVersion $error');
                              if (_device != null) {
                                addLog('Device opened before close ? ' +
                                    _device!.opened.toString());
                                _device?.close().then((value) {
                                  print('device.close success');
                                }).catchError((error) {
                                  print('device.close $error');
                                });
                              }
                            });
                          }).catchError((error) {
                            addLog(
                                'Device session Error : $error. Please send again to reconnect.');
                            if (_device != null) {
                              addLog('Device opened before close ? ' +
                                  _device!.opened.toString());
                              _device?.close().then((value) {
                                print('device.close success');
                              }).catchError((error) {
                                print('device.close $error');
                              });
                            }
                          });
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

  void getLabelError() {
    switch (response) {
      case '6d00':
        labelResponse = 'Invalid parameter received';
        break;
      case '670A':
        labelResponse = 'Lc is 0x00 whereas an application name is required';
        break;
      case '6807':
        labelResponse = 'The requested application is not present';
        break;
      case '9000':
        labelResponse = 'Success of the operation';
        break;
      default:
        labelResponse = '';
    }
    setState(() {});
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
Uint8List makeBlock(Uint8List apdu) {
  // TODO Multiple blocks

  var apduBuffer = WriteBuffer();
  apduBuffer.putUint16(apdu.length, endian: Endian.big);
  apduBuffer.putUint8List(apdu);
  var blockSize = packetSize - 5;
  var paddingLength = blockSize - apdu.length - 2;
  apduBuffer.putUint8List(Uint8List.fromList(List.filled(paddingLength, 0)));
  var apduData = apduBuffer.done();

  var writeBuffer = WriteBuffer();
  writeBuffer.putUint16(channel, endian: Endian.big);
  writeBuffer.putUint8(Tag);
  writeBuffer.putUint16(0, endian: Endian.big);
  writeBuffer.putUint8List(apduData.buffer.asUint8List());
  return writeBuffer.done().buffer.asUint8List();
}

Uint8List parseBlock(ByteData block) {
  var readBuffer = ReadBuffer(block);
  if (readBuffer.getUint16(endian: Endian.big) != channel) {
    throw ArgumentError('channel');
  }
  if (readBuffer.getUint8() != Tag) {
    throw ArgumentError('Tag');
  }
  if (readBuffer.getUint16(endian: Endian.big) != 0) {
    throw ArgumentError('blockSeqId');
  }

  var dataLength = readBuffer.getUint16(endian: Endian.big);
  var data = readBuffer.getUint8List(dataLength);

  return Uint8List.fromList(data);
}
