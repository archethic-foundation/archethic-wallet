import 'dart:core';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/ui/menu/settings_drawer/settings_drawer.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/main/account_tab.dart';
import 'package:aewallet/ui/views/main/address_book_tab.dart';
import 'package:aewallet/ui/views/main/components/main_appbar.dart';
import 'package:aewallet/ui/views/main/components/main_bottombar.dart';
import 'package:aewallet/ui/views/main/keychain_tab.dart';
import 'package:aewallet/ui/views/main/nft_tab.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/incoming_transactions_notifier.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  PageController? _bottomBarPageController;
  PageController get bottomBarPageController =>
      _bottomBarPageController ??= PageController(
        initialPage: ref.read(SettingsProviders.settings).mainScreenCurrentPage,
      );

  @override
  void initState() {
    super.initState();
    NotificationsUtil.init();
  }

  @override
  void dispose() {
    _bottomBarPageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    ref.listen(
      SettingsProviders.settings
          .select((settings) => settings.mainScreenCurrentPage),
      (previous, next) {
        if (previous == next) return;

        bottomBarPageController.jumpToPage(next);
      },
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const MainAppBar(),
      bottomNavigationBar: const MainBottomBar(),
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
          controller: bottomBarPageController,
          onPageChanged: (int page) {
            ref
                .read(SettingsProviders.settings.notifier)
                .setMainScreenCurrentPage(page);
            if (page == 3) {
              ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();
            }
          },
          children: const [
            AddressBookTab(),
            KeychainTab(),
            AccountTab(),
            NFTTab(
              key: Key('bottomBarAddressNFTlink'),
            ),
          ],
        ),
      ),
    );
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
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final session = ref.watch(SessionProviders.session).loggedIn;
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;
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
                key: const Key('fungibleTokenTab'),
                localizations.tokensHeader,
                style: theme.textStyleSize14W600EquinoxPrimary,
                textAlign: TextAlign.center,
              ),
            ],
            views: const [
              SizedBox(
                height: 0,
              ),
              SizedBox(
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
                AppButtonTinyConnectivity(
                  localizations.createFungibleToken,
                  Dimens.buttonBottomDimens,
                  icon: Icons.add,
                  key: const Key('createTokenFungible'),
                  onPressed: () {
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const AddTokenSheet(),
                    );
                  },
                  disabled:
                      !accountSelected!.balance!.isNativeTokenValuePositive(),
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
