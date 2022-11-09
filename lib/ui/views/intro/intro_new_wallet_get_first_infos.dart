/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/network_choice_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroNewWalletGetFirstInfos extends ConsumerStatefulWidget {
  const IntroNewWalletGetFirstInfos({super.key});

  @override
  ConsumerState<IntroNewWalletGetFirstInfos> createState() =>
      _IntroNewWalletDisclaimerState();
}

class _IntroNewWalletDisclaimerState
    extends ConsumerState<IntroNewWalletGetFirstInfos> {
  late FocusNode nameFocusNode;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final network = NetworksSetting(
      network: settings.networks,
      networkDevEndpoint: ref
          .watch(SettingsProviders.localSettingsRepository)
          .getNetworkDevEndpoint(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background2Small!,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 15 : 20,
                              ),
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
                          ],
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 15,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                localizations
                                    .introNewWalletGetFirstInfosWelcome,
                                style: theme.textStyleSize20W700Primary,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                localizations
                                    .introNewWalletGetFirstInfosNameRequest,
                                style: theme.textStyleSize16W600Primary,
                                textAlign: TextAlign.left,
                              ),
                              AppTextField(
                                autofocus: true,
                                leftMargin: 0,
                                rightMargin: 0,
                                focusNode: nameFocusNode,
                                autocorrect: false,
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                style: theme.textStyleSize14W600Primary,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(20),
                                  UpperCaseTextFormatter(),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              AutoSizeText(
                                localizations
                                    .introNewWalletGetFirstInfosNameInfos,
                                style: theme.textStyleSize14W600Primary,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Divider(
                                height: 5,
                                color: theme.text15,
                              ),
                              NetworkChoiceInfos(
                                onTap: () {
                                  NetworkDialog.getDialog(
                                    context,
                                    ref,
                                    network,
                                  );
                                  FocusScope.of(context)
                                      .requestFocus(nameFocusNode);
                                },
                              ),
                              Divider(
                                height: 5,
                                color: theme.text15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton(
                      AppButtonType.primary,
                      localizations.ok,
                      Dimens.buttonBottomDimens,
                      key: const Key('okButton'),
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          UIUtil.showSnackbar(
                            localizations.introNewWalletGetFirstInfosNameBlank,
                            context,
                            ref,
                            theme.text!,
                            theme.snackBarShadow!,
                          );
                        } else {
                          AppDialogs.showConfirmDialog(
                            context,
                            ref,
                            localizations.newAccount,
                            localizations.newAccountConfirmation
                                .replaceAll('%1', nameController.text),
                            localizations.yes,
                            () async {
                              Navigator.of(context).pushNamed(
                                '/intro_backup_safety',
                                arguments: nameController.text,
                              );
                            },
                            cancelText: localizations.no,
                          );
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
    );
  }
}
