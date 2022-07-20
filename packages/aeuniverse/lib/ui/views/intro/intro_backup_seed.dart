/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/mnemonics.dart';
import 'package:core/util/seeds.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/mnemonic_display.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/util/preferences.dart';

class IntroBackupSeedPage extends StatefulWidget {
  final String? name;
  const IntroBackupSeedPage({super.key, this.name});

  @override
  State<IntroBackupSeedPage> createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends State<IntroBackupSeedPage> {
  String? seed;
  List<String>? mnemonic;
  bool? isPressed;
  String language = 'en';

  @override
  void initState() {
    super.initState();

    isPressed = false;
    seed = AppSeeds.generateSeed();
    mnemonic = AppMnemomics.seedToMnemonic(seed!);
    Preferences.getInstance()
        .then((Preferences preferences) => preferences.setLanguageSeed('en'));
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
              image: DecorationImage(
                  image: AssetImage(
                      StateContainer.of(context).curTheme.background4Small!),
                  fit: BoxFit.fitHeight),
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
                              margin: EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                key: const Key('back'),
                                color: StateContainer.of(context).curTheme.text,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsetsDirectional.only(start: 15),
                                  height: 50,
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);
                                      seed = AppSeeds.generateSeed();
                                      mnemonic = AppMnemomics.seedToMnemonic(
                                          seed!,
                                          languageCode: 'en');
                                      Preferences preferences =
                                          await Preferences.getInstance();
                                      preferences.setLanguageSeed('en');
                                      setState(() {
                                        language = 'en';
                                      });
                                    },
                                    child: language == 'en'
                                        ? Image.asset(
                                            'packages/aeuniverse/assets/icons/languages/united-states.png')
                                        : Opacity(
                                            opacity: 0.3,
                                            child: Image.asset(
                                                'packages/aeuniverse/assets/icons/languages/united-states.png'),
                                          ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(start: 15),
                                  height: 50,
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);
                                      seed = AppSeeds.generateSeed();
                                      mnemonic = AppMnemomics.seedToMnemonic(
                                          seed!,
                                          languageCode: 'fr');
                                      Preferences preferences =
                                          await Preferences.getInstance();
                                      preferences.setLanguageSeed('fr');
                                      setState(() {
                                        language = 'fr';
                                      });
                                    },
                                    child: language == 'fr'
                                        ? Image.asset(
                                            'packages/aeuniverse/assets/icons/languages/france.png')
                                        : Opacity(
                                            opacity: 0.3,
                                            child: Image.asset(
                                                'packages/aeuniverse/assets/icons/languages/france.png'),
                                          ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: buildIconWidget(
                              context,
                              'packages/aeuniverse/assets/icons/key-word.png',
                              90,
                              90),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            top: 10,
                          ),
                          child: AutoSizeText(
                            AppLocalization.of(context)!.recoveryPhrase,
                            style:
                                AppStyles.textStyleSize20W700Primary(context),
                          ),
                        ),
                        if (mnemonic != null)
                          Expanded(
                            child: SingleChildScrollView(
                              child: MnemonicDisplay(wordList: mnemonic!),
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
                      isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('iveBackedItUp'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.iveBackedItUp,
                              Dimens.buttonBottomDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('iveBackedItUp'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.iveBackedItUp,
                              Dimens.buttonBottomDimens,
                              onPressed: () async {
                                Navigator.of(context).pushNamed(
                                    '/intro_backup_confirm',
                                    arguments: {
                                      'name': widget.name,
                                      'seed': seed
                                    });
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
}
