/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/network_choice_infos.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroNewWalletGetFirstInfos extends ConsumerStatefulWidget {
  const IntroNewWalletGetFirstInfos({super.key});

  static const routerPage = '/intro_welcome_get_first_infos';

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
    final localizations = AppLocalizations.of(context)!;

    final settings = ref.watch(SettingsProviders.settings);
    final network = settings.network;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                    start: smallScreen(context) ? 15 : 20,
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: BackButton(
                                    key: const Key('back'),
                                    color: ArchethicTheme.text,
                                    onPressed: () {
                                      context.go(IntroWelcome.routerPage);
                                    },
                                  ),
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
                              ],
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    localizations
                                        .introNewWalletGetFirstInfosWelcome,
                                    style: ArchethicThemeStyles
                                        .textStyleSize24W700Primary,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  AutoSizeText(
                                    localizations
                                        .introNewWalletGetFirstInfosNameRequest,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .introNewWalletGetFirstInfosNameBlank,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer,
                                                        width: 0.5,
                                                      ),
                                                      gradient: ArchethicThemeBase
                                                          .gradientInputFormBackground,
                                                    ),
                                                    child: TextField(
                                                      key: const Key(
                                                        'newAccountName',
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      autocorrect: false,
                                                      controller:
                                                          nameController,
                                                      focusNode: nameFocusNode,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      inputFormatters: <TextInputFormatter>[
                                                        LengthLimitingTextInputFormatter(
                                                          20,
                                                        ),
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  AutoSizeText(
                                    localizations
                                        .introNewWalletGetFirstInfosNameInfos,
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              )
                                  .animate()
                                  .fade(
                                    duration: const Duration(milliseconds: 200),
                                  )
                                  .scale(
                                    duration: const Duration(milliseconds: 200),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButtonTinyConnectivity(
                          localizations.ok,
                          Dimens.buttonBottomDimens,
                          key: const Key('okButton'),
                          onPressed: () {
                            if (nameController.text.trim().isEmpty) {
                              UIUtil.showSnackbar(
                                localizations
                                    .introNewWalletGetFirstInfosNameBlank,
                                context,
                                ref,
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
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
                                  context.go(
                                    IntroNewWalletDisclaimer.routerPage,
                                    extra: nameController.text,
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
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
