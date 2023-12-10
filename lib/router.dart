import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
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
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
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
              pinScreenBackgroundColor: args['pinScreenBackgroundColor'] == null
                  ? null
                  : args['pinScreenBackgroundColor']! as Color?,
            );
          },
        ),
        GoRoute(
          path: IntroConfigureSecurity.routerPage,
          builder: (context, state) {
            final args = state.extra! as Map<String, Object?>;
            return IntroConfigureSecurity(
              accessModes: args['accessModes'] == null
                  ? null
                  : args['accessModes']! as List<PickerItem>?,
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
          path: UpdateDiscussionPage.routerPage,
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
