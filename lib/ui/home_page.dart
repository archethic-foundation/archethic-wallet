// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:archethic_wallet/model/chart_infos.dart';
import 'package:archethic_wallet/ui/widgets/chart_sheet.dart';
import 'package:archethic_wallet/ui/widgets/receive_sheet.dart';
import 'package:archethic_wallet/ui/widgets/transaction_chain_explorer_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/bus/events.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/settings/settings_drawer.dart';
import 'package:archethic_wallet/ui/transfer/transfer_uco_sheet.dart';
import 'package:archethic_wallet/ui/util/routes.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/widgets/balance_infos.dart';
import 'package:archethic_wallet/ui/widgets/buy_sheet.dart';
import 'package:archethic_wallet/ui/widgets/dialog.dart';
import 'package:archethic_wallet/ui/widgets/icon_widget.dart';
import 'package:archethic_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_wallet/ui/widgets/tx_list.dart';
import 'package:archethic_wallet/util/caseconverter.dart';
import 'package:archethic_wallet/util/sharedprefsutil.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage() : super();

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

  bool? _displayReleaseNote;

  bool _lockDisabled = false; // whether we should avoid locking the app

  ScrollController? _scrollController;

  AnimationController? animationController;
  ColorTween? colorTween;
  CurvedAnimation? curvedAnimation;

  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  Future<void> _checkVersionApp() async {
    final String versionAppCached =
        await sl.get<SharedPrefsUtil>().getVersionApp();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      if (versionAppCached != packageInfo.version) {
        // TODO
        _displayReleaseNote = false;
      } else {
        _displayReleaseNote = false;
      }
    });
  }

  Future<void> _checkUsb() async {
    if (kIsWeb) {}
  }

  @override
  void initState() {
    super.initState();

    _displayReleaseNote = false;
    _checkVersionApp();
    _checkUsb();
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
    if (((await sl.get<SharedPrefsUtil>().getLock()) ||
            StateContainer.of(context).encryptedSecret != null) &&
        !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener!.cancel();
      }
      final Future<dynamic> delayed = Future<void>.delayed(
          (await sl.get<SharedPrefsUtil>().getLockTimeout()).getDuration());
      delayed.then((_) {
        return true;
      });
      lockStreamListener = delayed.asStream().listen((_) {
        try {
          StateContainer.of(context).resetEncryptedSecret();
        } catch (e) {
          print(
              'Failed to reset encrypted secret when locking ${e.toString()}');
        } finally {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }
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
    if (_displayReleaseNote!)
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => displayReleaseNote());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
            child: kIsWeb
                ? Image.asset(
                    StateContainer.of(context).curTheme.assetsFolder! +
                        StateContainer.of(context).curTheme.logoAlone! +
                        '.png',
                    height: 40,
                  )
                : SvgPicture.asset(
                    StateContainer.of(context).curTheme.assetsFolder! +
                        StateContainer.of(context).curTheme.logoAlone! +
                        '.svg',
                    height: 40,
                  )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          Text(AppLocalization.of(context)!.environment,
              style: TextStyle(
                  color: Colors.red[900], fontWeight: FontWeight.w900)),
          const SizedBox(width: 20),
        ],
        iconTheme:
            IconThemeData(color: StateContainer.of(context).curTheme.primary),
      ),
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.background,
      drawer: SizedBox(
        width: UIUtil.drawerWidth(context),
        child: Drawer(
          child: SettingsSheet(),
        ),
      ),
      body: Container(
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
              BalanceInfosWidget().buildInfos(context),
              if (StateContainer.of(context).chartInfos != null &&
                  StateContainer.of(context).chartInfos!.data != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 0.0, left: 10.0, top: 5.0, bottom: 0.0),
                    child: StateContainer.of(context)
                                .chartInfos!
                                .getPriceChangePercentage(
                                    StateContainer.of(context)
                                        .idChartOption!)! >=
                            0
                        ? Row(
                            children: <Widget>[
                              AutoSizeText(
                                  StateContainer.of(context)
                                      .wallet!
                                      .getLocalCurrencyPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!),
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleSize12W100Primary(
                                      context)),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                StateContainer.of(context)
                                            .wallet!
                                            .accountBalance
                                            .uco ==
                                        0
                                    ? '1 UCO = ' +
                                        StateContainer.of(context)
                                            .localWallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!)
                                    : '1 UCO = ' +
                                        StateContainer.of(context)
                                            .wallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                StateContainer.of(context)
                                        .chartInfos!
                                        .getPriceChangePercentage(
                                            StateContainer.of(context)
                                                .idChartOption!)!
                                        .toStringAsFixed(2) +
                                    '%',
                                style:
                                    AppStyles.textStyleSize12W100PositiveValue(
                                        context),
                              ),
                              const SizedBox(width: 5),
                              FaIcon(FontAwesomeIcons.caretUp,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .positiveValue),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                ChartInfos.getChartOptionLabel(context,
                                    StateContainer.of(context).idChartOption!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text(
                                StateContainer.of(context)
                                            .wallet!
                                            .accountBalance
                                            .uco ==
                                        0
                                    ? '1 UCO = ' +
                                        StateContainer.of(context)
                                            .localWallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!)
                                    : '1 UCO = ' +
                                        StateContainer.of(context)
                                            .wallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                StateContainer.of(context)
                                        .chartInfos!
                                        .getPriceChangePercentage(
                                            StateContainer.of(context)
                                                .idChartOption!)!
                                        .toStringAsFixed(2) +
                                    '%',
                                style:
                                    AppStyles.textStyleSize12W100NegativeValue(
                                        context),
                              ),
                              const SizedBox(width: 5),
                              FaIcon(FontAwesomeIcons.caretDown,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .negativeValue),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                ChartInfos.getChartOptionLabel(context,
                                    StateContainer.of(context).idChartOption!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                            ],
                          ),
                  ),
                )
              else
                const SizedBox(),
              Divider(
                color: StateContainer.of(context).curTheme.primary30,
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height * 0.08) -
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: InkWell(
                                    onTap: () {
                                      Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: TransferUcoSheet(
                                              contactsRef:
                                                  StateContainer.of(context)
                                                      .contactsRef,
                                              title:
                                                  AppLocalization.of(context)!
                                                      .transferUCO,
                                              localCurrency:
                                                  StateContainer.of(context)
                                                      .curCurrency));
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        buildIconDataWidget(
                                            context,
                                            Icons.arrow_circle_up_outlined,
                                            50,
                                            50),
                                        const SizedBox(height: 5),
                                        Text(AppLocalization.of(context)!.send,
                                            style: AppStyles
                                                .textStyleSize14W600Primary(
                                                    context)),
                                      ],
                                    ))),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  Sheets.showAppHeightNineSheet(
                                      context: context,
                                      widget: const ReceiveSheet());
                                },
                                child: Column(
                                  children: <Widget>[
                                    buildIconDataWidget(
                                        context,
                                        Icons.arrow_circle_down_outlined,
                                        50,
                                        50),
                                    const SizedBox(height: 5),
                                    Text(AppLocalization.of(context)!.receive,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                child: InkWell(
                                    onTap: () {
                                      Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: const BuySheet());
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        buildIconDataWidget(
                                            context,
                                            Icons.add_circle_outline_outlined,
                                            50,
                                            50),
                                        const SizedBox(height: 5),
                                        Text(AppLocalization.of(context)!.buy,
                                            style: AppStyles
                                                .textStyleSize14W600Primary(
                                                    context)),
                                      ],
                                    ))),
                            Container(
                                child: InkWell(
                                    onTap: () {
                                      optionChartList = <OptionChart>[
                                        OptionChart(
                                            '24h',
                                            ChartInfos.getChartOptionLabel(
                                                context, '24h')),
                                        OptionChart(
                                            '7d',
                                            ChartInfos.getChartOptionLabel(
                                                context, '7d')),
                                        OptionChart(
                                            '14d',
                                            ChartInfos.getChartOptionLabel(
                                                context, '14d')),
                                        OptionChart(
                                            '30d',
                                            ChartInfos.getChartOptionLabel(
                                                context, '30d')),
                                        OptionChart(
                                            '60d',
                                            ChartInfos.getChartOptionLabel(
                                                context, '60d')),
                                        OptionChart(
                                            '200d',
                                            ChartInfos.getChartOptionLabel(
                                                context, '200d')),
                                        OptionChart(
                                            '1y',
                                            ChartInfos.getChartOptionLabel(
                                                context, '1y')),
                                      ];
                                      final OptionChart? optionChart;
                                      String _idChartOption =
                                          StateContainer.of(context)
                                              .idChartOption!;
                                      switch (_idChartOption) {
                                        case '7d':
                                          optionChart = optionChartList[1];
                                          break;
                                        case '14d':
                                          optionChart = optionChartList[2];
                                          break;
                                        case '30d':
                                          optionChart = optionChartList[3];
                                          break;
                                        case '60d':
                                          optionChart = optionChartList[4];
                                          break;
                                        case '200d':
                                          optionChart = optionChartList[5];
                                          break;
                                        case '1y':
                                          optionChart = optionChartList[6];
                                          break;
                                        case '24h':
                                        default:
                                          optionChart = optionChartList[0];
                                          break;
                                      }
                                      Sheets.showAppHeightNineSheet(
                                          context: context,
                                          widget: ChartSheet(
                                            optionChartList: optionChartList,
                                            optionChart: optionChart,
                                          ));
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        buildIconDataWidget(
                                            context, Icons.show_chart, 50, 50),
                                        const SizedBox(height: 5),
                                        Text(AppLocalization.of(context)!.chart,
                                            style: AppStyles
                                                .textStyleSize14W600Primary(
                                                    context)),
                                      ],
                                    ))),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: StateContainer.of(context).curTheme.primary30,
                        ),
                        InkWell(
                          onTap: () {
                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: const TransactionChainExplorerSheet());
                          },
                          child: Ink(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          AppLocalization.of(context)!
                                              .transactionChainExplorerHeader,
                                          style: AppStyles
                                              .textStyleSize16W700Primary(
                                                  context)),
                                      Text(
                                          AppLocalization.of(context)!
                                              .transactionChainExplorerDesc,
                                          style: AppStyles
                                              .textStyleSize12W100Primary(
                                                  context)),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: StateContainer.of(context).curTheme.primary30,
                        ),
                        const TxListWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displayReleaseNote() {
    _displayReleaseNote = false;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      AppDialogs.showConfirmDialog(
          context,
          AppLocalization.of(context)!.releaseNoteHeader +
              ' ' +
              packageInfo.version,
          '',
          CaseChange.toUpperCase(AppLocalization.of(context)!.ok, context),
          () async {
        await sl.get<SharedPrefsUtil>().setVersionApp(packageInfo.version);
      });
    });
  }
}
