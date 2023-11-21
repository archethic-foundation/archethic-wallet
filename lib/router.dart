import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/discussion_details_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_discussion_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/update_discussion_page.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_list_per_category.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_command_receiver.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoutesPath {
  GoRouter createRouter(WidgetRef ref) {
    final deeplinkRpcReceiver = sl.get<ArchethicDeeplinkRPCServer>();

    return GoRouter(
      initialLocation: '/',
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) =>
              _wrapWithRPCCommandReceiver(const Splash()),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AutoLockGuard(child: HomePage()),
          ),
        ),
        GoRoute(
          path: '/intro_welcome',
          builder: (context, state) => const IntroWelcome(),
        ),
        GoRoute(
          path: '/intro_welcome_get_first_infos',
          builder: (context, state) => const IntroNewWalletGetFirstInfos(),
        ),
        GoRoute(
          path: '/intro_backup',
          builder: (context, state) {
            final args = state.extra! as String;
            return IntroBackupSeedPage(
              name: args,
            );
          },
        ),
        GoRoute(
          path: '/intro_backup_safety',
          builder: (context, state) {
            final args = state.extra! as String;
            return IntroNewWalletDisclaimer(
              name: args,
            );
          },
        ),
        GoRoute(
          path: '/intro_import',
          builder: (context, state) => const IntroImportSeedPage(),
        ),
        GoRoute(
          path: '/intro_backup_confirm',
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return IntroBackupConfirm(
              name: args['name'] == null ? null : args['name']! as String,
              seed: args['seed'] == null ? null : args['seed']! as String,
            );
          },
        ),
        GoRoute(
          path: '/security_menu_view',
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const SecurityMenuView(),
          ),
        ),
        GoRoute(
          path: '/customization_menu_view',
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const CustomizationMenuView(),
          ),
        ),
        GoRoute(
          path: '/about_menu_view',
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AboutMenuView(),
          ),
        ),
        GoRoute(
          path: '/lock_screen_transition',
          builder: (context, state) => _wrapWithRPCCommandReceiver(
            const AppLockScreen(),
          ),
        ),
        GoRoute(
          path: '/nft_list_per_category',
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            final currentNftCategoryIndex =
                args['currentNftCategoryIndex'] == null
                    ? 0
                    : int.tryParse(args['currentNftCategoryIndex']! as String);
            return _wrapWithRPCCommandReceiver(
              NFTListPerCategory(
                currentNftCategoryIndex: currentNftCategoryIndex,
              ),
            );
          },
        ),
        GoRoute(
          path: '/nft_creation',
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
          path: '/messenger_discussion/:discussionAddress',
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              MessengerDiscussionPage(
                discussionAddress: args['discussionAddress']! as String,
              ),
            );
          },
        ),
        GoRoute(
          path: '/discussion_details/:discussionAddress',
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return _wrapWithRPCCommandReceiver(
              DiscussionDetailsPage(
                discussionAddress: args['discussionAddress']! as String,
              ),
            );
          },
        ),
        GoRoute(
          path: '/update_discussion',
          builder: (context, state) {
            final args = state.extra as Discussion?;
            return _wrapWithRPCCommandReceiver(
              UpdateDiscussionPage(discussion: args!),
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
