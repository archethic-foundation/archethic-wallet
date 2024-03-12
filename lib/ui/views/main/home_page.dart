import 'dart:core';
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/migrations/migration_manager.dart';
import 'package:aewallet/application/notification/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/local_data_migration_widget.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
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
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/tab_item.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const routerPage = '/home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin
    implements SheetSkeletonInterface {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      menu: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return const MainAppBar();
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final tabController = ref.watch(mainTabControllerProvider);
    if (tabController == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            child: TabBar(
              dividerColor: Colors.transparent,
              controller: tabController,
              labelColor: ArchethicTheme.text,
              indicatorColor: ArchethicTheme.text,
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
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    _manageNotifications();

    final tabController = ref.watch(mainTabControllerProvider);
    if (tabController == null) {
      return Container();
    }

    final localDataMigration =
        ref.watch(LocalDataMigrationProviders.localDataMigration);
    if (localDataMigration.migrationInProgress) {
      return const LocalDataMigrationWidget();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ArchethicTheme.backgroundSmall,
          ),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
          opacity: 0.7,
        ),
      ),
      child: IncomingTransactionsNotifier(
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
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: RecoveryPhraseBanner(),
                ),
              ],
            ),
            NFTTab(
              key: Key('bottomBarAddressNFTlink'),
            ),
            if (FeatureFlags.messagingActive) MessengerTab(),
          ],
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
          if (txEvent.type ==
              MessengerConstants.notificationTypeDiscussionUpdated) {
            manageNewDiscussionUpdatedNotification(txEvent);
          }
        },
      );
    }
  }

  Future manageNewDiscussionNotification(TxSentEvent event) async {
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
      localizations.youHaveBeenAddedToADiscussion,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      icon: Symbols.chat,
    );
  }

  Future manageNewMessageNotification(TxSentEvent event) async {
    final transaction = await sl.get<ApiService>().getTransaction(
      [event.notificationRecipientAddress],
    );
    final discussionGenesisAddress =
        transaction.values.first.data?.recipients.first;

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
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      icon: Symbols.chat,
    );

    ref.invalidate(
      MessengerProviders.discussion(discussionGenesisAddress),
    );
  }

  Future manageNewDiscussionUpdatedNotification(TxSentEvent event) async {
    final localizations = AppLocalizations.of(context)!;

    if (event.extra == null) {
      return;
    }

    final extra = event.extra as Map<String, dynamic>;

    if (extra.containsKey('membersAddedToNotify')) {
      final listMembersAdded = extra['membersAddedToNotify'];
      if (listMembersAdded!.isNotEmpty) {
        for (final memberPubKey in listMembersAdded) {
          final contact = await ref.read(
            ContactProviders.getContactWithGenesisPublicKey(memberPubKey)
                .future,
          );
          // Contact does not exist or contact is not an internal one
          if (contact == null ||
              contact.type != ContactType.keychainService.name) {
            continue;
          }

          final transaction = await sl.get<ApiService>().getTransaction(
            [event.notificationRecipientAddress],
          );
          final discussionGenesisAddress =
              transaction.values.first.data!.recipients.first;

          final discussion = await ref.read(
            MessengerProviders.remoteDiscussion(
              discussionGenesisAddress,
            ).future,
          );

          await ref
              .read(MessengerProviders.discussions.notifier)
              .addRemoteDiscussion(discussion);

          UIUtil.showSnackbar(
            localizations.youHaveBeenAddedToADiscussion,
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            icon: Symbols.chat,
          );
        }
      }
    }

    if (extra.containsKey('membersDeletedToNotify')) {
      final listMembersDeleted = extra['membersDeletedToNotify'];
      if (listMembersDeleted!.isNotEmpty) {
        for (final memberPubKey in listMembersDeleted) {
          final contact = await ref.read(
            ContactProviders.getContactWithGenesisPublicKey(memberPubKey)
                .future,
          );
          // Contact does not exist or contact is not an internal one
          if (contact == null ||
              contact.type != ContactType.keychainService.name) {
            continue;
          }

          UIUtil.showSnackbar(
            localizations.youHaveBeenDeletedFromADiscussion,
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            icon: Symbols.comments_disabled,
          );
        }
      }
    }
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

    final session = ref.watch(SessionProviders.session).loggedIn;
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;
    if (session == null) return const SizedBox();
    final preferences = ref.watch(SettingsProviders.settings);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: TabBar(
              labelColor: ArchethicTheme.text,
              indicatorColor: ArchethicTheme.text,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Text(
                  localizations.recentTransactionsHeader,
                  style: ArchethicThemeStyles.textStyleSize14W600Primary,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      key: const Key('fungibleTokenTab'),
                      localizations.tokensHeader,
                      style: ArchethicThemeStyles.textStyleSize14W600Primary,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (accountSelected!.balance!.isNativeTokenValuePositive())
                      InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                preferences.activeVibrations,
                              );
                          context.go(AddTokenSheet.routerPage);
                        },
                        child: ShaderMask(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.add_circle_outline,
                              opticalSize: IconSize.opticalSizeM,
                              grade: IconSize.gradeM,
                              weight: 800,
                              color: ArchethicTheme.text,
                              size: 28,
                            ),
                          ),
                          shaderCallback: (Rect bounds) {
                            const rect = Rect.fromLTRB(0, 0, 40, 40);
                            return ArchethicTheme.gradient.createShader(rect);
                          },
                        ),
                      ),
                  ],
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
