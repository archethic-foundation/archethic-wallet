/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aewallet/util/confirmations/confirmations_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/confirmations/subscription_channel.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';

class IntroBackupConfirm extends StatefulWidget {
  final String? name;
  final String? seed;
  const IntroBackupConfirm({required this.name, required this.seed, super.key});

  @override
  State<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> wordListSelected = List<String>.empty(growable: true);
  List<String> wordListToSelect = List<String>.empty(growable: true);
  List<String> originalWordsList = List<String>.empty(growable: true);

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;
  SubscriptionChannel subscriptionChannel = SubscriptionChannel();
  SubscriptionChannel subscriptionChannel2 = SubscriptionChannel();

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      await createKeychain();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        UIUtil.showSnackbar(
            '${AppLocalization.of(context)!.sendError} (${event.response!})',
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!);
        Navigator.of(context).pop(false);
      } else {
        if (event.response == 'ok' &&
            ConfirmationsUtil.isEnoughConfirmations(
                event.nbConfirmations!, event.maxConfirmations!)) {
          UIUtil.showSnackbar(
              event.nbConfirmations == 1
                  ? AppLocalization.of(context)!
                      .transactionConfirmed1
                      .replaceAll('%1', event.nbConfirmations.toString())
                      .replaceAll('%2', event.maxConfirmations.toString())
                  : AppLocalization.of(context)!
                      .transactionConfirmed
                      .replaceAll('%1', event.nbConfirmations.toString())
                      .replaceAll('%2', event.maxConfirmations.toString()),
              context,
              StateContainer.of(context).curTheme.text!,
              StateContainer.of(context).curTheme.snackBarShadow!);

          switch (event.transactionType) {
            case TransactionSendEventType.keychain:
              Preferences preferences = await Preferences.getInstance();
              await subscriptionChannel2.connect(
                  await preferences.getNetwork().getPhoenixHttpLink(),
                  await preferences.getNetwork().getWebsocketUri());

              await KeychainUtil().createKeyChainAccess(
                widget.seed!,
                widget.name!,
                event.params!['keychainAddress']! as String,
                event.params!['originPrivateKey']! as String,
                event.params!['keychain']! as Keychain,
                subscriptionChannel2,
              );
              break;
            case TransactionSendEventType.keychainAccess:
              bool error = false;
              try {
                StateContainer.of(context).appWallet = await AppWallet()
                    .createNewAppWallet(
                        event.params!['keychainAddress']! as String,
                        event.params!['keychain']! as Keychain,
                        widget.name!);
              } catch (e) {
                error = true;
                UIUtil.showSnackbar(
                    '${AppLocalization.of(context)!.sendError} ($e)',
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!);
              }
              if (error == false) {
                await StateContainer.of(context).requestUpdate();

                StateContainer.of(context).checkTransactionInputs(
                    AppLocalization.of(context)!.transactionInputNotification);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.of(context).pop();
              }
              break;
            default:
              throw Exception('TransactionSendEventType doesn\'t exist');
          }
        }
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    if (_sendTxSub != null) {
      _sendTxSub!.cancel();
    }
  }

  @override
  void dispose() {
    _destroyBus();
    subscriptionChannel.close();
    subscriptionChannel2.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        wordListToSelect = AppMnemomics.seedToMnemonic(widget.seed!,
            languageCode: preferences.getLanguageSeed());
        wordListToSelect.shuffle();
        originalWordsList = AppMnemomics.seedToMnemonic(widget.seed!,
            languageCode: preferences.getLanguageSeed());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background3Small!),
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 15),
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
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 10,
                          ),
                          alignment: const AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context)!.confirmSecretPhrase,
                            style:
                                AppStyles.textStyleSize20W700Warning(context),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 15.0),
                          child: AutoSizeText(
                            AppLocalization.of(context)!
                                .confirmSecretPhraseExplanation,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.justify,
                            maxLines: 6,
                            stepGranularity: 0.5,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 15.0),
                          child: Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.start,
                              children: wordListSelected
                                  .asMap()
                                  .entries
                                  .map((MapEntry entry) {
                                return SizedBox(
                                  height: 35,
                                  child: Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.grey.shade800,
                                      child: Text((entry.key + 1).toString(),
                                          style: AppStyles
                                              .textStyleSize12W100Primary60(
                                                  context)),
                                    ),
                                    label: Text(entry.value,
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context)),
                                    onDeleted: () {
                                      setState(() {
                                        wordListToSelect.add(entry.value);
                                        wordListSelected.removeAt(entry.key);
                                      });
                                    },
                                    deleteIconColor: Colors.white,
                                  ),
                                );
                              }).toList()),
                        ),
                        Divider(
                          height: 15,
                          color: StateContainer.of(context).curTheme.text60,
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 15.0),
                          child: Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.start,
                              children: wordListToSelect
                                  .asMap()
                                  .entries
                                  .map((MapEntry entry) {
                                return SizedBox(
                                    height: 35,
                                    child: GestureDetector(
                                        onTap: () {
                                          wordListSelected.add(entry.value);
                                          wordListToSelect.removeAt(entry.key);
                                          setState(() {});
                                        },
                                        child: Chip(
                                          label: Text(entry.value,
                                              style: AppStyles
                                                  .textStyleSize12W400Primary(
                                                      context)),
                                        )));
                              }).toList()),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        wordListSelected.length != 24
                            ? AppButton.buildAppButton(
                                const Key('confirm'),
                                context,
                                AppButtonType.primaryOutline,
                                AppLocalization.of(context)!.confirm,
                                Dimens.buttonTopDimens,
                                onPressed: () {},
                              )
                            : AppButton.buildAppButton(
                                const Key('confirm'),
                                context,
                                AppButtonType.primary,
                                AppLocalization.of(context)!.confirm,
                                Dimens.buttonTopDimens, onPressed: () async {
                                bool orderOk = true;

                                for (int i = 0;
                                    i < originalWordsList.length;
                                    i++) {
                                  if (originalWordsList[i] !=
                                      wordListSelected[i]) {
                                    orderOk = false;
                                  }
                                }
                                if (orderOk == false) {
                                  setState(() {
                                    UIUtil.showSnackbar(
                                        AppLocalization.of(context)!
                                            .confirmSecretPhraseKo,
                                        context,
                                        StateContainer.of(context)
                                            .curTheme
                                            .text!,
                                        StateContainer.of(context)
                                            .curTheme
                                            .snackBarShadow!);
                                  });
                                } else {
                                  await _launchSecurityConfiguration(
                                      widget.name!, widget.seed!);
                                }
                              }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                          const Key('pass'),
                          context,
                          AppButtonType.primary,
                          AppLocalization.of(context)!.pass,
                          Dimens.buttonBottomDimens,
                          onPressed: () {
                            AppDialogs.showConfirmDialog(
                                context,
                                AppLocalization.of(context)!
                                    .passBackupConfirmationDisclaimer,
                                AppLocalization.of(context)!
                                    .passBackupConfirmationMessage,
                                AppLocalization.of(context)!.yes, () async {
                              await _launchSecurityConfiguration(
                                  widget.name!, widget.seed!);
                            });
                          },
                        )
                      ],
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

  Future<bool> _launchSecurityConfiguration(String name, String seed) async {
    bool biometricsAvalaible = await sl.get<BiometricUtil>().hasBiometrics();
    List<PickerItem> accessModes = [];
    accessModes.add(PickerItem(
        AuthenticationMethod(AuthMethod.pin).getDisplayName(context),
        AuthenticationMethod(AuthMethod.pin).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.pin),
        StateContainer.of(context).curTheme.pickerItemIconEnabled,
        AuthMethod.pin,
        true));
    accessModes.add(PickerItem(
        AuthenticationMethod(AuthMethod.password).getDisplayName(context),
        AuthenticationMethod(AuthMethod.password).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.password),
        StateContainer.of(context).curTheme.pickerItemIconEnabled,
        AuthMethod.password,
        true));
    if (biometricsAvalaible) {
      accessModes.add(PickerItem(
          AuthenticationMethod(AuthMethod.biometrics).getDisplayName(context),
          AuthenticationMethod(AuthMethod.biometrics).getDescription(context),
          AuthenticationMethod.getIcon(AuthMethod.biometrics),
          StateContainer.of(context).curTheme.pickerItemIconEnabled,
          AuthMethod.biometrics,
          true));
    }
    accessModes.add(PickerItem(
        AuthenticationMethod(AuthMethod.biometricsUniris)
            .getDisplayName(context),
        AuthenticationMethod(AuthMethod.biometricsUniris)
            .getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.biometricsUniris),
        StateContainer.of(context).curTheme.pickerItemIconEnabled,
        AuthMethod.biometricsUniris,
        false));
    accessModes.add(PickerItem(
        AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
            .getDisplayName(context),
        AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
            .getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.yubikeyWithYubicloud),
        StateContainer.of(context).curTheme.pickerItemIconEnabled,
        AuthMethod.yubikeyWithYubicloud,
        true));

    bool securityConfiguration = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return IntroConfigureSecurity(
        accessModes: accessModes,
        name: name,
        seed: seed,
      );
    }));

    return securityConfiguration;
  }

  void _showSendingAnimation(BuildContext context) {
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        title: AppLocalization.of(context)!.appWalletInitInProgress));
  }

  Future<void> createKeychain() async {
    _showSendingAnimation(context);

    bool error = false;

    try {
      await sl.get<DBHelper>().clearAppWallet();
      final Vault vault = await Vault.getInstance();
      await vault.setSeed(widget.seed!);

      final String originPrivateKey = sl.get<ApiService>().getOriginKey();

      Preferences preferences = await Preferences.getInstance();

      await subscriptionChannel.connect(
          await preferences.getNetwork().getPhoenixHttpLink(),
          await preferences.getNetwork().getWebsocketUri());

      await KeychainUtil().createKeyChain(widget.seed!, widget.name!,
          originPrivateKey, preferences, subscriptionChannel);
    } catch (e) {
      error = true;
      UIUtil.showSnackbar(
          '${AppLocalization.of(context)!.sendError} ($e)',
          context,
          StateContainer.of(context).curTheme.text!,
          StateContainer.of(context).curTheme.snackBarShadow!);
    }

    if (error == false) {
    } else {
      Navigator.of(context).pop();
    }
  }
}
