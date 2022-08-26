// ignore_for_file: cancel_subscriptions, prefer_const_constructors

// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:ui';

// Flutter imports:
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection.dart';
import 'package:aewallet/ui/views/nft/collections_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/account_changed_event.dart';
import 'package:aewallet/bus/disable_lock_timeout_event.dart';
import 'package:aewallet/bus/notifications_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/menu/menu_widget_wallet.dart';
import 'package:aewallet/ui/menu/settings_drawer_wallet_mobile.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/accounts/account_list.dart';
import 'package:aewallet/ui/views/blog/last_articles_list.dart';
import 'package:aewallet/ui/views/tokens_fungibles/add_token.dart';
import 'package:aewallet/ui/views/tokens_fungibles/fungibles_tokens_list.dart';
import 'package:aewallet/ui/views/transactions/transaction_recent_list.dart';
import 'package:aewallet/ui/widgets/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:aewallet/ui/widgets/logo.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:aewallet/util/preferences.dart';

class AppHomePageUniverse extends StatefulWidget {
  const AppHomePageUniverse({super.key});

  @override
  State<AppHomePageUniverse> createState() => _AppHomePageUniverseState();
}

class _AppHomePageUniverseState extends State<AppHomePageUniverse>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  AnimationController? _placeholderCardAnimationController;
  Animation<double>? _opacityAnimation;
  bool? _animationDisposed;

  bool _lockDisabled = false; // whether we should avoid locking the app

  bool? accountIsPressed;

  AnimationController? animationController;
  ColorTween? colorTween;
  CurvedAnimation? curvedAnimation;

  TabController? tabController;

  @override
  void initState() {
    super.initState();

    accountIsPressed = false;
    tabController = TabController(length: 2, vsync: this);

    _registerBus();
    WidgetsBinding.instance.addObserver(this);

    NotificationsUtil.init();
    listenNotifications();

    // Setup placeholder animation and start
    _animationDisposed = false;
    _placeholderCardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _placeholderCardAnimationController!
        .addListener(_animationControllerListener);
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _placeholderCardAnimationController!,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _opacityAnimation!.addStatusListener(_animationStatusListener);
    _placeholderCardAnimationController!.forward();
  }

  listenNotifications() =>
      NotificationsUtil.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    EventTaxiImpl.singleton().fire(NotificationsEvent(payload: payload));
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _placeholderCardAnimationController!.forward();
        break;
      case AnimationStatus.completed:
        _placeholderCardAnimationController!.reverse();
        break;
      default:
        break;
    }
  }

  void _animationControllerListener() {
    setState(() {});
  }

  void _startAnimation() {
    if (_animationDisposed!) {
      _animationDisposed = false;
      _placeholderCardAnimationController!
          .addListener(_animationControllerListener);
      _opacityAnimation!.addStatusListener(_animationStatusListener);
      _placeholderCardAnimationController!.forward();
    }
  }

  void _disposeAnimation() {
    if (!_animationDisposed!) {
      _animationDisposed = true;
      _opacityAnimation!.removeStatusListener(_animationStatusListener);
      _placeholderCardAnimationController!
          .removeListener(_animationControllerListener);
      _placeholderCardAnimationController!.stop();
    }
  }

  StreamSubscription<DisableLockTimeoutEvent>? _disableLockSub;
  StreamSubscription<AccountChangedEvent>? _switchAccountSub;
  StreamSubscription<NotificationsEvent>? _notificationsSub;

  void _registerBus() {
    // Hackish event to block auto-lock functionality
    _disableLockSub = EventTaxiImpl.singleton()
        .registerTo<DisableLockTimeoutEvent>()
        .listen((DisableLockTimeoutEvent event) {
      if (event.disable!) {
        cancelLockEvent();
      }
      _lockDisabled = event.disable!;
    });
    // User changed account
    _switchAccountSub = EventTaxiImpl.singleton()
        .registerTo<AccountChangedEvent>()
        .listen((AccountChangedEvent event) {
      setState(() {
        StateContainer.of(context).recentTransactionsLoading = true;

        _startAnimation();

        StateContainer.of(context).requestUpdate();
        _disposeAnimation();

        StateContainer.of(context).recentTransactionsLoading = false;
      });

      if (event.delayPop) {
        Future<void>.delayed(const Duration(milliseconds: 300), () {
          Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        });
      } else if (!event.noPop) {
        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
      }
    });

    _notificationsSub = EventTaxiImpl.singleton()
        .registerTo<NotificationsEvent>()
        .listen((NotificationsEvent event) async {
      StateContainer.of(context).recentTransactionsLoading = true;

      await StateContainer.of(context).requestUpdate();

      StateContainer.of(context).recentTransactionsLoading = false;
      Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
    });
  }

  @override
  void dispose() {
    _destroyBus();
    WidgetsBinding.instance.removeObserver(this);
    tabController!.dispose();
    _placeholderCardAnimationController!.dispose();
    super.dispose();
  }

  void _destroyBus() {
    if (_disableLockSub != null) {
      _disableLockSub!.cancel();
    }
    if (_switchAccountSub != null) {
      _switchAccountSub!.cancel();
    }
    if (_notificationsSub != null) {
      _notificationsSub!.cancel();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle websocket connection when app is in background
    // terminate it to be eco-friendly
    switch (state) {
      case AppLifecycleState.paused:
        setAppLockEvent();
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        cancelLockEvent();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  // To lock and unlock the app
  StreamSubscription<dynamic>? lockStreamListener;

  Future<void> setAppLockEvent() async {
    final Preferences preferences = await Preferences.getInstance();
    if ((preferences.getLock()) && !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener!.cancel();
      }
      final Future<dynamic> delayed =
          Future<void>.delayed((preferences.getLockTimeout()).getDuration());
      delayed.then((_) {
        return true;
      });
      lockStreamListener = delayed.asStream().listen((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    }
  }

  Future<void> cancelLockEvent() async {
    if (lockStreamListener != null) {
      lockStreamListener!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) == true
        ? Scaffold(
            extendBodyBehindAppBar: true,
            drawerEdgeDragWidth: 0,
            resizeToAvoidBottomInset: false,
            backgroundColor: StateContainer.of(context).curTheme.background,
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      StateContainer.of(context).curTheme.backgroundMainTop!,
                      StateContainer.of(context).curTheme.backgroundMainBottom!
                    ],
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(StateContainer.of(context)
                                  .curTheme
                                  .background4Small!),
                              fit: BoxFit.none,
                              opacity: 0.8),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.drawerWidth(context),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              getLogo(context),
                              const SizedBox(height: 20),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: AutoSizeText(
                                        StateContainer.of(context)
                                            .curNetwork
                                            .getNetworkCryptoCurrencyLabel(),
                                        style: AppStyles
                                            .textStyleSize80W700Primary15(
                                                context),
                                      ),
                                    ),
                                  ),
                                  BalanceInfosWidget().buildInfos(context),
                                ],
                              ),
                              BalanceInfosWidget().buildKPI(context),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 180.0,
                          ),
                          child: MenuWidgetWallet().buildContextMenu(context),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // await _networkDialog();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                left: Responsive.drawerWidth(context)),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                  height: 30,
                                ),
                                Text(
                                    StateContainer.of(context)
                                        .curNetwork
                                        .getDisplayName(context),
                                    style: AppStyles.textStyleSize10W100Primary(
                                        context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 70.0,
                                left: Responsive.drawerWidth(context)),
                            child:
                                MenuWidgetWallet().buildMainMenuIcons(context)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: MenuWidgetWallet()
                                .buildSecondMenuIcons(context)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 50),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    actions: [
                      StateContainer.of(context).showBalance
                          ? IconButton(
                              icon: const FaIcon(FontAwesomeIcons.eye),
                              onPressed: () async {
                                StateContainer.of(context).showBalance = false;

                                final Preferences preferences =
                                    await Preferences.getInstance();
                                await preferences.setShowBalances(false);
                              })
                          : IconButton(
                              icon: const FaIcon(FontAwesomeIcons.eyeLowVision),
                              onPressed: () async {
                                StateContainer.of(context).showBalance = true;

                                final Preferences preferences =
                                    await Preferences.getInstance();
                                await preferences.setShowBalances(true);
                              }),
                      if (!kIsWeb &&
                          (Platform.isIOS == true ||
                              Platform.isAndroid == true ||
                              Platform.isMacOS == true))
                        StateContainer.of(context).activeNotifications
                            ? IconButton(
                                icon: const Icon(
                                    Icons.notifications_active_outlined),
                                onPressed: () async {
                                  StateContainer.of(context)
                                      .activeNotifications = false;
                                  if (StateContainer.of(context)
                                          .timerCheckTransactionInputs !=
                                      null) {
                                    StateContainer.of(context)
                                        .timerCheckTransactionInputs!
                                        .cancel();
                                  }
                                  final Preferences preferences =
                                      await Preferences.getInstance();
                                  await preferences
                                      .setActiveNotifications(false);
                                })
                            : IconButton(
                                icon: const Icon(
                                    Icons.notifications_off_outlined),
                                onPressed: () async {
                                  StateContainer.of(context)
                                      .activeNotifications = true;

                                  if (StateContainer.of(context)
                                          .timerCheckTransactionInputs !=
                                      null) {
                                    StateContainer.of(context)
                                        .timerCheckTransactionInputs!
                                        .cancel();
                                  }
                                  StateContainer.of(context)
                                      .checkTransactionInputs(
                                          AppLocalization.of(context)!
                                              .transactionInputNotification);
                                  final Preferences preferences =
                                      await Preferences.getInstance();
                                  await preferences
                                      .setActiveNotifications(true);
                                })
                    ],
                    title: StateContainer.of(context).bottomBarCurrentPage == 0
                        ? InkWell(
                            onTap: () {
                              sl.get<HapticUtil>().feedback(FeedbackType.light,
                                  StateContainer.of(context).activeVibrations);
                              Clipboard.setData(ClipboardData(
                                  text: StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .address!
                                      .toUpperCase()));
                              UIUtil.showSnackbar(
                                  AppLocalization.of(context)!.addressCopied,
                                  context,
                                  StateContainer.of(context).curTheme.text!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .snackBarShadow!);
                            },
                            child: AutoSizeText(
                              AppLocalization.of(context)!.keychainHeader,
                              style:
                                  AppStyles.textStyleSize24W700EquinoxPrimary(
                                      context),
                            ),
                          )
                        : StateContainer.of(context).bottomBarCurrentPage == 1
                            ? FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .name!,
                                  style: AppStyles
                                      .textStyleSize24W700EquinoxPrimary(
                                          context),
                                ),
                              )
                            : AutoSizeText(
                                'Collection',
                                style:
                                    AppStyles.textStyleSize24W700EquinoxPrimary(
                                        context),
                              ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                    iconTheme: IconThemeData(
                        color: StateContainer.of(context).curTheme.text),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 22),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: BottomBar(
                    selectedIndex:
                        StateContainer.of(context).bottomBarCurrentPage,
                    onTap: (int index) {
                      StateContainer.of(context)
                          .bottomBarPageController!
                          .jumpToPage(index);
                      setState(() => StateContainer.of(context)
                          .bottomBarCurrentPage = index);
                    },
                    items: <BottomBarItem>[
                      BottomBarItem(
                          icon: const FaIcon(FontAwesomeIcons.keycdn),
                          backgroundColorOpacity: StateContainer.of(context)
                              .curTheme
                              .bottomBarBackgroundColorOpacity!,
                          activeIconColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveIconColor!,
                          activeTitleColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveTitleColor!,
                          activeColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveColor!,
                          inactiveColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarInactiveIcon!),
                      BottomBarItem(
                          icon: const Icon(Icons.account_circle),
                          backgroundColorOpacity: StateContainer.of(context)
                              .curTheme
                              .bottomBarBackgroundColorOpacity!,
                          activeIconColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveIconColor!,
                          activeTitleColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveTitleColor!,
                          activeColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveColor!,
                          inactiveColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarInactiveIcon!),
                      /*BottomBarItem(
                          icon: const Icon(Icons.collections_bookmark),
                          backgroundColorOpacity: StateContainer.of(context)
                              .curTheme
                              .bottomBarBackgroundColorOpacity!,
                          activeIconColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveIconColor!,
                          activeTitleColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveTitleColor!,
                          activeColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarActiveColor!,
                          inactiveColor: StateContainer.of(context)
                              .curTheme
                              .bottomBarInactiveIcon!),*/
                    ],
                  ),
                ),
              ),
            ),
            drawerEdgeDragWidth: 0,
            resizeToAvoidBottomInset: false,
            backgroundColor: StateContainer.of(context).curTheme.background,
            drawer: SizedBox(
              width: Responsive.drawerWidth(context),
              child: const Drawer(
                child: SettingsSheetWalletMobile(),
              ),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: StateContainer.of(context).bottomBarPageController,
              children: [
                Column(
                  children: [
                    Expanded(
                      /// REFRESH
                      child: RefreshIndicator(
                        backgroundColor:
                            StateContainer.of(context).curTheme.backgroundDark,
                        onRefresh: () => Future<void>.sync(() async {
                          sl.get<HapticUtil>().feedback(FeedbackType.light,
                              StateContainer.of(context).activeVibrations);
                          StateContainer.of(context).appWallet =
                              await KeychainUtil().getListAccountsFromKeychain(
                                  StateContainer.of(context).appWallet,
                                  await StateContainer.of(context).getSeed(),
                                  StateContainer.of(context)
                                      .curCurrency
                                      .currency
                                      .name,
                                  StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .balance!
                                      .nativeTokenName!,
                                  StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .balance!
                                      .tokenPrice!,
                                  currentName: StateContainer.of(context)
                                      .appWallet!
                                      .appKeychain!
                                      .getAccountSelected()!
                                      .name);
                          setState(() {});
                        }),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: Column(
                            children: <Widget>[
                              /// BACKGROUND IMAGE
                              Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          StateContainer.of(context)
                                              .curTheme
                                              .background1Small!),
                                      fit: BoxFit.fitHeight,
                                      opacity: 0.7),
                                ),
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: kToolbarHeight + kTextTabBarHeight,
                                        bottom: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        /// ACCOUNTS LIST
                                        AccountsListWidget(
                                          appWallet: StateContainer.of(context)
                                              .appWallet,
                                          currencyName:
                                              StateContainer.of(context)
                                                  .curCurrency
                                                  .currency
                                                  .name,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      /// REFRESH
                      child: RefreshIndicator(
                        backgroundColor:
                            StateContainer.of(context).curTheme.backgroundDark,
                        onRefresh: () => Future<void>.sync(() {
                          sl.get<HapticUtil>().feedback(FeedbackType.light,
                              StateContainer.of(context).activeVibrations);
                          StateContainer.of(context).requestUpdate();
                        }),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: Column(
                            children: <Widget>[
                              /// BACKGROUND IMAGE
                              Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          StateContainer.of(context)
                                              .curTheme
                                              .background2Small!),
                                      fit: BoxFit.fitHeight,
                                      opacity: 0.7),
                                ),
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: kToolbarHeight + kTextTabBarHeight,
                                        bottom: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        /// BALANCE
                                        BalanceInfosWidget()
                                            .getBalance(context),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        /// PRICE CHART
                                        StateContainer.of(context)
                                                .showPriceChart
                                            ? Stack(
                                                children: <Widget>[
                                                  BalanceInfosWidget()
                                                      .buildInfos(context),
                                                ],
                                              )
                                            : const SizedBox(),

                                        /// KPI
                                        StateContainer.of(context)
                                                .showPriceChart
                                            ? BalanceInfosWidget()
                                                .buildKPI(context)
                                            : const SizedBox(),

                                        Divider(
                                          height: 1,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .backgroundDarkest!
                                              .withOpacity(0.1),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        /// ICONS
                                        MenuWidgetWallet()
                                            .buildMainMenuIcons(context),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          height: 1,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .backgroundDarkest!
                                              .withOpacity(0.1),
                                        ),
                                        ExpandablePageView(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            TxListWidget(),
                                            FungiblesTokensListWidget(),
                                          ],
                                        ),

                                        /// BLOG
                                        LastArticlesWidget(),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                /*Column(
                  children: [
                    Expanded(
                      /// REFRESH
                      child: RefreshIndicator(
                        backgroundColor:
                            StateContainer.of(context).curTheme.backgroundDark,
                        onRefresh: () => Future<void>.sync(() async {
                          // TODO
                        }),
                        child: Column(
                          children: <Widget>[
                            /// BACKGROUND IMAGE
                            Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(StateContainer.of(context)
                                        .curTheme
                                        .background1Small!),
                                    fit: BoxFit.fitHeight,
                                    opacity: 0.7),
                              ),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: kToolbarHeight + kTextTabBarHeight,
                                      bottom: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      /// COLLECTION
                                      CollectionsListWidget(
                                        appWallet: StateContainer.of(context)
                                            .appWallet,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),*/
              ],
              onPageChanged: (index) {
                setState(() =>
                    StateContainer.of(context).bottomBarCurrentPage = index);
              },
            ),
          );
  }

  Future<void> _networkDialog() async {
    StateContainer.of(context).curNetwork = (await NetworkDialog.getDialog(
        context, StateContainer.of(context).curNetwork))!;
    await StateContainer.of(context).requestUpdate();
    setState(() {});
  }
}

class ExpandablePageView extends StatefulWidget {
  final List<Widget>? children;

  const ExpandablePageView({
    super.key,
    @required this.children,
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  PageController? _pageController;
  List<double>? _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights![_currentPage];

  @override
  void initState() {
    _heights = widget.children!.map((e) => 0.0).toList();
    super.initState();
    _pageController = PageController() //
      ..addListener(() {
        final newPage = _pageController!.page!.round();
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
                indicatorColor:
                    StateContainer.of(context).curTheme.backgroundDarkest),
            tabs: [
              Text(AppLocalization.of(context)!.recentTransactionsHeader,
                  style: AppStyles.textStyleSize14W600EquinoxPrimary(context)),
              Text(AppLocalization.of(context)!.tokensHeader,
                  style: AppStyles.textStyleSize14W600EquinoxPrimary(context)),
            ],
            // ignore: prefer_const_literals_to_create_immutables
            views: [
              const SizedBox(
                height: 0,
              ),
              const SizedBox(
                height: 0,
              )
            ],
            onChange: (index) {
              _pageController!.jumpToPage(index);
            },
          ),
        ),
        TweenAnimationBuilder<double>(
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 100),
          tween: Tween<double>(begin: _heights![0], end: _currentHeight),
          builder: (context, value, child) =>
              SizedBox(height: value, child: child),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _sizeReportingChildren
                .asMap() //
                .map((index, child) => MapEntry(index, child))
                .values
                .toList(),
          ),
        ),
        if (_currentPage == 1)
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10, left: 0, right: 0),
            child: Row(
              children: <Widget>[
                AppButton.buildAppButtonTiny(
                    const Key('createTokenFungible'),
                    context,
                    AppButtonType.primary,
                    AppLocalization.of(context)!.createFungibleToken,
                    Dimens.buttonBottomDimens, onPressed: () {
                  Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: AddTokenSheet(
                        primaryCurrency:
                            StateContainer.of(context).curPrimaryCurrency,
                      ));
                }),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children!
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights![index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}
