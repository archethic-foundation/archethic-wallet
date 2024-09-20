import 'dart:convert';

import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/router/dialog_page.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/views/add_account/layouts/add_account_sheet.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_confirm_sheet.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/authenticate/biometrics_screen.dart';
import 'package:aewallet/ui/views/authenticate/logging_out.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/authenticate/privacy_mask.dart';
import 'package:aewallet/ui/views/authenticate/set_biometrics_screen.dart';
import 'package:aewallet/ui/views/authenticate/set_password_screen.dart';
import 'package:aewallet/ui/views/authenticate/set_yubikey_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/add_address.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_aeweb_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_http_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/import_tab/nft_creation_process_import_tab_ipfs_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/views/notifications/layouts/tasks_notification_widget.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_command_receiver.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/connectivity_warning.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/token_detail_sheet.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/add_token_sheet.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.authenticated.dart';
part 'router.authentication.dart';
part 'router.introduction.dart';
part 'router.aeswap.dart';

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
        ShellRoute(
          builder: (context, state, child) => AuthFactory(
            child: TasksNotificationWidget(
              child: child,
            ),
          ),
          routes: [
            GoRoute(
              path: Splash.routerPage,
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
            ..._authenticationRoutes,
            ..._introductionRoutes,
            ..._aeSwapRoutes,
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
              path: SetBiometricsScreen.routerPage,
              pageBuilder: (context, state) {
                final extra = state.extra! as Map<String, dynamic>;
                return NoTransitionPage<Uint8List>(
                  child: SetBiometricsScreen(
                    challenge: extra['challenge'] as Uint8List,
                  ),
                );
              },
            ),
            GoRoute(
              path: SetPassword.routerPage,
              pageBuilder: (context, state) {
                final extra = state.extra! as Map<String, dynamic>;
                return NoTransitionPage<Uint8List>(
                  key: state.pageKey,
                  child: SetPassword(
                    header: extra['header'] as String?,
                    description: extra['description'] as String?,
                    challenge: extra['challenge'] as Uint8List,
                  ),
                );
              },
            ),
            GoRoute(
              path: SetYubikey.routerPage,
              pageBuilder: (context, state) {
                final extra = state.extra! as Map<String, dynamic>;
                return NoTransitionPage<void>(
                  key: state.pageKey,
                  child: SetYubikey(
                    challenge: extra['challenge'] as Uint8List,
                  ),
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
        ),
      ],
      redirect: (context, state) async {
        if (deeplinkRpcReceiver.canHandle(state.matchedLocation)) {
          await deeplinkRpcReceiver.handle(state.matchedLocation);
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
          pageBuilder: (context, state, child) {
            return NoTransitionPage<void>(
              key: state.pageKey,
              child: AutoLockGuard(child: PrivacyMaskGuard(child: child)),
            );
          },
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

extension UriExtensions on Map<String, String> {
  T? getDecodedParameter<T>(String key, T Function(String) fromJson) {
    final encoded = this[key];
    if (encoded != null) {
      final json = Uri.decodeComponent(encoded);
      return fromJson(json);
    }
    return null;
  }
}
