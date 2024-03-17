part of 'router.dart';

final _authenticatedRoutes = [
  GoRoute(
    path: HomePage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: SecurityMenuView.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const SecurityMenuView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: CustomizationMenuView.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const CustomizationMenuView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: AboutMenuView.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const AboutMenuView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: AppLockScreen.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const AppLockScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: NFTListPerCategory.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: NFTListPerCategory(
        currentNftCategoryIndex: state.extra! as int,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: NftCreationProcessSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const NftCreationProcessSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
    routes: [
      GoRoute(
        name: AddAddress.routerPage,
        path: AddAddress.routerPage,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          key: state.pageKey,
          child: AddAddress(
            propertyName: AddAddressParams.fromJson(
              state.extra! as Map<String, dynamic>,
            ).propertyName,
            propertyValue: AddAddressParams.fromJson(
              state.extra! as Map<String, dynamic>,
            ).propertyValue,
            readOnly: AddAddressParams.fromJson(
              state.extra! as Map<String, dynamic>,
            ).readOnly,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    ],
  ),
  GoRoute(
    path: MessengerDiscussionPage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: MessengerDiscussionPage(
        discussionAddress: state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: DiscussionDetailsPage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: DiscussionDetailsPage(
        discussionAddress: state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: UpdateDiscussionPage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: UpdateDiscussionPage(
        discussion: state.extra! as Discussion,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: AddAccountSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: AddAccountSheet(
        seed: state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: AddContactSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: AddContactSheet(
        address: state.extra as String?,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: BuySheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const BuySheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: DEXSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const DEXSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: ContactDetail.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: ContactDetail(
        contactAddress: ContactDetailsRouteParams.fromJson(
          state.extra! as Map<String, dynamic>,
        ).contactAddress,
        readOnly: ContactDetailsRouteParams.fromJson(
              state.extra! as Map<String, dynamic>,
            ).readOnly ??
            false,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: ConnectivityWarning.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const ConnectivityWarning(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: AddTokenSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const AddTokenSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: ChartSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const ChartSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: AppSeedBackupSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: AppSeedBackupSheet(
        (state.extra! as Map<String, dynamic>)['mnemonic'] == null
            ? <String>[]
            : (state.extra! as Map<String, dynamic>)['mnemonic']!
                as List<String>,
        (state.extra! as Map<String, dynamic>)['seed'] == null
            ? ''
            : (state.extra! as Map<String, dynamic>)['seed']! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: TransactionInfosSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: TransactionInfosSheet(
        state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: TransferSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: TransferSheet(
        transferType: TransferType.values.byName(
          (state.extra! as Map<String, dynamic>)['transferType']! as String,
        ),
        recipient: TransferRecipient.fromJson(
          (state.extra! as Map<String, dynamic>)['recipient'],
        ),
        actionButtonTitle: (state.extra!
            as Map<String, dynamic>)['actionButtonTitle'] as String?,
        accountToken:
            (state.extra! as Map<String, dynamic>)['accountToken'] == null
                ? null
                : const AccountTokenConverter().fromJson(
                    (state.extra! as Map<String, dynamic>)['accountToken'],
                  ),
        tokenId: (state.extra! as Map<String, dynamic>)['tokenId'] as String?,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: NFTCreationProcessImportTabAEWebForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: NFTCreationProcessImportTabAEWebForm(
        onConfirm: (state.extra! as Map<String, dynamic>)['onConfirm']! as void
            Function(String uri),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: NFTCreationProcessImportTabHTTPForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: NFTCreationProcessImportTabHTTPForm(
        onConfirm: (state.extra! as Map<String, dynamic>)['onConfirm']! as void
            Function(String uri),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: NFTCreationProcessImportTabIPFSForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: NFTCreationProcessImportTabIPFSForm(
        onConfirm: (state.extra! as Map<String, dynamic>)['onConfirm']! as void
            Function(String uri),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: NFTDetail.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: NFTDetail(
        name: (state.extra! as Map<String, dynamic>)['name']! as String,
        address: (state.extra! as Map<String, dynamic>)['address']! as String,
        symbol: (state.extra! as Map<String, dynamic>)['symbol']! as String,
        properties: (state.extra! as Map<String, dynamic>)['properties']!
            as Map<String, dynamic>,
        collection: (state.extra! as Map<String, dynamic>)['collection']
            as List<dynamic>,
        tokenId: (state.extra! as Map<String, dynamic>)['tokenId']! as String,
        detailCollection:
            (state.extra! as Map<String, dynamic>)['detailCollection']! as bool,
        nameInCollection: (state.extra!
            as Map<String, dynamic>)['nameInCollection'] as String?,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: ConfigureCategoryList.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const ConfigureCategoryList(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: CreateDiscussionSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const CreateDiscussionSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: SettingsSheetWallet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const SettingsSheetWallet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  ),
  GoRoute(
    path: CreateDiscussionValidationSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: CreateDiscussionValidationSheet(
        discussionCreationSuccess: (state.extra!
            as Map<String, dynamic>)['discussionCreationSuccess'] as Function?,
        onDispose:
            (state.extra! as Map<String, dynamic>)['onDispose'] as Function?,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: AddDiscussionSheet.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: AddDiscussionSheet(
        discussion: state.extra! as Discussion,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: AddServiceConfirmationForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: AddServiceConfirmationForm(
        (state.extra! as Map<String, dynamic>)['serviceName']! as String,
        (state.extra! as Map<String, dynamic>)['command']!
            as RPCCommand<RPCSendTransactionCommandData>,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: SendTransactionConfirmationForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: SendTransactionConfirmationForm(
        (state.extra! as Map<String, dynamic>)['command']!
            as RPCCommand<RPCSendTransactionCommandData>,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: SignTransactionsConfirmationForm.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: SignTransactionsConfirmationForm(
        (state.extra! as Map<String, dynamic>)['addresses']! as List<String?>,
        (state.extra! as Map<String, dynamic>)['command']!
            as RPCCommand<RPCSignTransactionsCommandData>,
        (state.extra! as Map<String, dynamic>)['estimatedFees']! as double,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: UpdateDiscussionAddMembers.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: UpdateDiscussionAddMembers(
        listMembers: (state.extra! as Map<String, dynamic>)['listMembers']!
            as List<String>,
        onDisposed:
            (state.extra! as Map<String, dynamic>)['onDisposed'] as Function?,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
];
