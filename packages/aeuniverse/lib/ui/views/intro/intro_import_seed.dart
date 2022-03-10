// Flutter imports:
// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/mnemonics.dart';
import 'package:core/util/seeds.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/views/pin_screen.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/util/user_data_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroImportSeedPage extends StatefulWidget {
  const IntroImportSeedPage({Key? key}) : super(key: key);

  @override
  _IntroImportSeedState createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends State<IntroImportSeedPage> {
  final List<FocusNode> _mnemonicFocusNodeList =
      List<FocusNode>.filled(24, FocusNode());
  final List<TextEditingController> _mnemonicControllerList =
      List<TextEditingController>.filled(24, TextEditingController());

  List<bool> _mnemonicIsValidList = List<bool>.filled(24, false);
  List<String> _mnemonicErrorList = List<String>.filled(24, '');
  int wordNum = 0;

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
          LayoutBuilder(
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
                                AppStyles.textStyleSize20W700Primary(context),
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
                            AppLocalization.of(context)!.importSecretPhraseHint,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        wordEnter(wordNum),
                        wordEnter(wordNum + 1),
                        wordEnter(wordNum + 2),
                        wordEnter(wordNum + 4),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppButton.buildAppButton(
                        context,
                        AppButtonType.primary,
                        AppLocalization.of(context)!.go,
                        Dimens.buttonBottomDimens,
                        onPressed: () async {
                          _mnemonicFocusNodeList[0].unfocus();
                          if (AppMnemomics.validateMnemonic(
                              _mnemonicControllerList[0].text.split(' '))) {
                            String _seed = AppMnemomics.mnemonicListToSeed(
                                _mnemonicControllerList[0].text.split(' '));
                            final Vault _vault = await Vault.getInstance();
                            _vault.setSeed(_seed);
                            await sl.get<DBHelper>().dropAccounts();
                            Account selectedAcct =
                                await AppUtil().loginAccount(_seed, context);
                            StateContainer.of(context)
                                .requestUpdate(account: selectedAcct);
                            StateContainer.of(context).requestUpdate(
                                account:
                                    StateContainer.of(context).selectedAccount);
                            final String pin = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return const PinScreen(
                                PinOverlayType.newPin,
                              );
                            }));
                            if (pin.length > 5) {
                              _pinEnteredCallback(pin);
                            }
                          } else {
                            if (_mnemonicControllerList[0]
                                    .text
                                    .split(' ')
                                    .length !=
                                24) {
                              setState(() {
                                _mnemonicIsValidList[wordNum] = false;
                                _mnemonicErrorList[wordNum] =
                                    AppLocalization.of(context)!
                                        .mnemonicSizeError;
                              });
                            } else {
                              _mnemonicControllerList[0]
                                  .text
                                  .split(' ')
                                  .forEach((String word) {
                                if (!AppMnemomics.isValidWord(word)) {
                                  setState(() {
                                    _mnemonicIsValidList[wordNum] = false;
                                    _mnemonicErrorList[wordNum] =
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
        ],
      ),
    );
  }

  Widget wordEnter(int wordNumber) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppTextField(
            leftMargin: smallScreen(context) ? 30 : 40,
            rightMargin: smallScreen(context) ? 30 : 40,
            topMargin: 20,
            focusNode: _mnemonicFocusNodeList[wordNumber],
            controller: _mnemonicControllerList[wordNumber],
            inputFormatters: [
              SingleSpaceInputFormatter(),
              LowerCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
            textInputAction: TextInputAction.done,
            maxLines: 1,
            autocorrect: false,
            keyboardType: TextInputType.text,
            style: _mnemonicIsValidList[wordNumber]
                ? AppStyles.textStyleSize16W200Primary(context)
                : AppStyles.textStyleSize16W200Primary30(context),
            onChanged: (String text) {
              if (text.length < 3) {
                setState(() {
                  _mnemonicErrorList[wordNumber] = '';
                });
              } else if (_mnemonicErrorList[wordNumber].isNotEmpty) {
                if (!text
                    .contains(_mnemonicErrorList[wordNumber].split(' ')[0])) {
                  setState(() {
                    _mnemonicErrorList[wordNumber] = '';
                  });
                }
              }
              // If valid mnemonic, clear focus/close keyboard
              if (AppMnemomics.validateMnemonic(text.split(' '))) {
                _mnemonicFocusNodeList[wordNumber].unfocus();
                setState(() {
                  _mnemonicIsValidList[wordNumber] = true;
                  _mnemonicErrorList[wordNumber] = '';
                });
              } else {
                setState(() {
                  _mnemonicIsValidList[wordNumber] = false;
                });
                // Validate each mnemonic word
                if (text.endsWith(' ') && text.length > 1) {
                  int lastSpaceIndex =
                      text.substring(0, text.length - 1).lastIndexOf(' ');
                  if (lastSpaceIndex == -1) {
                    lastSpaceIndex = 0;
                  } else {
                    lastSpaceIndex++;
                  }
                  final String lastWord =
                      text.substring(lastSpaceIndex, text.length - 1);
                  if (!AppMnemomics.isValidWord(lastWord)) {
                    setState(() {
                      _mnemonicIsValidList[wordNumber] = false;
                      setState(() {
                        _mnemonicErrorList[wordNumber] =
                            AppLocalization.of(context)!
                                .mnemonicInvalidWord
                                .replaceAll('%1', lastWord);
                      });
                    });
                  } else {
                    setState(() {
                      _mnemonicIsValidList[wordNumber] = true;
                      _mnemonicErrorList[wordNumber] = '';
                    });
                  }
                }
              }
            },
          ),
          if (_mnemonicErrorList[wordNumber] != '')
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(_mnemonicErrorList[wordNumber],
                  style: AppStyles.textStyleSize16W200Primary(context)),
            )
          else
            const SizedBox(),
        ]);
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
