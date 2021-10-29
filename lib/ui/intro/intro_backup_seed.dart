// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show uint8ListToHex;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/model/data/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/mnemonic_display.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/keys/mnemonics.dart';

class IntroBackupSeedPage extends StatefulWidget {
  final String encryptedSeed;

  const IntroBackupSeedPage({this.encryptedSeed}) : super();

  @override
  _IntroBackupSeedState createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends State<IntroBackupSeedPage> {
  List<String> _mnemonic;

  @override
  void initState() {
    super.initState();

    sl.get<Vault>().getSessionKey().then((String key) {
      setState(() {
        final String _seed =
            uint8ListToHex(AppCrypt.decrypt(widget.encryptedSeed, key));
        _mnemonic = AppMnemomics.seedToMnemonic(_seed);
      });
    });
  }

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
                  StateContainer.of(context).curTheme.backgroundDark,
                  StateContainer.of(context).curTheme.background
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
                            child: Row(
                              children: <Widget>[
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                              .size
                                              .width -
                                          (smallScreen(context) ? 120 : 140)),
                                  child: AutoSizeText(
                                    'Recovery Phrase',
                                    style: AppStyles.textStyleSize28W700Primary(
                                        context),
                                    stepGranularity: 0.1,
                                    minFontSize: 12.0,
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 10, end: 10),
                                  child: FaIcon(
                                    FontAwesomeIcons.key,
                                    size: 36,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_mnemonic != null)
                            MnemonicDisplay(wordList: _mnemonic)
                          else
                            const Text('')
                        ],
                      ),
                    ),
                    // Next Screen Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          'I\'ve Backed It Up',
                          Dimens.BUTTON_BOTTOM_DIMENS,
                          onPressed: () {
                            // Update wallet
                            sl.get<DBHelper>().dropAccounts().then((_) {
                              StateContainer.of(context)
                                  .getSeed()
                                  .then((String seed) {
                                AppUtil().loginAccount(seed, context).then((_) {
                                  StateContainer.of(context).requestUpdate(
                                      StateContainer.of(context)
                                          .selectedAccount,
                                      null);
                                  Navigator.of(context)
                                      .pushNamed('/intro_backup_confirm');
                                });
                              });
                            });
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
}
