import 'dart:core';
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/ui/menu/settings_drawer/settings_drawer.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/main/account_tab.dart';
import 'package:aewallet/ui/views/main/address_book_tab.dart';
import 'package:aewallet/ui/views/main/components/main_appbar.dart';
import 'package:aewallet/ui/views/main/components/recovery_phrase_banner.dart';
import 'package:aewallet/ui/views/main/keychain_tab.dart';
import 'package:aewallet/ui/views/main/nft_tab.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_tab.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/incoming_transactions_notifier.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final GlobalKey<ContainedTabBarViewState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    NotificationsUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const MainAppBar(),
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
        child: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 22),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ContainedTabBarView(
                key: _key,
                initialIndex:
                    ref.read(SettingsProviders.settings).mainScreenCurrentPage,
                tabBarViewProperties: const TabBarViewProperties(
                  physics: NeverScrollableScrollPhysics(),
                ),
                tabBarProperties: TabBarProperties(
                  position: TabBarPosition.bottom,
                  labelColor: theme.text,
                  labelStyle: theme.textStyleSize10W100Primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: theme.text,
                ),
                tabs: [
                  Tab(
                    key: const Key('bottomBarAddressBook'),
                    text:
                        AppLocalizations.of(context)!.bottomMainMenuAddressBook,
                    icon: const Icon(
                      Symbols.contacts,
                      weight: IconSize.weightM,
                      opticalSize: IconSize.opticalSizeM,
                      grade: IconSize.gradeM,
                    ),
                  ),
                  Tab(
                    key: const Key('bottomBarKeyChain'),
                    text: AppLocalizations.of(context)!.bottomMainMenuKeychain,
                    icon: const Icon(
                      Symbols.account_balance_wallet,
                      weight: IconSize.weightM,
                      opticalSize: IconSize.opticalSizeM,
                      grade: IconSize.gradeM,
                    ),
                  ),
                  Tab(
                    key: const Key('bottomBarMain'),
                    text: AppLocalizations.of(context)!.bottomMainMenuMain,
                    icon: const Icon(
                      Symbols.account_box,
                      weight: IconSize.weightM,
                      opticalSize: IconSize.opticalSizeM,
                      grade: IconSize.gradeM,
                    ),
                  ),
                  Tab(
                    key: const Key('bottomBarNFT'),
                    text: AppLocalizations.of(context)!.bottomMainMenuNFT,
                    icon: const Icon(
                      Symbols.photo_library,
                      weight: IconSize.weightM,
                      opticalSize: IconSize.opticalSizeM,
                      grade: IconSize.gradeM,
                    ),
                  ),
                  if (FeatureFlags.messagingActive)
                    Tab(
                      key: const Key('bottomBarMessenger'),
                      text:
                          AppLocalizations.of(context)!.bottomMainMenuMessenger,
                      icon: const Icon(
                        Symbols.chat,
                        weight: IconSize.weightM,
                        opticalSize: IconSize.opticalSizeM,
                        grade: IconSize.gradeM,
                      ),
                    ),
                ],
                views: const [
                  AddressBookTab(),
                  KeychainTab(),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AccountTab(),
                      RecoveryPhraseBanner(),
                    ],
                  ),
                  NFTTab(
                    key: Key('bottomBarAddressNFTlink'),
                  ),
                  if (FeatureFlags.messagingActive) MessengerTab(),
                ],
                onChange: (page) {
                  ref
                      .read(SettingsProviders.settings.notifier)
                      .setMainScreenCurrentPage(page);
                  if (page == 3) {
                    ref
                        .read(AccountProviders.selectedAccount.notifier)
                        .refreshNFTs();
                  }
                },
              ),
            ),
          ),
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
              ),
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
                  icon: Symbols.add,
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
