// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/ui/menu/menu_widget_wallet.dart';
import 'package:aewallet/ui/menu/settings_drawer_wallet_mobile.dart';
import 'package:aewallet/ui/views/accounts/account_list.dart';
import 'package:aewallet/ui/views/blog/last_articles_list.dart';
import 'package:aewallet/ui/views/transactions/transaction_recent_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/bus/account_changed_event.dart';
import 'package:core/bus/disable_lock_timeout_event.dart';
import 'package:core/bus/notifications_event.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/notifications_util.dart';
import 'package:core_ui/ui/util/responsive.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/balance_infos.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/dialogs/network_dialog.dart';
import 'package:aeuniverse/ui/widgets/logo.dart';
import 'package:aeuniverse/util/preferences.dart';

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

  @override
  void initState() {
    super.initState();

    accountIsPressed = false;

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
    double heightBalance = 60;
    if (StateContainer.of(context).showBalance == false) {
      heightBalance = 0;
    }
    double heightPriceChart = MediaQuery.of(context).size.height * 0.08 + 30;
    if (StateContainer.of(context).showPriceChart == false) {
      heightPriceChart = 0;
    }
    double heightBack = MediaQuery.of(context).size.height -
        (171 + heightBalance + heightPriceChart);

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
                      /*SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 200.0,
                                left: Responsive.drawerWidth(context)),
                            child: Column(
                              children: [
                                MenuWidgetWallet().buildMenuTxExplorer(context),
                                const Expanded(child: TxListWidget()),
                              ],
                            )),
                      ),*/
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
                                  StateContainer.of(context)
                                          .curTheme
                                          .assetsFolder! +
                                      StateContainer.of(context)
                                          .curTheme
                                          .logoAlone! +
                                      '.svg',
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
            appBar: AppBar(
              actions: [
                StateContainer.of(context).activeNotifications
                    ? IconButton(
                        icon: const Icon(Icons.notifications_active_outlined),
                        onPressed: () async {
                          StateContainer.of(context).activeNotifications =
                              false;
                          if (StateContainer.of(context)
                                  .timerCheckTransactionInputs !=
                              null) {
                            StateContainer.of(context)
                                .timerCheckTransactionInputs!
                                .cancel();
                          }
                          final Preferences preferences =
                              await Preferences.getInstance();
                          await preferences.setActiveNotifications(false);
                        })
                    : IconButton(
                        icon: const Icon(Icons.notifications_off_outlined),
                        onPressed: () async {
                          StateContainer.of(context).activeNotifications = true;

                          if (StateContainer.of(context)
                                  .timerCheckTransactionInputs !=
                              null) {
                            StateContainer.of(context)
                                .timerCheckTransactionInputs!
                                .cancel();
                          }
                          StateContainer.of(context).checkTransactionInputs(
                              AppLocalization.of(context)!
                                  .transactionInputNotification);
                          final Preferences preferences =
                              await Preferences.getInstance();
                          await preferences.setActiveNotifications(true);
                        })
              ],
              title: InkWell(
                onTap: () async {
                  // await _networkDialog();
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      StateContainer.of(context).curTheme.assetsFolder! +
                          StateContainer.of(context).curTheme.logoAlone! +
                          '.svg',
                      height: 30,
                    ),
                    Text(
                        StateContainer.of(context)
                            .curNetwork
                            .getDisplayName(context),
                        style: AppStyles.textStyleSize10W100Primary(context)),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: StateContainer.of(context).curTheme.text),
            ),
            drawerEdgeDragWidth: 0,
            resizeToAvoidBottomInset: false,
            backgroundColor: StateContainer.of(context).curTheme.background,
            drawer: SizedBox(
              width: Responsive.drawerWidth(context),
              child: const Drawer(
                // TODO: dependencies issue
                child: SettingsSheetWalletMobile(),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 120.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        StateContainer.of(context).curTheme.backgroundMainTop!,
                        StateContainer.of(context)
                            .curTheme
                            .backgroundMainBottom!
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            child: InkWell(
                              onTap: () async {
                                if (accountIsPressed == false) {
                                  setState(() {
                                    accountIsPressed = true;
                                  });
                                  sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      StateContainer.of(context)
                                          .activeVibrations);
                                  Sheets.showAppHeightNineSheet(
                                      context: context,
                                      widget: AccountsListWidget(
                                          appWallet: StateContainer.of(context)
                                              .appWallet,
                                          currencyName:
                                              StateContainer.of(context)
                                                  .curCurrency
                                                  .currency
                                                  .name,
                                          seed: await StateContainer.of(context)
                                              .getSeed()));
                                  setState(() {
                                    accountIsPressed = false;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  StateContainer.of(context)
                                              .appWallet!
                                              .appKeychain!
                                              .getAccountSelected()!
                                              .name !=
                                          null
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  StateContainer.of(context)
                                                      .appWallet!
                                                      .appKeychain!
                                                      .getAccountSelected()!
                                                      .name!,
                                                  style: AppStyles
                                                      .textStyleSize20W700EquinoxPrimary(
                                                          context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StateContainer.of(context).showBalance
                              ? BalanceInfosWidget().getBalance(context)
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          StateContainer.of(context).showPriceChart
                              ? Stack(
                                  children: <Widget>[
                                    BalanceInfosWidget().buildInfos(context),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                      StateContainer.of(context).showPriceChart
                          ? BalanceInfosWidget().buildKPI(context)
                          : const SizedBox(),
                      Divider(
                        height: 1,
                        color: StateContainer.of(context).curTheme.text30,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor:
                        StateContainer.of(context).curTheme.backgroundDark,
                    onRefresh: () => Future<void>.sync(() {
                      sl.get<HapticUtil>().feedback(FeedbackType.light,
                          StateContainer.of(context).activeVibrations);
                      StateContainer.of(context).requestUpdate();
                    }),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: heightBack,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          StateContainer.of(context)
                                              .curTheme
                                              .background4Small!),
                                      fit: BoxFit.none,
                                      opacity: 0.8),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          MenuWidgetWallet()
                                              .buildMainMenuIcons(context),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const TxListWidget(),
                                          const LastArticlesWidget(),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
