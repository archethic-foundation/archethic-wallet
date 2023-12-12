import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/views/add_account/layouts/add_account_sheet.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/views/intro/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/add_discussion_sheet.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_sheet.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/views/messenger/layouts/discussion_details_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_discussion_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_add_members.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_page.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft/layouts/configure_category_list.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_list_per_category.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/add_address.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_aeweb_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_http_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_ipfs_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/add_service/layouts/add_service_confirmation_form.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_command_receiver.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/layouts/send_transaction_confirmation_form.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:aewallet/ui/views/sheets/connectivity_warning.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoutesPath {
  GoRouter createRouter(
    GlobalKey<NavigatorState> rootNavigatorKey,
  ) {
    final deeplinkRpcReceiver = sl.get<ArchethicDeeplinkRPCServer>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) =>
              _wrapWithRPCCommandReceiver(const Splash()),
        ),
        GoRoute(
          path: HomePage.routerPage,
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AutoLockGuard(child: HomePage()),
          ),
        ),
        GoRoute(
          path: ShowSendingAnimation.routerPage,
          builder: (context, state) {
            final args = state.extra as String?;

            return AnimationLoadingPage(
              title: args,
            );
          },
        ),
        GoRoute(
          path: IntroWelcome.routerPage,
          builder: (context, state) => const IntroWelcome(),
        ),
        GoRoute(
          path: IntroNewWalletGetFirstInfos.routerPage,
          builder: (context, state) => const IntroNewWalletGetFirstInfos(),
        ),
        GoRoute(
          path: IntroBackupSeedPage.routerPage,
          builder: (context, state) {
            final args = state.extra! as String;
            return IntroBackupSeedPage(
              name: args,
            );
          },
        ),
        GoRoute(
          path: IntroNewWalletDisclaimer.routerPage,
          builder: (context, state) {
            final args = state.extra! as String;
            return IntroNewWalletDisclaimer(
              name: args,
            );
          },
        ),
        GoRoute(
          path: IntroImportSeedPage.routerPage,
          builder: (context, state) => const IntroImportSeedPage(),
        ),
        GoRoute(
          path: IntroBackupConfirm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return IntroBackupConfirm(
              name: args['name'] == null ? null : args['name']! as String,
              seed: args['seed'] == null ? null : args['seed']! as String,
              welcomeProcess: args['welcomeProcess'] == null ||
                  args['welcomeProcess']! as bool,
            );
          },
        ),
        GoRoute(
          path: SetPassword.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return SetPassword(
              header: args['header'] == null ? null : args['header']! as String,
              description: args['description'] == null
                  ? null
                  : args['description']! as String,
              seed: args['seed'] == null ? null : args['seed']! as String,
            );
          },
        ),
        GoRoute(
          path: SetYubikey.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return SetYubikey(
              header: args['header'] == null ? null : args['header']! as String,
              description: args['description'] == null
                  ? null
                  : args['description']! as String,
            );
          },
        ),
        GoRoute(
          path: PasswordScreen.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return PasswordScreen(
              canNavigateBack: args['canNavigateBack']! as bool,
            );
          },
        ),
        GoRoute(
          path: PinScreen.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return PinScreen(
              args['type']! as PinOverlayType,
              canNavigateBack: args['canNavigateBack'] == null ||
                  args['canNavigateBack']! as bool,
              description: args['description'] == null
                  ? ''
                  : args['description']! as String,
              pinScreenBackgroundColor:
                  args['pinScreenBackgroundColor'] as Color?,
            );
          },
        ),
        GoRoute(
          path: IntroConfigureSecurity.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return IntroConfigureSecurity(
              accessModes: args['accessModes'] as List<PickerItem>?,
              seed: args['seed']! as String,
              name: args['name']! as String,
              fromPage: args['fromPage']! as String,
              extra: args['extra'] == null ? null : args['extra']!,
            );
          },
        ),
        GoRoute(
          path: YubikeyScreen.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return YubikeyScreen(
              canNavigateBack: args['canNavigateBack']! as bool,
            );
          },
        ),
        GoRoute(
          path: SecurityMenuView.routerPage,
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const SecurityMenuView(),
          ),
        ),
        GoRoute(
          path: CustomizationMenuView.routerPage,
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const CustomizationMenuView(),
          ),
        ),
        GoRoute(
          path: AboutMenuView.routerPage,
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AboutMenuView(),
          ),
        ),
        GoRoute(
          path: AppLockScreen.routerPage,
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AppLockScreen(),
          ),
        ),
        GoRoute(
          path: NFTListPerCategory.routerPage,
          builder: (context, state) {
            final args = state.extra! as int;
            return _wrapWithRPCCommandReceiver(
              NFTListPerCategory(
                currentNftCategoryIndex: args,
              ),
            );
          },
        ),
        GoRoute(
          path: NftCreationProcessSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              NftCreationProcessSheet(
                currentNftCategoryIndex:
                    args['currentNftCategoryIndex']! as int,
              ),
            );
          },
        ),
        GoRoute(
          path: MessengerDiscussionPage.routerPage,
          builder: (context, state) {
            final args = state.extra! as String;
            return _wrapWithRPCCommandReceiver(
              MessengerDiscussionPage(
                discussionAddress: args,
              ),
            );
          },
        ),
        GoRoute(
          path: DiscussionDetailsPage.routerPage,
          builder: (context, state) {
            final args = state.extra! as String;
            return _wrapWithRPCCommandReceiver(
              DiscussionDetailsPage(
                discussionAddress: args,
              ),
            );
          },
        ),
        GoRoute(
          path: UpdateDiscussionPage.routerPage,
          builder: (context, state) {
            final args = state.extra as Discussion?;
            return _wrapWithRPCCommandReceiver(
              UpdateDiscussionPage(discussion: args!),
            );
          },
        ),
        GoRoute(
          path: AddAccountSheet.routerPage,
          builder: (context, state) {
            final args = state.extra as String?;
            return _wrapWithRPCCommandReceiver(
              AddAccountSheet(seed: args!),
            );
          },
        ),
        GoRoute(
          path: AddContactSheet.routerPage,
          builder: (context, state) {
            final args = state.extra as String?;
            return _wrapWithRPCCommandReceiver(
              AddContactSheet(address: args),
            );
          },
        ),
        GoRoute(
          path: BuySheet.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const BuySheet(),
            );
          },
        ),
        GoRoute(
          path: ContactDetail.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              ContactDetail(
                contact: args['contact']! as Contact,
                readOnly: args['readOnly'] == null || args['readOnly']! as bool,
              ),
            );
          },
        ),
        GoRoute(
          path: ConnectivityWarning.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const ConnectivityWarning(),
            );
          },
        ),
        GoRoute(
          path: AddTokenSheet.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const AddTokenSheet(),
            );
          },
        ),
        GoRoute(
          path: ChartSheet.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const ChartSheet(),
            );
          },
        ),
        GoRoute(
          path: AppSeedBackupSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              AppSeedBackupSheet(
                args['mnemonic'] == null
                    ? <String>[]
                    : args['mnemonic']! as List<String>,
                args['seed'] == null ? '' : args['seed']! as String,
              ),
            );
          },
        ),
        GoRoute(
          path: TransactionInfosSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as String;
            return _wrapWithRPCCommandReceiver(
              TransactionInfosSheet(
                args,
              ),
            );
          },
        ),
        GoRoute(
          path: TransferSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              TransferSheet(
                transferType: args['transferType']! as TransferType,
                recipient: args['recipient']! as TransferRecipient,
                actionButtonTitle: args['actionButtonTitle'] as String?,
                accountToken: args['accountToken'] as AccountToken?,
                tokenId: args['tokenId'] as String?,
              ),
            );
          },
        ),
        GoRoute(
          path: NFTCreationProcessImportTabAEWebForm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              NFTCreationProcessImportTabAEWebForm(
                onConfirm: args['onConfirm']! as void Function(String uri),
              ),
            );
          },
        ),
        GoRoute(
          path: NFTCreationProcessImportTabHTTPForm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              NFTCreationProcessImportTabHTTPForm(
                onConfirm: args['onConfirm']! as void Function(String uri),
              ),
            );
          },
        ),
        GoRoute(
          path: NFTCreationProcessImportTabIPFSForm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              NFTCreationProcessImportTabIPFSForm(
                onConfirm: args['onConfirm']! as void Function(String uri),
              ),
            );
          },
        ),
        GoRoute(
          path: NFTDetail.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              NFTDetail(
                name: args['name']! as String,
                address: args['address']! as String,
                symbol: args['symbol']! as String,
                properties: args['properties']! as Map<String, dynamic>,
                collection: args['collection']! as List<Map<String, dynamic>>,
                tokenId: args['tokenId']! as String,
                detailCollection: args['detailCollection']! as bool,
                nameInCollection: args['nameInCollection'] as String?,
              ),
            );
          },
        ),
        GoRoute(
          path: ConfigureCategoryList.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const ConfigureCategoryList(),
            );
          },
        ),
        GoRoute(
          path: CreateDiscussionSheet.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const CreateDiscussionSheet(),
            );
          },
        ),
        GoRoute(
          path: SettingsSheetWallet.routerPage,
          builder: (context, state) {
            return _wrapWithRPCCommandReceiver(
              const SettingsSheetWallet(),
            );
          },
        ),
        GoRoute(
          path: CreateDiscussionValidationSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              CreateDiscussionValidationSheet(
                discussionCreationSuccess:
                    args['discussionCreationSuccess'] as Function?,
                onDispose: args['onDispose'] as Function?,
              ),
            );
          },
        ),
        GoRoute(
          path: AddDiscussionSheet.routerPage,
          builder: (context, state) {
            final args = state.extra! as Discussion;
            return _wrapWithRPCCommandReceiver(
              AddDiscussionSheet(
                discussion: args,
              ),
            );
          },
        ),
        GoRoute(
          path: AddAddress.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              ProviderScope(
                overrides: args['overrides']! as List<Override>,
                child: AddAddress(
                  propertyName: args['propertyName']! as String,
                  propertyValue: args['propertyValue']! as String,
                  readOnly: args['readOnly']! as bool,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: AddServiceConfirmationForm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              AddServiceConfirmationForm(
                args['serviceName']! as String,
                args['command']! as RPCCommand<RPCSendTransactionCommandData>,
              ),
            );
          },
        ),
        GoRoute(
          path: SendTransactionConfirmationForm.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              SendTransactionConfirmationForm(
                args['command']! as RPCCommand<RPCSendTransactionCommandData>,
              ),
            );
          },
        ),
        GoRoute(
          path: UpdateDiscussionAddMembers.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              UpdateDiscussionAddMembers(
                listMembers: args['listMembers']! as List<String>,
                onDisposed: args['onDisposed'] as Function?,
              ),
            );
          },
        ),
      ],
      redirect: (context, state) {
        if (deeplinkRpcReceiver.canHandle(state.name)) {
          deeplinkRpcReceiver.handle(state.name);
        }
        return null;
      },
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Something went wrong: ${state.error}'),
        ),
      ),
    );
  }
}

Widget _wrapWithRPCCommandReceiver(Widget child) {
  return RPCCommandReceiver(child: child);
}
