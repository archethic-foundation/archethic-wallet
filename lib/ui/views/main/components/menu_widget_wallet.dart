/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class MenuWidgetWallet extends ConsumerWidget {
  const MenuWidgetWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;
    final preferences = ref.watch(SettingsProviders.settings);
    final contact = ref.watch(ContactProviders.getSelectedContact).valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    if (accountSelected == null) return const SizedBox();

    return StatefulBuilder(
      builder: (context, setState) {
        final localizations = AppLocalizations.of(context)!;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (accountSelected.balance!.isNativeTokenValuePositive() &&
                    connectivityStatusProvider ==
                        ConnectivityStatus.isConnected)
                  _ActionButton(
                    key: const Key('sendUCObutton'),
                    text: localizations.send,
                    icon: UiIcons.send,
                    onTap: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      await const TransferSheet(
                        transferType: TransferType.uco,
                        recipient: TransferRecipient.address(
                          address: Address(address: ''),
                        ),
                      ).show(
                        context: context,
                        ref: ref,
                      );
                    },
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 200))
                      .scale(duration: const Duration(milliseconds: 200))
                else
                  _ActionButton(
                    text: localizations.send,
                    icon: UiIcons.send,
                    enabled: false,
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 200))
                      .scale(duration: const Duration(milliseconds: 200)),
                if (contact != null)
                  _ActionButton(
                    key: const Key('receiveUCObutton'),
                    text: localizations.receive,
                    icon: UiIcons.receive,
                    onTap: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );

                      return Sheets.showAppHeightNineSheet(
                        context: context,
                        ref: ref,
                        widget: ContactDetail(
                          contact: contact,
                        ),
                      );
                    },
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .scale(duration: const Duration(milliseconds: 250))
                else
                  _ActionButton(
                    text: localizations.receive,
                    icon: UiIcons.receive,
                    enabled: false,
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .scale(duration: const Duration(milliseconds: 250)),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isConnected)
                  _ActionButton(
                    text: localizations.buy,
                    icon: UiIcons.buy,
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Sheets.showAppHeightNineSheet(
                        context: context,
                        ref: ref,
                        widget: const BuySheet(),
                      );
                    },
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 300))
                      .scale(duration: const Duration(milliseconds: 300))
                else
                  _ActionButton(
                    text: localizations.buy,
                    icon: UiIcons.buy,
                    enabled: false,
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 300))
                      .scale(duration: const Duration(milliseconds: 300)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    this.onTap,
    required this.text,
    required this.icon,
    this.enabled = true,
    super.key,
  });

  final VoidCallback? onTap;
  final String text;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              child: Column(
                children: <Widget>[
                  ShaderMask(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        icon,
                        color: enabled
                            ? Colors.white
                            : theme.text!.withOpacity(0.3),
                        size: 38,
                      ),
                    ),
                    shaderCallback: (Rect bounds) {
                      const rect = Rect.fromLTRB(0, 0, 40, 40);
                      return theme.gradient!.createShader(rect);
                    },
                  ),
                  const SizedBox(height: 5),
                  if (enabled)
                    Text(
                      text,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                    )
                  else
                    Text(
                      text,
                      style: theme.textStyleSize14W600EquinoxPrimaryDisabled,
                    ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                ShaderMask(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      icon,
                      color:
                          enabled ? Colors.white : theme.text!.withOpacity(0.3),
                      size: 38,
                    ),
                  ),
                  shaderCallback: (Rect bounds) {
                    const rect = Rect.fromLTRB(0, 0, 40, 40);
                    return theme.gradient!.createShader(rect);
                  },
                ),
                const SizedBox(height: 5),
                if (enabled)
                  Text(
                    text,
                    style: theme.textStyleSize14W600EquinoxPrimary,
                  )
                else
                  Text(
                    text,
                    style: theme.textStyleSize14W600EquinoxPrimaryDisabled,
                  ),
              ],
            ),
    );
  }
}
