/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:ui';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/configure_category_list.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);
    final bottomBarCurrentPage = StateContainer.of(context).bottomBarCurrentPage;

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            actions: [
              if (StateContainer.of(context).bottomBarCurrentPage == 2)
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.gear),
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const ConfigureCategoryList(),
                    );
                  },
                )
              else
                StateContainer.of(context).showBalance
                    ? const MainAppBarIconBalanceShowed()
                    : const MainAppBarIconBalanceNotShowed(),
              if (!kIsWeb && (Platform.isIOS == true || Platform.isAndroid == true || Platform.isMacOS == true))
                StateContainer.of(context).activeNotifications
                    ? const MainAppBarIconNotificationEnabled()
                    : const MainAppBarIconNotificationDisabled()
            ],
            title: bottomBarCurrentPage == 0
                ? InkWell(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(
                          text: StateContainer.of(context).appWallet!.appKeychain!.address!.toUpperCase(),
                        ),
                      );
                      UIUtil.showSnackbar(
                        localizations.addressCopied,
                        context,
                        ref,
                        theme.text!,
                        theme.snackBarShadow!,
                      );
                    },
                    child: AutoSizeText(
                      localizations.keychainHeader,
                      style: theme.textStyleSize24W700EquinoxPrimary,
                    ),
                  )
                : bottomBarCurrentPage == 1
                    ? FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.name!,
                          style: theme.textStyleSize24W700EquinoxPrimary,
                        ),
                      )
                    : AutoSizeText(
                        'NFT',
                        style: theme.textStyleSize24W700EquinoxPrimary,
                      ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: theme.text),
          ),
        ),
      ),
    );
  }
}

class MainAppBarIconBalanceShowed extends ConsumerWidget {
  const MainAppBarIconBalanceShowed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(UiIcons.eye),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
        StateContainer.of(context).showBalance = false;

        final preferences = await Preferences.getInstance();
        await preferences.setShowBalances(false);
        StateContainer.of(context).updateState();
      },
    );
  }
}

class MainAppBarIconBalanceNotShowed extends StatelessWidget {
  const MainAppBarIconBalanceNotShowed({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(UiIcons.eye_hidden),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
        StateContainer.of(context).showBalance = true;

        final preferences = await Preferences.getInstance();
        await preferences.setShowBalances(true);
        StateContainer.of(context).updateState();
      },
    );
  }
}

class MainAppBarIconNotificationEnabled extends StatelessWidget {
  const MainAppBarIconNotificationEnabled({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(UiIcons.notification_enabled),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
        StateContainer.of(context).activeNotifications = false;
        if (StateContainer.of(context).timerCheckTransactionInputs != null) {
          StateContainer.of(context).timerCheckTransactionInputs!.cancel();
        }
        final preferences = await Preferences.getInstance();
        await preferences.setActiveNotifications(false);
      },
    );
  }
}

class MainAppBarIconNotificationDisabled extends StatelessWidget {
  const MainAppBarIconNotificationDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(UiIcons.notification_disabled),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
            );
        StateContainer.of(context).activeNotifications = true;

        if (StateContainer.of(context).timerCheckTransactionInputs != null) {
          StateContainer.of(context).timerCheckTransactionInputs!.cancel();
        }
        StateContainer.of(context).checkTransactionInputs(
          AppLocalization.of(context)!.transactionInputNotification,
        );
        final preferences = await Preferences.getInstance();
        await preferences.setActiveNotifications(true);
      },
    );
  }
}
