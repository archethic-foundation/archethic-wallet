// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/ui/widgets/balance_infos.dart';
import 'package:aewallet/ui/widgets/menu/menu_widget_wallet.dart';
import 'package:aewallet/ui/widgets/menu/settings_drawer_wallet.dart';
import 'package:aewallet/ui/widgets/transaction_recent_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/appstate_container.dart';
import 'package:core/bus/account_changed_event.dart';
import 'package:core/bus/disable_lock_timeout_event.dart';
import 'package:core/localization.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/ui/util/routes.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/util/ui_util.dart';
import 'package:core/ui/widgets/logo.dart';
import 'package:core/util/app_util.dart';
import 'package:core/util/preferences.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import '../widgets/menu/menu_widget_bin.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({Key? key}) : super(key: key);

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller for placeholder card animations
  AnimationController? _placeholderCardAnimationController;
  Animation<double>? _opacityAnimation;
  bool? _animationDisposed;

  bool _lockDisabled = false; // whether we should avoid locking the app

  ScrollController? _scrollController;

  AnimationController? animationController;
  ColorTween? colorTween;
  CurvedAnimation? curvedAnimation;

  @override
  void initState() {
    super.initState();

    _registerBus();
    WidgetsBinding.instance!.addObserver(this);

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

    _scrollController = ScrollController();
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

        StateContainer.of(context).requestUpdate(account: event.account);
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
  }

  @override
  void dispose() {
    _destroyBus();
    WidgetsBinding.instance!.removeObserver(this);
    _placeholderCardAnimationController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  void _destroyBus() {
    if (_disableLockSub != null) {
      _disableLockSub!.cancel();
    }
    if (_switchAccountSub != null) {
      _switchAccountSub!.cancel();
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
    final Preferences _preferences = await Preferences.getInstance();
    if ((_preferences.getLock()) && !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener!.cancel();
      }
      final Future<dynamic> delayed =
          Future<void>.delayed((_preferences.getLockTimeout()).getDuration());
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
    return AppUtil.isDesktopMode() == true
        ? Scaffold(
            extendBodyBehindAppBar: true,
            drawerEdgeDragWidth: 0,
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            backgroundColor: StateContainer.of(context).curTheme.background,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      StateContainer.of(context).curTheme.backgroundDark!,
                      StateContainer.of(context).curTheme.background!
                    ],
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      StateContainer.of(context)
                          .curTheme
                          .getBackgroundScreen(context)!,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
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
                                        'UCO',
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
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 180.0),
                          child: StateContainer.of(context).currentAEApp ==
                                  AEApps.bin
                              ? MenuWidgetBin().buildContextMenu(context)
                              : StateContainer.of(context).currentAEApp ==
                                      AEApps.aewallet
                                  ? MenuWidgetWallet().buildContextMenu(context)
                                  : const SizedBox(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: StateContainer.of(context).currentAEApp ==
                                    AEApps.bin
                                ? MenuWidgetBin().buildMainMenuIcons(context)
                                : MenuWidgetWallet()
                                    .buildMainMenuIcons(context)),
                      ),
                      StateContainer.of(context).currentAEApp == AEApps.bin
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: MenuWidgetBin()
                                      .buildSecondMenuIcons(context)),
                            )
                          : StateContainer.of(context).currentAEApp ==
                                  AEApps.aewallet
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: MenuWidgetWallet()
                                          .buildSecondMenuIcons(context)),
                                )
                              : const SizedBox(),
                      StateContainer.of(context).currentAEApp == AEApps.aewallet
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 150.0,
                                    left: MediaQuery.of(context).size.width *
                                        0.2),
                                child: Column(
                                  children: [
                                    MenuWidgetWallet()
                                        .buildMenuTxExplorer(context),
                                    Divider(
                                      height: 15,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary30,
                                    ),
                                    const Expanded(
                                      child: TxListWidget(),
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
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: SvgPicture.asset(
                  StateContainer.of(context).curTheme.assetsFolder! +
                      StateContainer.of(context).curTheme.logoAlone! +
                      '.svg',
                  height: 40),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              actions: <Widget>[
                Text(AppLocalization.of(context)!.environment,
                    style: TextStyle(
                        color: Colors.red[900], fontWeight: FontWeight.w900)),
                const SizedBox(width: 20),
              ],
              iconTheme: IconThemeData(
                  color: StateContainer.of(context).curTheme.primary),
            ),
            drawerEdgeDragWidth: 0,
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            backgroundColor: StateContainer.of(context).curTheme.background,
            drawer: SizedBox(
              width: UIUtil.drawerWidth(context),
              child: const Drawer(
                // TODO: dependencies issue
                child: SettingsSheetWallet(),
              ),
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      StateContainer.of(context).curTheme.backgroundDark!,
                      StateContainer.of(context).curTheme.background!
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: AutoSizeText(
                                    'UCO',
                                    style:
                                        AppStyles.textStyleSize80W700Primary15(
                                            context),
                                  ),
                                ),
                              ),
                              BalanceInfosWidget().buildInfos(context),
                            ],
                          ),
                        ],
                      ),
                      BalanceInfosWidget().buildKPI(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            kBottomNavigationBarHeight,
                        child: Stack(
                          children: <Widget>[
                            StateContainer.of(context)
                                .curTheme
                                .getBackgroundScreen(context)!,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Divider(
                                  height: 1,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                MenuWidgetWallet().buildMainMenuIcons(context),
                                Divider(
                                  height: 15,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                ),
                                MenuWidgetWallet().buildMenuTxExplorer(context),
                                Divider(
                                  height: 15,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                ),
                                const Expanded(
                                  child: TxListWidget(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
