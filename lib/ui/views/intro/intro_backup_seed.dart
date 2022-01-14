// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/data/appdb.dart';
import 'package:archethic_wallet/util/service_locator.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/views/mnemonic_display.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_wallet/util/app_util.dart';
import 'package:archethic_wallet/util/mnemonics.dart';
import 'package:archethic_wallet/util/vault.dart';

class IntroBackupSeedPage extends StatefulWidget {
  const IntroBackupSeedPage() : super();

  @override
  _IntroBackupSeedState createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends State<IntroBackupSeedPage> {
  List<String>? _mnemonic;

  @override
  void initState() {
    super.initState();

    Vault.getInstance().then((Vault _vault) {
      setState(() {
        _mnemonic = AppMnemomics.seedToMnemonic(_vault.getSeed()!);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              top: 15,
                            ),
                            child: buildIconWidget(
                                context, 'assets/icons/key-word.png', 90, 90),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 30 : 40,
                              end: smallScreen(context) ? 30 : 40,
                              top: 10,
                            ),
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                              .size
                                              .width -
                                          (smallScreen(context) ? 120 : 140)),
                                  child: AutoSizeText(
                                    AppLocalization.of(context)!.recoveryPhrase,
                                    style: AppStyles.textStyleSize28W700Primary(
                                        context),
                                    stepGranularity: 0.1,
                                    minFontSize: 12.0,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_mnemonic != null)
                            Expanded(
                              child: SingleChildScrollView(
                                child: MnemonicDisplay(wordList: _mnemonic!),
                              ),
                            )
                          else
                            const Text('')
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context)!.iveBackedItUp,
                          Dimens.BUTTON_BOTTOM_DIMENS,
                          onPressed: () {
                            sl.get<DBHelper>().dropAccounts().then((_) {
                              StateContainer.of(context)
                                  .getSeed()
                                  .then((String seed) {
                                AppUtil().loginAccount(seed, context).then((_) {
                                  StateContainer.of(context).requestUpdate(
                                    account: StateContainer.of(context)
                                        .selectedAccount,
                                  );
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
