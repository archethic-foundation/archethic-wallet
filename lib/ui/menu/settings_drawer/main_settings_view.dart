/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_drawer.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({
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
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            theme.drawerBackground!,
            theme.backgroundDark00!,
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
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.manage),
                      // TODO(reddwarf03): that conditional spacer seems odd.
                      if (StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .isNativeTokenValuePositive())
                        const _SettingsListItem.spacer()
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
                          localizations.tokenHeader,
                          localizations.tokenHeaderDesc,
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
                      color: theme.text15,
                    ),*/
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.addressBookHeader,
                        info: localizations.addressBookDesc,
                        icon: 'assets/icons/address-book.png',
                        iconColor: theme.iconDrawer,
                        onPressed: showContacts,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.preferences),

                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.securityHeader,
                        headingStyle: AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        icon: 'assets/icons/encrypted.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: showSecurity,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.customHeader,
                        headingStyle: AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        icon: 'assets/icons/brush.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: showCustom,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.informations),

                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.aeWebsiteLinkHeader,
                        info: localizations.aeWebsiteLinkDesc,
                        icon: 'assets/icons/home.png',
                        iconColor: theme.iconDrawer,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.archethic.net',
                            localizations.aeWebsiteLinkHeader,
                          );
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.labLinkHeader,
                        info: localizations.labLinkDesc,
                        icon: 'assets/icons/microscope.png',
                        iconColor: theme.iconDrawer,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://www.archethic.net/lab.html',
                            localizations.labLinkHeader,
                          );
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutHeader,
                        headingStyle: AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        icon: 'assets/icons/help.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: showAbout,
                      ),
                      const _SettingsListItem.spacer(),
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
