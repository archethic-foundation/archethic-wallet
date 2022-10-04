part of '../settings_drawer_wallet_mobile.dart';

class MainSettings extends StatelessWidget {
  const MainSettings({
    required this.showContacts,
    required this.showSecurity,
    required this.showCustom,
    required this.showAbout,
    super.key,
  });

  final VoidCallback showContacts;
  final VoidCallback showSecurity;
  final VoidCallback showCustom;
  final VoidCallback showAbout;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            StateContainer.of(context).curTheme.drawerBackground!,
            StateContainer.of(context).curTheme.backgroundDark00!,
          ],
          begin: Alignment.center,
          end: const Alignment(5, 0),
        ),
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            // Settings items
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: const EdgeInsets.only(top: 15),
                    children: <Widget>[
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            AppLocalization.of(context)!.manage,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      if (StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .isNativeTokenValuePositive())
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15,
                        )
                      else
                        const SizedBox(),
                      /* if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context)
                                .wallet!
                                .accountBalance
                                .networkCurrencyValue !=
                            null &&
                        StateContainer.of(context)
                                .wallet!
                                .accountBalance
                                .networkCurrencyValue! >
                            0)
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                          context,
                          AppLocalization.of(context)!.tokenHeader,
                          AppLocalization.of(context)!.tokenHeaderDesc,
                          icon: 'assets/icons/token.png',
                          iconColor: StateContainer.of(context)
                              .curTheme
                              .iconDrawer!, onPressed: () {
                        setState(() {
                          _tokenOpen = true;
                        });
                        _tokenController!.forward();
                      })
                    else
                      const SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),*/
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.addressBookHeader,
                        AppLocalization.of(context)!.addressBookDesc,
                        icon: 'assets/icons/address-book.png',
                        iconColor:
                            StateContainer.of(context).curTheme.iconDrawer,
                        onPressed: showContacts,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            AppLocalization.of(context)!.preferences,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.securityHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'assets/icons/encrypted.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: showSecurity,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.customHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'assets/icons/brush.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: showCustom,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            AppLocalization.of(context)!.informations,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.aeWebsiteLinkHeader,
                        AppLocalization.of(context)!.aeWebsiteLinkDesc,
                        icon: 'assets/icons/home.png',
                        iconColor:
                            StateContainer.of(context).curTheme.iconDrawer,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.archethic.net',
                            AppLocalization.of(context)!.aeWebsiteLinkHeader,
                          );
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.labLinkHeader,
                        AppLocalization.of(context)!.labLinkDesc,
                        icon: 'assets/icons/microscope.png',
                        iconColor:
                            StateContainer.of(context).curTheme.iconDrawer,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.archethic.net/lab.html',
                            AppLocalization.of(context)!.labLinkHeader,
                          );
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'assets/icons/help.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: showAbout,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
