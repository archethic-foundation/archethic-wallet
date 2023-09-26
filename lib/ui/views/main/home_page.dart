import 'dart:core';
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/notification/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/ui/menu/settings_drawer/settings_drawer.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/account_tab.dart';
import 'package:aewallet/ui/views/main/address_book_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/views/main/components/main_appbar.dart';
import 'package:aewallet/ui/views/main/components/recovery_phrase_banner.dart';
import 'package:aewallet/ui/views/main/keychain_tab.dart';
import 'package:aewallet/ui/views/main/nft_tab.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_tab.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/incoming_transactions_notifier.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/tab_item.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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
  int tabCount = 4;

  @override
  void initState() {
    super.initState();
    NotificationsUtil.init();

    if (FeatureFlags.messagingActive) {
      tabCount++;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(mainTabControllerProvider.notifier).initState(this);

      ref.read(mainTabControllerProvider)!.animateTo(
            ref.read(SettingsProviders.settings).mainScreenCurrentPage,
            duration: Duration.zero,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    _manageNotifications();
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final tabController = ref.watch(mainTabControllerProvider);

    if (tabController == null) {
      return Container();
    }

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
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SafeArea(
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: tabController,
                labelColor: theme.text,
                indicatorColor: theme.text,
                labelPadding: EdgeInsets.zero,
                onTap: (selectedIndex) {
                  ref
                      .read(SettingsProviders.settings.notifier)
                      .setMainScreenCurrentPage(selectedIndex);
                  if (selectedIndex == 3) {
                    ref
                        .read(AccountProviders.selectedAccount.notifier)
                        .refreshNFTs();
                  }
                },
                tabs: [
                  TabItem(
                    icon: Symbols.contacts,
                    label:
                        AppLocalizations.of(context)!.bottomMainMenuAddressBook,
                  ),
                  TabItem(
                    icon: Symbols.account_balance_wallet,
                    label: AppLocalizations.of(context)!.bottomMainMenuKeychain,
                  ),
                  TabItem(
                    icon: Symbols.account_box,
                    label: AppLocalizations.of(context)!.bottomMainMenuMain,
                  ),
                  TabItem(
                    icon: Symbols.photo_library,
                    label: AppLocalizations.of(context)!.bottomMainMenuNFT,
                  ),
                  if (FeatureFlags.messagingActive)
                    TabItem(
                      icon: Symbols.chat,
                      label:
                          AppLocalizations.of(context)!.bottomMainMenuMessenger,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _manageNotifications() {
    if (FeatureFlags.messagingActive == false) {
      return;
    }

    MessengerProviders.subscribeNotificationsWorker(ref);

    final listenAddresses = ref.watch(listenAddressesProvider);
    for (final listenAddress in listenAddresses) {
      ref.listen(
        NotificationProviders.txSentEvents(listenAddress),
        (_, event) async {
          final txEvent = event.valueOrNull;
          if (txEvent == null) return;

          debugPrint('Event type : ${txEvent.type}');

          if (txEvent.type == MessengerConstants.notificationTypeNewMessage) {
            manageNewMessageNotification(txEvent);
          }
          if (txEvent.type ==
              MessengerConstants.notificationTypeNewDiscussion) {
            manageNewDiscussionNotification(txEvent);
          }
        },
      );
    }
  }

  Future manageNewDiscussionNotification(TxSentEvent event) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    final discussion = await ref.read(
      MessengerProviders.remoteDiscussion(
        event.notificationRecipientAddress,
      ).future,
    );

    await ref
        .read(MessengerProviders.discussions.notifier)
        .addRemoteDiscussion(discussion);

    UIUtil.showSnackbar(
      localizations.youHaveBeenAddedTOADiscussion,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      icon: Symbols.chat,
    );
  }

  Future manageNewMessageNotification(TxSentEvent event) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final transaction = await sl.get<ApiService>().getTransaction(
      [event.notificationRecipientAddress],
    );
    final discussionGenesisAddress =
        transaction.values.first.data?.recipients.first.address;

    if (discussionGenesisAddress == null) {
      return;
    }

    final newMessage = (await ref.read(
      MessengerProviders.messages(
        discussionGenesisAddress,
        0,
        1,
      ).future,
    ))
        .last;

    await ref
        .read(MessengerProviders.messengerRepository)
        .updateDiscussionLastMessage(
          discussionAddress: discussionGenesisAddress,
          creator: (await ref.read(AccountProviders.selectedAccount.future))!,
          message: newMessage,
        );

    final contactName = ref
        .watch(
          ContactProviders.getContactWithGenesisPublicKey(
            newMessage.senderGenesisPublicKey,
          ),
        )
        .maybeMap(
          orElse: () => newMessage.senderGenesisPublicKey,
          data: (contact) => contact.value?.format,
        );

    UIUtil.showSnackbar(
      '$contactName : ${newMessage.content}',
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      icon: Symbols.chat,
    );

    ref.invalidate(
      MessengerProviders.discussion(discussionGenesisAddress),
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

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: TabBar(
              labelColor: theme.text,
              indicatorColor: theme.text,
              labelPadding: EdgeInsets.zero,
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
              onTap: (index) {
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
      ),
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
