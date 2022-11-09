// ignore_for_file: cancel_subscriptions, prefer_const_constructors
import 'dart:async';
import 'dart:core';

import 'package:aewallet/application/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/account_changed_event.dart';
import 'package:aewallet/bus/disable_lock_timeout_event.dart';
import 'package:aewallet/bus/notifications_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/menu/settings_drawer/settings_drawer.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/main/account_tab.dart';
import 'package:aewallet/ui/views/main/accounts_list_tab.dart';
import 'package:aewallet/ui/views/main/main_appbar.dart';
import 'package:aewallet/ui/views/main/main_bottombar.dart';
import 'package:aewallet/ui/views/main/nft_tab.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/incoming_transactions_notifier.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _lockDisabled = false; // whether we should avoid locking the app

  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    _registerBus();
    WidgetsBinding.instance.addObserver(this);

    NotificationsUtil.init();
    listenNotifications();
  }

  @override
  void dispose() {
    _destroyBus();
    WidgetsBinding.instance.removeObserver(this);
    tabController!.dispose();
    super.dispose();
  }

  StreamSubscription<String?> listenNotifications() =>
      NotificationsUtil.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    EventTaxiImpl.singleton().fire(NotificationsEvent(payload: payload));
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
        StateContainer.of(context).requestUpdate();
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
      await StateContainer.of(context).requestUpdate();

      Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
    });
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
      case AppLifecycleState.inactive:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.detached:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  // To lock and unlock the app
  StreamSubscription<dynamic>? lockStreamListener;

  Future<void> setAppLockEvent() async {
    final preferences = await Preferences.getInstance();
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: MainAppBar(),
      bottomNavigationBar: MainBottomBar(),
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.background,
      drawer: SizedBox(
        width: Responsive.drawerWidth(context),
        child: const Drawer(
          child: SettingsSheetWallet(),
        ),
      ),
      body: IncomingTransactionsNotifier(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: StateContainer.of(context).bottomBarPageController,
          children: const [AccountsListTab(), AccountTab(), NFTTab()],
          //children: const [AccountsListTab(), AccountTab()],
          onPageChanged: (index) {
            setState(
              () => StateContainer.of(context).bottomBarCurrentPage = index,
            );
          },
        ),
      ),
    );
  }

  // TODO(reddwarf03): WIP, https://github.com/archethic-foundation/archethic-wallet/issues/144
  // ignore: unused_element
  Future<void> _networkDialog() async {
    // StateContainer.of(context).curNetwork = (await NetworkDialog.getDialog(
    //   context,
    //   ref,
    //   StateContainer.of(context).curNetwork,
    // ))!;
    await StateContainer.of(context).requestUpdate();
    setState(() {});
  }
}

class ExpandablePageView extends ConsumerStatefulWidget {
  const ExpandablePageView({
    super.key,
    @required this.children,
  });
  final List<Widget>? children;

  @override
  ConsumerState<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends ConsumerState<ExpandablePageView>
    with TickerProviderStateMixin {
  PageController? _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children!.map((e) => 0.0).toList();
    super.initState();
    _pageController = PageController()
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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final session = ref.watch(SessionProviders.session).loggedIn;

    if (session == null) return const SizedBox();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              indicatorColor: theme.backgroundDarkest,
            ),
            tabs: [
              Text(
                localizations.recentTransactionsHeader,
                style: theme.textStyleSize14W600EquinoxPrimary,
                textAlign: TextAlign.center,
              ),
              Text(
                localizations.tokensHeader,
                style: theme.textStyleSize14W600EquinoxPrimary,
                textAlign: TextAlign.center,
              ),
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
          tween: Tween<double>(begin: _heights[0], end: _currentHeight),
          builder: (context, value, child) =>
              SizedBox(height: value, child: child),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _sizeReportingChildren
                .asMap() //
                .map(MapEntry.new)
                .values
                .toList(),
          ),
        ),
        if (_currentPage == 1)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.createFungibleToken,
                  Dimens.buttonBottomDimens,
                  key: const Key('createTokenFungible'),
                  onPressed: () async {
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: AddTokenSheet(
                        seed: session.wallet.seed,
                      ),
                    );
                  },
                ),
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
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  const SizeReportingWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });
  final Widget child;
  final ValueChanged<Size> onSizeChange;

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
