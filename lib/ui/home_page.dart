// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_uco_sheet.dart';
import 'package:archethic_mobile_wallet/ui/widgets/custom_rect_tween.dart';
import 'package:archethic_mobile_wallet/ui/widgets/hero_dialog_route.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/ui/settings/settings_drawer.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/balance.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/ui/widgets/line_chart.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tx_list.dart';
import 'package:archethic_mobile_wallet/util/caseconverter.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

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

  @override
  void initState() {
    super.initState();

    _displayReleaseNote = false;
    _checkVersionApp();

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

  Widget _getTopCards(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: StateContainer.of(context).curTheme.backgroundDark,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 120,
                curve: Curves.easeInOut,
                child: FlipCard(
                    flipOnTouch: true,
                    direction: FlipDirection.HORIZONTAL,
                    front: BalanceDisplay.buildBalanceUCODisplay(
                        context, _opacityAnimation!),
                    back: LineChartWidget.buildTinyCoinsChart(context))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
        );
      },
    );
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
                ? Image.network(
                    StateContainer.of(context).curTheme.assetsFolder! +
                        StateContainer.of(context).curTheme.logoAlone!,
                    height: 40,
                  )
                : SvgPicture.asset(
                    StateContainer.of(context).curTheme.assetsFolder! +
                        StateContainer.of(context).curTheme.logoAlone!,
                    height: 40,
                  )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          if (StateContainer.of(context).wallet != null &&
              StateContainer.of(context).wallet!.accountBalance.uco != null &&
              StateContainer.of(context).wallet!.accountBalance.uco! > 0)
            Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: TextButton(
                onPressed: () {
                  Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: TransferUcoSheet(
                          contactsRef: StateContainer.of(context).contactsRef,
                          title: AppLocalization.of(context)!.transferUCO,
                          localCurrency:
                              StateContainer.of(context).curCurrency));
                },
                child: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset('assets/icons/send.png',
                        color: Colors.white)),
              ),
            )
          else
            const SizedBox(),
          StateContainer.of(context).selectedAccount.lastAddress == null
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(right: 0.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) => Center(
                            child: _QrCodePopupCard(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        child: Hero(
                            tag: 'qrcode',
                            child: Image.asset('assets/icons/barcode.png',
                                color: Colors.white))),
                  ),
                ),
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
          minimum: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.045,
              bottom: MediaQuery.of(context).size.height * 0.035),
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                child: _getTopCards(context),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    StateContainer.of(context)
                        .curTheme
                        .getBackgroundScreen(context)!,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StateContainer.of(context).wallet == null
                            ? const SizedBox()
                            : const TxListWidget(),
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

class _QrCodePopupCard extends StatelessWidget {
  const _QrCodePopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'qrcode',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: TextButton(
        onPressed: () {
          Clipboard.setData(
              ClipboardData(text: StateContainer.of(context).wallet!.address));
          UIUtil.showSnackbar('Address copied', context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            color: StateContainer.of(context).curTheme.backgroundDarkest,
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalization.of(context)!.addressInfos,
                          style: AppStyles.textStyleSize16W700Primary(context),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDarkest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QrImage(
                          foregroundColor: Colors.white,
                          data: StateContainer.of(context)
                              .selectedAccount
                              .lastAddress!,
                          version: QrVersions.auto,
                          size: 150.0,
                          gapless: false,
                        ),
                      ),
                      Container(
                        width: 150,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                                StateContainer.of(context)
                                    .selectedAccount
                                    .lastAddress!
                                    .substring(0, 16),
                                style: AppStyles.textStyleSize14W100Primary(
                                    context)),
                            AutoSizeText(
                                StateContainer.of(context)
                                    .selectedAccount
                                    .lastAddress!
                                    .substring(16, 32),
                                style: AppStyles.textStyleSize14W100Primary(
                                    context)),
                            AutoSizeText(
                                StateContainer.of(context)
                                    .selectedAccount
                                    .lastAddress!
                                    .substring(32, 48),
                                style: AppStyles.textStyleSize14W100Primary(
                                    context)),
                            AutoSizeText(
                                StateContainer.of(context)
                                    .selectedAccount
                                    .lastAddress!
                                    .substring(48),
                                style: AppStyles.textStyleSize14W100Primary(
                                    context)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
