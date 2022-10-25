/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_drawer.dart';

class SettingsSheetWallet extends ConsumerStatefulWidget {
  const SettingsSheetWallet({super.key});

  @override
  ConsumerState<SettingsSheetWallet> createState() =>
      _SettingsSheetWalletMobileState();
}

class _SettingsSheetWalletMobileState extends ConsumerState<SettingsSheetWallet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _contactsController;
  late Animation<Offset> _contactsOffsetFloat;
  late AnimationController _securityController;
  late Animation<Offset> _securityOffsetFloat;
  late AnimationController _customController;
  late Animation<Offset> _customOffsetFloat;
  late AnimationController _aboutController;
  late Animation<Offset> _aboutOffsetFloat;

  late NetworksSetting _curNetworksSetting;

  late bool _securityOpen;
  late bool _customOpen;
  late bool _aboutOpen;
  late bool _contactsOpen;

  bool notNull(Object? o) => o != null;

  @override
  void initState() {
    super.initState();
    _curNetworksSetting = NetworksSetting(
      network: AvailableNetworks.archethicMainNet,
      networkDevEndpoint: ref
          .read(SettingsProviders.localSettingsRepository)
          .getNetworkDevEndpoint(),
    );

    _contactsOpen = false;
    _securityOpen = false;
    _customOpen = false;
    _aboutOpen = false;

    _contactsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _securityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _customController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _contactsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_contactsController);
    _securityOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_securityController);
    _customOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_customController);
    _aboutOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_aboutController);
  }

  @override
  void dispose() {
    _contactsController.dispose();
    _securityController.dispose();
    _customController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.detached:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.inactive:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  // TODO(reddwarf03): https://github.com/archethic-foundation/archethic-wallet/issues/116
  // ignore: unused_element
  Future<void> _networkDialog() async {
    final ns = await NetworkDialog.getDialog(
      context,
      ref,
      _curNetworksSetting,
    );
    if (ns != null) {
      _curNetworksSetting = ns;
      await StateContainer.of(context).requestUpdate();
    }
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen) {
      _contactsOpen = false;
      _contactsController.reverse();
      return false;
    } else if (_securityOpen) {
      _securityOpen = false;
      _securityController.reverse();
      return false;
    } else if (_customOpen) {
      _customOpen = false;
      _customController.reverse();
      return false;
    } else if (_aboutOpen) {
      _aboutOpen = false;
      _aboutController.reverse();
      return false;
    }
    return true;
  }

  void showContacts() {
    _contactsOpen = true;
    _contactsController.forward();
  }

  void showSecurity() {
    _securityOpen = true;
    _securityController.forward();
  }

  void showCustom() {
    _customOpen = true;
    _customController.forward();
  }

  void showAbout() {
    _aboutOpen = true;
    _aboutController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: theme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            MainMenuView(
              showContacts: showContacts,
              showSecurity: showSecurity,
              showCustom: showCustom,
              showAbout: showAbout,
            ),
            SlideTransition(
              position: _contactsOffsetFloat,
              child: ContactsList(
                _contactsController,
                _contactsOpen,
              ),
            ),
            SlideTransition(
              position: _securityOffsetFloat,
              child: SecurityMenuView(
                close: () {
                  _securityOpen = false;
                  _securityController.reverse();
                },
              ),
            ),
            SlideTransition(
              position: _customOffsetFloat,
              child: CustomizationMenuView(
                onClose: () {
                  _customOpen = false;
                  _customController.reverse();
                },
              ),
            ),
            SlideTransition(
              position: _aboutOffsetFloat,
              child: AboutMenuView(
                onClose: () {
                  _aboutOpen = false;
                  _aboutController.reverse();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
