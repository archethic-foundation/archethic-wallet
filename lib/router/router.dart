import 'dart:convert';

import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/data/account_token.dart';
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
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
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
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/layouts/sign_transactions_confirmation_form.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:aewallet/ui/views/sheets/connectivity_warning.dart';
import 'package:aewallet/ui/views/sheets/dex_sheet.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.authenticated.dart';
part 'router.authentication.dart';
part 'router.introduction.dart';

class RoutesPath {
  RoutesPath(
    this.rootNavigatorKey,
  );

  final GlobalKey<NavigatorState> rootNavigatorKey;

  GoRouter createRouter() {
    final deeplinkRpcReceiver = sl.get<ArchethicDeeplinkRPCServer>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      extraCodec: const JsonCodec(),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: const Splash(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
        ..._authenticationRoutes(rootNavigatorKey),
        ..._introductionRoutes,
        GoRoute(
          path: ShowSendingAnimation.routerPage,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: AnimationLoadingPage(
              title: state.extra as String?,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
        GoRoute(
          path: SetPassword.routerPage,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: SetPassword(
              header: (state.extra! as Map<String, dynamic>)['header'] == null
                  ? null
                  : (state.extra! as Map<String, dynamic>)['header']! as String,
              description:
                  (state.extra! as Map<String, dynamic>)['description'] == null
                      ? null
                      : (state.extra! as Map<String, dynamic>)['description']!
                          as String,
              seed: (state.extra! as Map<String, dynamic>)['seed'] == null
                  ? null
                  : (state.extra! as Map<String, dynamic>)['seed']! as String,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
        GoRoute(
          path: SetYubikey.routerPage,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: SetYubikey(
              header: (state.extra! as Map<String, dynamic>)['header'] == null
                  ? null
                  : (state.extra! as Map<String, dynamic>)['header']! as String,
              description:
                  (state.extra! as Map<String, dynamic>)['description'] == null
                      ? null
                      : (state.extra! as Map<String, dynamic>)['description']!
                          as String,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
        AutoLockGuardRoute(
          routes: [
            RPCCommandReceiverRoute(
              routes: _authenticatedRoutes,
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        if (deeplinkRpcReceiver.canHandle(state.name)) {
          deeplinkRpcReceiver.handle(state.name);
        }
        return null;
      },
      errorBuilder: (context, state) => SheetSkeleton(
        appBar: AppBar(),
        menu: true,
        sheetContent: Text('Something went wrong: ${state.error}'),
      ),
    );
  }
}

class AutoLockGuardRoute extends ShellRoute {
  AutoLockGuardRoute({required super.routes})
      : super(
          pageBuilder: (context, state, child) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: AutoLockGuard(child: child),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
}

class RPCCommandReceiverRoute extends ShellRoute {
  RPCCommandReceiverRoute({required super.routes})
      : super(
          pageBuilder: (context, state, child) => CustomTransitionPage<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            key: state.pageKey,
            child: RPCCommandReceiver(child: child),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
}
