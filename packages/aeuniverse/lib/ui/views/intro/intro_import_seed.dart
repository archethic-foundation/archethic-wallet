/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/data/account.dart';
import 'package:core/model/data/app_wallet.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/price.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/keychain_util.dart';
import 'package:core/util/mnemonics.dart';
import 'package:core/util/seeds.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/user_data_util.dart';

class IntroImportSeedPage extends StatefulWidget {
  const IntroImportSeedPage({super.key});

  @override
  State<IntroImportSeedPage> createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends State<IntroImportSeedPage> {
  final FocusNode _mnemonicFocusNode = FocusNode();
  final TextEditingController _mnemonicController = TextEditingController();

  bool _mnemonicIsValid = false;
  String _mnemonicError = '';
  bool? isPressed;
  String language = 'en';

  @override
  void initState() {
    isPressed = false;
    Preferences.getInstance()
        .then((Preferences preferences) => preferences.setLanguageSeed('en'));
    super.initState();
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
                      StateContainer.of(context).curTheme.background2Small!),
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
                              margin: EdgeInsetsDirectional.only(
                                  start: smallScreen(context) ? 15 : 20),
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
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 15),
                                  height: 50,
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);

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
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 15),
                                  height: 50,
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);

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
                            AppLocalization.of(context)!.importSecretPhraseHint,
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
                                ],
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                autocorrect: false,
                                prefixButton: TextFieldButton(
                                  icon: FontAwesomeIcons.qrcode,
                                  onPressed: () async {
                                    sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        StateContainer.of(context)
                                            .activeVibrations);
                                    if (AppMnemomics.validateMnemonic(
                                        _mnemonicController.text.split(' '))) {
                                      return;
                                    }
                                    UIUtil.cancelLockEvent();
                                    final String? scanResult =
                                        await UserDataUtil.getQRData(
                                            DataType.address, context);
                                    if (scanResult == null) {
                                      UIUtil.showSnackbar(
                                          AppLocalization.of(context)!
                                              .qrInvalidAddress,
                                          context,
                                          StateContainer.of(context)
                                              .curTheme
                                              .text!,
                                          StateContainer.of(context)
                                              .curTheme
                                              .snackBarShadow!);
                                    } else if (QRScanErrs.errorList
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
                                            context,
                                            StateContainer.of(context)
                                                .curTheme
                                                .text!,
                                            StateContainer.of(context)
                                                .curTheme
                                                .snackBarShadow!);
                                      }
                                    }
                                  },
                                ),
                                fadePrefixOnCondition: true,
                                prefixShowFirstCondition:
                                    !AppMnemomics.validateMnemonic(
                                        _mnemonicController.text.split(' ')),
                                keyboardType: TextInputType.text,
                                style: _mnemonicIsValid
                                    ? AppStyles.textStyleSize16W400Primary(
                                        context)
                                    : AppStyles.textStyleSize16W400Primary60(
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
                                    setState(() {
                                      _mnemonicIsValid = true;
                                      _mnemonicError = '';
                                    });
                                  } else {
                                    setState(() {
                                      _mnemonicIsValid = false;
                                    });
                                    // Validate each mnemonic word
                                    if (text.endsWith(' ') && text.length > 1) {
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
                                      if (!AppMnemomics.isValidWord(lastWord,
                                          languageCode: language)) {
                                        setState(() {
                                          _mnemonicIsValid = false;
                                          setState(() {
                                            _mnemonicError =
                                                AppLocalization.of(context)!
                                                    .mnemonicInvalidWord
                                                    .replaceAll('%1', lastWord);
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
                                      style:
                                          AppStyles.textStyleSize16W200Primary(
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
                      isPressed == true ||
                              _mnemonicController.text
                                      .trim()
                                      .split(' ')
                                      .length !=
                                  24
                          ? AppButton.buildAppButton(
                              const Key('ok'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.ok,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('ok'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.ok,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                setState(() {
                                  _mnemonicError = '';
                                  isPressed = true;
                                });
                                _mnemonicFocusNode.unfocus();
                                List<String> _listWords =
                                    _mnemonicController.text.trim().split(' ');
                                _mnemonicIsValid = true;
                                for (int i = 0; i < _listWords.length; i++) {
                                  if (AppMnemomics.isValidWord(_listWords[i],
                                          languageCode: language) ==
                                      false) {
                                    _mnemonicIsValid = true;
                                    setState(() {
                                      _mnemonicIsValid = false;
                                      _mnemonicError =
                                          AppLocalization.of(context)!
                                              .mnemonicInvalidWord
                                              .replaceAll('%1', _listWords[i]);
                                    });
                                  }
                                }
                                if (_mnemonicIsValid == true) {
                                  if (AppMnemomics.validateMnemonic(
                                      _mnemonicController.text
                                          .trim()
                                          .split(' '))) {
                                    await sl.get<DBHelper>().clearAppWallet();
                                    StateContainer.of(context).appWallet = null;
                                    String seed =
                                        AppMnemomics.mnemonicListToSeed(
                                            _mnemonicController.text
                                                .trim()
                                                .split(' '),
                                            languageCode: language);
                                    final Vault _vault =
                                        await Vault.getInstance();
                                    _vault.setSeed(seed);
                                    Price tokenPrice = await Price.getCurrency(
                                        StateContainer.of(context)
                                            .curCurrency
                                            .currency
                                            .name);

                                    try {
                                      AppWallet? appWallet = await KeychainUtil()
                                          .getListAccountsFromKeychain(
                                              StateContainer.of(context)
                                                  .appWallet,
                                              seed,
                                              StateContainer.of(context)
                                                  .curCurrency
                                                  .currency
                                                  .name,
                                              StateContainer.of(context)
                                                  .curNetwork
                                                  .getNetworkCryptoCurrencyLabel(),
                                              tokenPrice,
                                              loadBalance: false,
                                              loadRecentTransactions: false);

                                      StateContainer.of(context).appWallet =
                                          appWallet;
                                      List<Account>? accounts =
                                          appWallet!.appKeychain!.accounts;

                                      if (accounts == null ||
                                          accounts.length == 0) {
                                        setState(() {
                                          _mnemonicIsValid = false;
                                          _mnemonicError =
                                              AppLocalization.of(context)!
                                                  .noKeychain;
                                        });
                                      } else {
                                        accounts.sort((a, b) =>
                                            a.name!.compareTo(b.name!));
                                        await _accountsDialog(accounts);

                                        await StateContainer.of(context)
                                            .requestUpdate();
                                        bool biometricsAvalaible = await sl
                                            .get<BiometricUtil>()
                                            .hasBiometrics();
                                        List<PickerItem> accessModes = [];
                                        accessModes.add(PickerItem(
                                            AppLocalization.of(context)!
                                                .pinMethod,
                                            AppLocalization.of(context)!
                                                .configureSecurityExplanationPIN,
                                            AuthenticationMethod.getIcon(
                                                AuthMethod.pin),
                                            StateContainer.of(context)
                                                .curTheme
                                                .pickerItemIconEnabled,
                                            AuthMethod.pin,
                                            true));
                                        accessModes.add(PickerItem(
                                            AppLocalization.of(context)!
                                                .passwordMethod,
                                            AppLocalization.of(context)!
                                                .configureSecurityExplanationPassword,
                                            AuthenticationMethod.getIcon(
                                                AuthMethod.password),
                                            StateContainer.of(context)
                                                .curTheme
                                                .pickerItemIconEnabled,
                                            AuthMethod.password,
                                            true));
                                        if (biometricsAvalaible) {
                                          accessModes.add(PickerItem(
                                              AppLocalization.of(context)!
                                                  .biometricsMethod,
                                              AppLocalization.of(context)!
                                                  .configureSecurityExplanationBiometrics,
                                              AuthenticationMethod.getIcon(
                                                  AuthMethod.biometrics),
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .pickerItemIconEnabled,
                                              AuthMethod.biometrics,
                                              true));
                                        }

                                        accessModes.add(PickerItem(
                                            AppLocalization.of(context)!
                                                .biometricsUnirisMethod,
                                            AppLocalization.of(context)!
                                                .configureSecurityExplanationUnirisBiometrics,
                                            AuthenticationMethod.getIcon(
                                                AuthMethod.biometricsUniris),
                                            StateContainer.of(context)
                                                .curTheme
                                                .pickerItemIconEnabled,
                                            AuthMethod.biometricsUniris,
                                            false));

                                        accessModes.add(PickerItem(
                                            AppLocalization.of(context)!
                                                .yubikeyWithYubiCloudMethod,
                                            AppLocalization.of(context)!
                                                .configureSecurityExplanationYubikey,
                                            AuthenticationMethod.getIcon(
                                                AuthMethod
                                                    .yubikeyWithYubicloud),
                                            StateContainer.of(context)
                                                .curTheme
                                                .pickerItemIconEnabled,
                                            AuthMethod.yubikeyWithYubicloud,
                                            true));
                                        Navigator.of(context).pushNamed(
                                            '/intro_configure_security',
                                            arguments: {
                                              'accessModes': accessModes,
                                              'name': await StateContainer.of(
                                                      context)
                                                  .appWallet!
                                                  .appKeychain!
                                                  .getAccountSelected()!
                                                  .name,
                                              'seed': await StateContainer.of(
                                                      context)
                                                  .getSeed(),
                                              'process': 'importWallet'
                                            });
                                      }
                                    } catch (e) {
                                      setState(() {
                                        _mnemonicIsValid = false;
                                        _mnemonicError =
                                            AppLocalization.of(context)!
                                                .noKeychain;
                                      });
                                    }
                                  } else {
                                    _mnemonicController.text
                                        .trim()
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

                                setState(() {
                                  isPressed = false;
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

  Future<void> _accountsDialog(List<Account> accounts) async {
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (Account account in accounts) {
      pickerItemsList
          .add(PickerItem(account.name!, null, null, null, account, true));
    }

    final Account? selection = await showDialog<Account>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalization.of(context)!.accountsHeader,
                    style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  accounts.length > 1
                      ? Text(
                          AppLocalization.of(context)!.selectAccountDescSeveral,
                          style: AppStyles.textStyleSize12W100Primary(context),
                        )
                      : Text(
                          AppLocalization.of(context)!.selectAccountDescOne,
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: SingleChildScrollView(
              child: PickerWidget(
                pickerItems: pickerItemsList,
                selectedIndex: 0,
                onSelected: (value) {
                  Navigator.pop(context, value.value);
                },
              ),
            ),
          );
        });
    if (selection != null) {
      await StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .setAccountSelected(selection);
    }
  }
}
