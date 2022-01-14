// Flutter imports:
// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/util/formatters.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/views/pin_screen.dart';
import 'package:archethic_wallet/ui/widgets/components/app_text_field.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/util/mnemonics.dart';
import 'package:archethic_wallet/util/seeds.dart';
import 'package:archethic_wallet/util/user_data_util.dart';
import 'package:archethic_wallet/util/vault.dart';

class IntroImportSeedPage extends StatefulWidget {
  @override
  _IntroImportSeedState createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends State<IntroImportSeedPage> {
  final FocusNode _mnemonicFocusNode = FocusNode();
  final TextEditingController _mnemonicController = TextEditingController();

  bool _mnemonicIsValid = false;
  String _mnemonicError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDarkest,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  StateContainer.of(context).curTheme.backgroundDark!,
                  StateContainer.of(context).curTheme.background!
                ],
              ),
            ),
          ),
          Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SafeArea(
                minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                    top: MediaQuery.of(context).size.height * 0.075),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: smallScreen(context) ? 15 : 20),
                                height: 50,
                                width: 50,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: FaIcon(FontAwesomeIcons.chevronLeft,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary,
                                        size: 24)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 30 : 40,
                              end: smallScreen(context) ? 30 : 40,
                              top: 10,
                            ),
                            alignment: const AlignmentDirectional(-1, 0),
                            child: AutoSizeText(
                              AppLocalization.of(context)!.importSecretPhrase,
                              style:
                                  AppStyles.textStyleSize28W700Primary(context),
                              maxLines: 1,
                              minFontSize: 12,
                              stepGranularity: 0.1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: smallScreen(context) ? 30 : 40,
                                right: smallScreen(context) ? 30 : 40,
                                top: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalization.of(context)!
                                  .importSecretPhraseHint,
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                AppTextField(
                                  leftMargin: smallScreen(context) ? 30 : 40,
                                  rightMargin: smallScreen(context) ? 30 : 40,
                                  topMargin: 20,
                                  focusNode: _mnemonicFocusNode,
                                  controller: _mnemonicController,
                                  inputFormatters: [
                                    SingleSpaceInputFormatter(),
                                    LowerCaseTextFormatter(),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z ]')),
                                  ],
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  autocorrect: false,
                                  prefixButton: TextFieldButton(
                                    icon: FontAwesomeIcons.qrcode,
                                    onPressed: () async {
                                      if (AppMnemomics.validateMnemonic(
                                          _mnemonicController.text
                                              .split(' '))) {
                                        return;
                                      }
                                      UIUtil.cancelLockEvent();
                                      final String? scanResult =
                                          await UserDataUtil.getQRData(
                                              DataType.ADDRESS, context);
                                      if (scanResult == null) {
                                        UIUtil.showSnackbar(
                                            AppLocalization.of(context)!
                                                .qrInvalidAddress,
                                            context);
                                      } else if (QRScanErrs.ERROR_LIST
                                          .contains(scanResult)) {
                                        return;
                                      } else {
                                        if (AppMnemomics.validateMnemonic(
                                            scanResult.split(' '))) {
                                          _mnemonicController.text = scanResult;
                                          setState(() {
                                            _mnemonicIsValid = true;
                                          });
                                        } else if (AppSeeds.isValidSeed(
                                            scanResult)) {
                                          _mnemonicFocusNode.unfocus();
                                        } else {
                                          UIUtil.showSnackbar(
                                              AppLocalization.of(context)!
                                                  .qrMnemonicError,
                                              context);
                                        }
                                      }
                                    },
                                  ),
                                  fadePrefixOnCondition: true,
                                  prefixShowFirstCondition:
                                      !AppMnemomics.validateMnemonic(
                                          _mnemonicController.text.split(' ')),
                                  suffixButton: TextFieldButton(
                                    icon: FontAwesomeIcons.paste,
                                    onPressed: () {
                                      if (AppMnemomics.validateMnemonic(
                                          _mnemonicController.text
                                              .split(' '))) {
                                        return;
                                      }
                                      Clipboard.getData('text/plain')
                                          .then((ClipboardData? data) {
                                        if (data == null || data.text == null) {
                                          return;
                                        } else if (AppMnemomics
                                            .validateMnemonic(
                                                data.text!.split(' '))) {
                                          _mnemonicController.text = data.text!;
                                          setState(() {
                                            _mnemonicIsValid = true;
                                          });
                                        } else if (AppSeeds.isValidSeed(
                                            data.text!)) {
                                          _mnemonicFocusNode.unfocus();
                                        }
                                      });
                                    },
                                  ),
                                  fadeSuffixOnCondition: true,
                                  suffixShowFirstCondition:
                                      !AppMnemomics.validateMnemonic(
                                          _mnemonicController.text.split(' ')),
                                  keyboardType: TextInputType.text,
                                  style: _mnemonicIsValid
                                      ? AppStyles.textStyleSize16W200Primary(
                                          context)
                                      : AppStyles.textStyleSize16W200Primary30(
                                          context),
                                  onChanged: (String text) {
                                    if (text.length < 3) {
                                      setState(() {
                                        _mnemonicError = '';
                                      });
                                    } else if (_mnemonicError.isNotEmpty) {
                                      if (!text.contains(
                                          _mnemonicError.split(' ')[0])) {
                                        setState(() {
                                          _mnemonicError = '';
                                        });
                                      }
                                    }
                                    // If valid mnemonic, clear focus/close keyboard
                                    if (AppMnemomics.validateMnemonic(
                                        text.split(' '))) {
                                      _mnemonicFocusNode.unfocus();
                                      setState(() {
                                        _mnemonicIsValid = true;
                                        _mnemonicError = '';
                                      });
                                    } else {
                                      setState(() {
                                        _mnemonicIsValid = false;
                                      });
                                      // Validate each mnemonic word
                                      if (text.endsWith(' ') &&
                                          text.length > 1) {
                                        int lastSpaceIndex = text
                                            .substring(0, text.length - 1)
                                            .lastIndexOf(' ');
                                        if (lastSpaceIndex == -1) {
                                          lastSpaceIndex = 0;
                                        } else {
                                          lastSpaceIndex++;
                                        }
                                        final String lastWord = text.substring(
                                            lastSpaceIndex, text.length - 1);
                                        if (!AppMnemomics.isValidWord(
                                            lastWord)) {
                                          setState(() {
                                            _mnemonicIsValid = false;
                                            setState(() {
                                              _mnemonicError =
                                                  AppLocalization.of(context)!
                                                      .mnemonicInvalidWord
                                                      .replaceAll(
                                                          '%1', lastWord);
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            _mnemonicIsValid = true;
                                            _mnemonicError = '';
                                          });
                                        }
                                      }
                                    }
                                  },
                                ),
                                if (_mnemonicError != '')
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Text(_mnemonicError,
                                        style: AppStyles
                                            .textStyleSize16W200Primary(
                                                context)),
                                  )
                                else
                                  const SizedBox(),
                              ]))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context)!.go,
                          Dimens.BUTTON_BOTTOM_DIMENS,
                          onPressed: () async {
                            _mnemonicFocusNode.unfocus();
                            if (AppMnemomics.validateMnemonic(
                                _mnemonicController.text.split(' '))) {
                              final String pin = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const PinScreen(
                                  PinOverlayType.NEW_PIN,
                                );
                              }));
                              if (pin.length > 5) {
                                _pinEnteredCallback(pin);
                              }
                            } else {
                              if (_mnemonicController.text.split(' ').length !=
                                  24) {
                                setState(() {
                                  _mnemonicIsValid = false;
                                  _mnemonicError = AppLocalization.of(context)!
                                      .mnemonicSizeError;
                                });
                              } else {
                                _mnemonicController.text
                                    .split(' ')
                                    .forEach((String word) {
                                  if (!AppMnemomics.isValidWord(word)) {
                                    setState(() {
                                      _mnemonicIsValid = false;
                                      _mnemonicError =
                                          AppLocalization.of(context)!
                                              .mnemonicInvalidWord
                                              .replaceAll('%1', word);
                                    });
                                  }
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pinEnteredCallback(String pin) async {
    final Vault _vault = await Vault.getInstance();
    _vault.setPin(pin);
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (Route<dynamic> route) => false,
    );
  }
}
