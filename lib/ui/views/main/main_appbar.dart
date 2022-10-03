/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:ui';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/configure_category_list.dart';
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
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            actions: [
              if (StateContainer.of(context).bottomBarCurrentPage == 2) IconButton(
                      icon: const FaIcon(FontAwesomeIcons.gear),
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              StateContainer.of(context).activeVibrations,
                            );
                        Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: const ConfigureCategoryList(),
                        );
                      },
                    ) else StateContainer.of(context).showBalance
                      ? IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eye),
                          onPressed: () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
                            StateContainer.of(context).showBalance = false;

                            final preferences =
                                await Preferences.getInstance();
                            await preferences.setShowBalances(false);
                            StateContainer.of(context).updateState();
                          },
                        )
                      : IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eyeLowVision),
                          onPressed: () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
                            StateContainer.of(context).showBalance = true;

                            final preferences =
                                await Preferences.getInstance();
                            await preferences.setShowBalances(true);
                            StateContainer.of(context).updateState();
                          },
                        ),
              if (!kIsWeb &&
                  (Platform.isIOS == true ||
                      Platform.isAndroid == true ||
                      Platform.isMacOS == true))
                StateContainer.of(context).activeNotifications
                    ? IconButton(
                        icon: const Icon(Icons.notifications_active_outlined),
                        onPressed: () async {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                StateContainer.of(context).activeVibrations,
                              );
                          StateContainer.of(context).activeNotifications =
                              false;
                          if (StateContainer.of(context)
                                  .timerCheckTransactionInputs !=
                              null) {
                            StateContainer.of(context)
                                .timerCheckTransactionInputs!
                                .cancel();
                          }
                          final preferences =
                              await Preferences.getInstance();
                          await preferences.setActiveNotifications(false);
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.notifications_off_outlined),
                        onPressed: () async {
                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                StateContainer.of(context).activeVibrations,
                              );
                          StateContainer.of(context).activeNotifications = true;

                          if (StateContainer.of(context)
                                  .timerCheckTransactionInputs !=
                              null) {
                            StateContainer.of(context)
                                .timerCheckTransactionInputs!
                                .cancel();
                          }
                          StateContainer.of(context).checkTransactionInputs(
                            AppLocalization.of(context)!
                                .transactionInputNotification,
                          );
                          final preferences =
                              await Preferences.getInstance();
                          await preferences.setActiveNotifications(true);
                        },
                      )
            ],
            title: StateContainer.of(context).bottomBarCurrentPage == 0
                ? InkWell(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(
                          text: StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .address!
                              .toUpperCase(),
                        ),
                      );
                      UIUtil.showSnackbar(
                        AppLocalization.of(context)!.addressCopied,
                        context,
                        StateContainer.of(context).curTheme.text!,
                        StateContainer.of(context).curTheme.snackBarShadow!,
                      );
                    },
                    child: AutoSizeText(
                      AppLocalization.of(context)!.keychainHeader,
                      style:
                          AppStyles.textStyleSize24W700EquinoxPrimary(context),
                    ),
                  )
                : StateContainer.of(context).bottomBarCurrentPage == 1
                    ? FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .name!,
                          style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context,
                          ),
                        ),
                      )
                    : AutoSizeText(
                        'NFT',
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
                      ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme:
                IconThemeData(color: StateContainer.of(context).curTheme.text),
          ),
        ),
      ),
    );
  }
}
