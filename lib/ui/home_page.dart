// @dart=2.9

// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Flutter imports:
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/transactions_chain.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:package_info/package_info.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/ui/receive/receive_sheet.dart';
import 'package:archethic_mobile_wallet/ui/settings/settings_drawer.dart';
import 'package:archethic_mobile_wallet/ui/util/particles/particles_flutter.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/balance.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/ui/widgets/line_chart.dart';
import 'package:archethic_mobile_wallet/ui/widgets/nft_list.dart';
import 'package:archethic_mobile_wallet/ui/widgets/qr_code.dart';
import 'package:archethic_mobile_wallet/ui/widgets/reactive_refresh.dart';
import 'package:archethic_mobile_wallet/util/caseconverter.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';
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
  AnimationController _placeholderCardAnimationController;
  Animation<double> _opacityAnimation;
  bool _animationDisposed;

  bool _displayReleaseNote;

  // Receive card instance
  ReceiveSheet receive;

  bool _lockDisabled = false; // whether we should avoid locking the app

  // Main card height
  double mainCardHeight;
  double settingsIconMarginTop = 5;

  ScrollController _scrollController;

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  bool _isRefreshing = false;

  // Refresh list
  Future<void> _refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    sl.get<HapticUtil>().success();
    StateContainer.of(context).requestUpdate();

    // Hide refresh indicator after 3 seconds if no server response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isRefreshing = false;
      });
    });
  }

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
    WidgetsBinding.instance.addObserver(this);

    // Main Card Size
    mainCardHeight = 120;
    settingsIconMarginTop = 7;

    // Setup placeholder animation and start
    _animationDisposed = false;
    _placeholderCardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _placeholderCardAnimationController
        .addListener(_animationControllerListener);
    _opacityAnimation = Tween(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _placeholderCardAnimationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _opacityAnimation.addStatusListener(_animationStatusListener);
    _placeholderCardAnimationController.forward();

    _scrollController = ScrollController();
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _placeholderCardAnimationController.forward();
        break;
      case AnimationStatus.completed:
        _placeholderCardAnimationController.reverse();
        break;
      default:
        break;
    }
  }

  void _animationControllerListener() {
    setState(() {});
  }

  void _startAnimation() {
    if (_animationDisposed) {
      _animationDisposed = false;
      _placeholderCardAnimationController
          .addListener(_animationControllerListener);
      _opacityAnimation.addStatusListener(_animationStatusListener);
      _placeholderCardAnimationController.forward();
    }
  }

  void _disposeAnimation() {
    if (!_animationDisposed) {
      _animationDisposed = true;
      _opacityAnimation.removeStatusListener(_animationStatusListener);
      _placeholderCardAnimationController
          .removeListener(_animationControllerListener);
      _placeholderCardAnimationController.stop();
    }
  }

  StreamSubscription<DisableLockTimeoutEvent> _disableLockSub;
  StreamSubscription<AccountChangedEvent> _switchAccountSub;

  void _registerBus() {
    // Hackish event to block auto-lock functionality
    _disableLockSub = EventTaxiImpl.singleton()
        .registerTo<DisableLockTimeoutEvent>()
        .listen((DisableLockTimeoutEvent event) {
      if (event.disable) {
        cancelLockEvent();
      }
      _lockDisabled = event.disable;
    });
    // User changed account
    _switchAccountSub = EventTaxiImpl.singleton()
        .registerTo<AccountChangedEvent>()
        .listen((AccountChangedEvent event) {
      setState(() {
        StateContainer.of(context).wallet.loading = true;
        StateContainer.of(context).wallet.historyLoading = true;

        _startAnimation();
        StateContainer.of(context).updateWallet(account: event.account);

        StateContainer.of(context).wallet.loading = false;
        StateContainer.of(context).wallet.historyLoading = false;
      });

      paintQrCode(address: event.account.lastAddress);
      if (event.delayPop) {
        Future.delayed(const Duration(milliseconds: 300), () {
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
    WidgetsBinding.instance.removeObserver(this);
    _placeholderCardAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _destroyBus() {
    if (_disableLockSub != null) {
      _disableLockSub.cancel();
    }
    if (_switchAccountSub != null) {
      _switchAccountSub.cancel();
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
  StreamSubscription<dynamic> lockStreamListener;

  Future<void> setAppLockEvent() async {
    if (((await sl.get<SharedPrefsUtil>().getLock()) ||
            StateContainer.of(context).encryptedSecret != null) &&
        !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener.cancel();
      }
      final Future<dynamic> delayed = Future.delayed(
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
      lockStreamListener.cancel();
    }
  }

  void paintQrCode({String address}) {
    final QrPainter painter = QrPainter(
      //data:
      //    address == null ? StateContainer.of(context).wallet.address : address,
      // TODO:
      data: '05A2525C9C4FDDC02BA97554980A0CFFADA2AEB0650E3EAD05796275F05DDA85',
      version: 6,
      gapless: false,
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
    );
    painter
        .toImageData(MediaQuery.of(context).size.width)
        .then((ByteData byteData) {
      setState(() {
        receive = ReceiveSheet(
          qrWidget: Container(
              width: MediaQuery.of(context).size.width / 2.675,
              child: Image.memory(byteData.buffer.asUint8List())),
        );
      });
    });
  }

  Widget _getTopCards(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 2,
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: StateContainer.of(context).curTheme.backgroundDark,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: mainCardHeight,
                curve: Curves.easeInOut,
                child: index == 0
                    ? FlipCard(
                        flipOnTouch: true,
                        direction: FlipDirection.HORIZONTAL,
                        front: BalanceDisplay.buildBalanceUCODisplay(
                            context, _opacityAnimation),
                        back: LineChartWidget.buildTinyCoinsChart(context))
                    : FlipCard(
                        flipOnTouch: true,
                        direction: FlipDirection.HORIZONTAL,
                        front: QRcodeDisplay.buildAddressDisplay(
                            context, _opacityAnimation),
                        back: QRcodeDisplay.buildQRCodeDisplay(
                            context, _opacityAnimation))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _displayReleaseNote
        ? WidgetsBinding.instance
            .addPostFrameCallback((_) => displayReleaseNote())
        : null;
    // Create QR ahead of time because it improves performance this way
    if (receive == null && StateContainer.of(context).wallet != null) {
      paintQrCode();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
            child: SvgPicture.asset(
          "assets/archethic_logo_alone.svg",
          height: 40,
        )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[],
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
              StateContainer.of(context).curTheme.backgroundDark,
              StateContainer.of(context).curTheme.background
            ],
          ),
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.045,
              bottom: MediaQuery.of(context).size.height * 0.035),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ReactiveRefreshIndicator(
                  onRefresh: _refresh,
                  isRefreshing: _isRefreshing,
                  backgroundColor:
                      StateContainer.of(context).curTheme.backgroundDark,
                  child: KeyboardAvoider(
                    duration: const Duration(milliseconds: 0),
                    autoScroll: true,
                    focusPadding: 40,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        CircularParticle(
                          awayRadius: 80,
                          numberOfParticles: 80,
                          speedOfParticles: 0.5,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          onTapAnimation: true,
                          particleColor: StateContainer.of(context)
                              .curTheme
                              .primary10
                              .withAlpha(150)
                              .withOpacity(0.2),
                          awayAnimationDuration:
                              const Duration(milliseconds: 600),
                          maxParticleSize: 8,
                          isRandSize: true,
                          isRandomColor: false,
                          awayAnimationCurve: Curves.easeInOutBack,
                          enableHover: true,
                          hoverColor:
                              StateContainer.of(context).curTheme.primary30,
                          hoverRadius: 90,
                          connectDots: true,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              child: _getTopCards(context),
                            ),
                            const SizedBox(height: 20),
                            NftListWidget.buildNftList(context),
                            const SizedBox(height: 20),
                            
                          ],
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
    );
  }

  void displayReleaseNote() {
    _displayReleaseNote = false;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      AppDialogs.showConfirmDialog(
          context,
          AppLocalization.of(context).releaseNoteHeader +
              ' ' +
              packageInfo.version,
          '',
          CaseChange.toUpperCase(AppLocalization.of(context).ok, context),
          () async {
        await sl.get<SharedPrefsUtil>().setVersionApp(packageInfo.version);
      });
    });
  }
}
