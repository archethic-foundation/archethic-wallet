part of 'router.dart';

final _authenticatedRoutes = [
  GoRoute(
    path: HomePage.routerPage,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: SecurityMenuView.routerPage,
    builder: (context, state) => const SecurityMenuView(),
  ),
  GoRoute(
    path: CustomizationMenuView.routerPage,
    builder: (context, state) => const CustomizationMenuView(),
  ),
  GoRoute(
    path: AboutMenuView.routerPage,
    builder: (context, state) => const AboutMenuView(),
  ),
  GoRoute(
    path: AppLockScreen.routerPage,
    builder: (context, state) => const AppLockScreen(),
  ),
  GoRoute(
    path: NFTListPerCategory.routerPage,
    builder: (context, state) {
      final args = state.extra! as int;
      return NFTListPerCategory(
        currentNftCategoryIndex: args,
      );
    },
  ),
  GoRoute(
    path: NftCreationProcessSheet.routerPage,
    builder: (context, state) => const NftCreationProcessSheet(),
    routes: [
      GoRoute(
        name: AddAddress.routerPage,
        path: AddAddress.routerPage,
        builder: (context, state) {
          final params = AddAddressParams.fromJson(
            state.extra! as Map<String, dynamic>,
          );
          return AddAddress(
            propertyName: params.propertyName,
            propertyValue: params.propertyValue,
            readOnly: params.readOnly,
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: MessengerDiscussionPage.routerPage,
    builder: (context, state) {
      final args = state.extra! as String;
      return MessengerDiscussionPage(
        discussionAddress: args,
      );
    },
  ),
  GoRoute(
    path: DiscussionDetailsPage.routerPage,
    builder: (context, state) {
      final args = state.extra! as String;
      return DiscussionDetailsPage(
        discussionAddress: args,
      );
    },
  ),
  GoRoute(
    path: UpdateDiscussionPage.routerPage,
    builder: (context, state) {
      final args = state.extra as Discussion?;
      return UpdateDiscussionPage(discussion: args!);
    },
  ),
  GoRoute(
    path: AddAccountSheet.routerPage,
    builder: (context, state) {
      final args = state.extra as String?;
      return AddAccountSheet(seed: args!);
    },
  ),
  GoRoute(
    path: AddContactSheet.routerPage,
    builder: (context, state) {
      final args = state.extra as String?;
      return AddContactSheet(address: args);
    },
  ),
  GoRoute(
    path: BuySheet.routerPage,
    builder: (context, state) {
      return const BuySheet();
    },
  ),
  GoRoute(
    path: ContactDetail.routerPage,
    builder: (context, state) {
      final params = ContactDetailsRouteParams.fromJson(
        state.extra! as Map<String, dynamic>,
      );
      return ContactDetail(
        contactAddress: params.contactAddress,
        readOnly: params.readOnly ?? false,
      );
    },
  ),
  GoRoute(
    path: ConnectivityWarning.routerPage,
    builder: (context, state) {
      return const ConnectivityWarning();
    },
  ),
  GoRoute(
    path: AddTokenSheet.routerPage,
    builder: (context, state) {
      return const AddTokenSheet();
    },
  ),
  GoRoute(
    path: ChartSheet.routerPage,
    builder: (context, state) {
      return const ChartSheet();
    },
  ),
  GoRoute(
    path: AppSeedBackupSheet.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return AppSeedBackupSheet(
        args['mnemonic'] == null
            ? <String>[]
            : args['mnemonic']! as List<String>,
        args['seed'] == null ? '' : args['seed']! as String,
      );
    },
  ),
  GoRoute(
    path: TransactionInfosSheet.routerPage,
    builder: (context, state) {
      final args = state.extra! as String;
      return TransactionInfosSheet(
        args,
      );
    },
  ),
  GoRoute(
    path: TransferSheet.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return TransferSheet(
        transferType:
            TransferType.values.byName(args['transferType']! as String),
        recipient: TransferRecipient.fromJson(args['recipient']),
        actionButtonTitle: args['actionButtonTitle'] as String?,
        accountToken: args['accountToken'] == null
            ? null
            : const AccountTokenConverter().fromJson(args['accountToken']),
        tokenId: args['tokenId'] as String?,
      );
    },
  ),
  GoRoute(
    path: NFTCreationProcessImportTabAEWebForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return NFTCreationProcessImportTabAEWebForm(
        onConfirm: args['onConfirm']! as void Function(String uri),
      );
    },
  ),
  GoRoute(
    path: NFTCreationProcessImportTabHTTPForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return NFTCreationProcessImportTabHTTPForm(
        onConfirm: args['onConfirm']! as void Function(String uri),
      );
    },
  ),
  GoRoute(
    path: NFTCreationProcessImportTabIPFSForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return NFTCreationProcessImportTabIPFSForm(
        onConfirm: args['onConfirm']! as void Function(String uri),
      );
    },
  ),
  GoRoute(
    path: NFTDetail.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return NFTDetail(
        name: args['name']! as String,
        address: args['address']! as String,
        symbol: args['symbol']! as String,
        properties: args['properties']! as Map<String, dynamic>,
        collection: args['collection'] as List<dynamic>,
        tokenId: args['tokenId']! as String,
        detailCollection: args['detailCollection']! as bool,
        nameInCollection: args['nameInCollection'] as String?,
      );
    },
  ),
  GoRoute(
    path: ConfigureCategoryList.routerPage,
    builder: (context, state) {
      return const ConfigureCategoryList();
    },
  ),
  GoRoute(
    path: CreateDiscussionSheet.routerPage,
    builder: (context, state) {
      return const CreateDiscussionSheet();
    },
  ),
  GoRoute(
    path: SettingsSheetWallet.routerPage,
    builder: (context, state) {
      return const SettingsSheetWallet();
    },
  ),
  GoRoute(
    path: CreateDiscussionValidationSheet.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return CreateDiscussionValidationSheet(
        discussionCreationSuccess:
            args['discussionCreationSuccess'] as Function?,
        onDispose: args['onDispose'] as Function?,
      );
    },
  ),
  GoRoute(
    path: AddDiscussionSheet.routerPage,
    builder: (context, state) {
      final args = state.extra! as Discussion;
      return AddDiscussionSheet(
        discussion: args,
      );
    },
  ),
  GoRoute(
    path: AddServiceConfirmationForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return AddServiceConfirmationForm(
        args['serviceName']! as String,
        args['command']! as RPCCommand<RPCSendTransactionCommandData>,
      );
    },
  ),
  GoRoute(
    path: SendTransactionConfirmationForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return SendTransactionConfirmationForm(
        args['command']! as RPCCommand<RPCSendTransactionCommandData>,
      );
    },
  ),
  GoRoute(
    path: SignTransactionsConfirmationForm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return SignTransactionsConfirmationForm(
        args['command']! as RPCCommand<RPCSignTransactionsCommandData>,
        args['estimatedFees']! as double,
      );
    },
  ),
  GoRoute(
    path: UpdateDiscussionAddMembers.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return UpdateDiscussionAddMembers(
        listMembers: args['listMembers']! as List<String>,
        onDisposed: args['onDisposed'] as Function?,
      );
    },
  ),
];
