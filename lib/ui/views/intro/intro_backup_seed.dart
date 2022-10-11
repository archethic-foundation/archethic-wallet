/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/seeds.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class IntroBackupSeedPage extends ConsumerStatefulWidget {
  const IntroBackupSeedPage({super.key, this.name});
  final String? name;

  @override
  ConsumerState<IntroBackupSeedPage> createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends ConsumerState<IntroBackupSeedPage> {
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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.backgroundDarkest,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 15),
                            height: 50,
                            width: 50,
                            child: BackButton(
                              key: const Key('back'),
                              color: theme.text,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                  start: 15,
                                ),
                                height: 50,
                                width: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations,
                                        );
                                    seed = AppSeeds.generateSeed();
                                    mnemonic = AppMnemomics.seedToMnemonic(
                                      seed!,
                                    );
                                    final preferences =
                                        await Preferences.getInstance();
                                    preferences.setLanguageSeed('en');
                                    setState(() {
                                      language = 'en';
                                    });
                                  },
                                  child: language == 'en'
                                      ? Image.asset(
                                          'assets/icons/languages/united-states.png',
                                        )
                                      : Opacity(
                                          opacity: 0.3,
                                          child: Image.asset(
                                            'assets/icons/languages/united-states.png',
                                          ),
                                        ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                  start: 15,
                                ),
                                height: 50,
                                width: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations,
                                        );
                                    seed = AppSeeds.generateSeed();
                                    mnemonic = AppMnemomics.seedToMnemonic(
                                      seed!,
                                      languageCode: 'fr',
                                    );
                                    final preferences =
                                        await Preferences.getInstance();
                                    preferences.setLanguageSeed('fr');
                                    setState(() {
                                      language = 'fr';
                                    });
                                  },
                                  child: language == 'fr'
                                      ? Image.asset(
                                          'assets/icons/languages/france.png',
                                        )
                                      : Opacity(
                                          opacity: 0.3,
                                          child: Image.asset(
                                            'assets/icons/languages/france.png',
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const IconWidget(
                        icon: 'assets/icons/key-word.png',
                        width: 90,
                        height: 90,
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                          top: 10,
                        ),
                        child: AutoSizeText(
                          localizations.recoveryPhrase,
                          style: theme.textStyleSize20W700Primary,
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
                    if (isPressed == true)
                      AppButton.buildAppButton(
                        const Key('iveBackedItUp'),
                        context,
                        ref,
                        AppButtonType.primaryOutline,
                        localizations.iveBackedItUp,
                        Dimens.buttonBottomDimens,
                        onPressed: () {},
                      )
                    else
                      AppButton.buildAppButton(
                        const Key('iveBackedItUp'),
                        context,
                        ref,
                        AppButtonType.primary,
                        localizations.iveBackedItUp,
                        Dimens.buttonBottomDimens,
                        onPressed: () async {
                          Navigator.of(context).pushNamed(
                            '/intro_backup_confirm',
                            arguments: {'name': widget.name, 'seed': seed},
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
