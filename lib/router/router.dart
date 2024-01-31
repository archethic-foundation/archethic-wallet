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
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
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
        GoRoute(path: '/', builder: (context, state) => const Splash()),
        ..._authenticationRoutes(rootNavigatorKey),
        ..._introductionRoutes,
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
          path: SetPassword.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, dynamic>;
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
            final args = state.extra! as Map<String, dynamic>;
            return SetYubikey(
              header: args['header'] == null ? null : args['header']! as String,
              description: args['description'] == null
                  ? null
                  : args['description']! as String,
            );
          },
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
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Something went wrong: ${state.error}'),
        ),
      ),
    );
  }
}

class AutoLockGuardRoute extends ShellRoute {
  AutoLockGuardRoute({required super.routes})
      : super(
          builder: (context, state, child) => AutoLockGuard(child: child),
        );
}

class RPCCommandReceiverRoute extends ShellRoute {
  RPCCommandReceiverRoute({required super.routes})
      : super(
          builder: (context, state, child) => RPCCommandReceiver(
            child: child,
          ),
        );
}
