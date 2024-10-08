import 'dart:convert';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/farm_apr.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aewallet/ui/views/receive/receive_modal.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/action_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenDetailMenu extends ConsumerWidget {
  const TokenDetailMenu({
    super.key,
    required this.aeToken,
  });

  final aedappfm.AEToken aeToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          AccountProviders.accounts,
        )
        .valueOrNull
        ?.selectedAccount;
    final preferences = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final apr = ref.watch(FarmAPRProviders.farmAPR);
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;

    if (accountSelected == null) return const SizedBox();

    final localizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: constraints.maxWidth * 0.33,
                  child: accountSelected.balance!
                              .isNativeTokenValuePositive() &&
                          connectivityStatusProvider ==
                              ConnectivityStatus.isConnected
                      ? ActionButton(
                          key: const Key('sendButton'),
                          text: localizations.send,
                          icon: Symbols.call_made,
                          onTap: () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            await context.push(
                              TransferSheet.routerPage,
                              extra: {
                                'transferType': aeToken.isUCO
                                    ? TransferType.uco.name
                                    : TransferType.token.name,
                                'recipient': const TransferRecipient.address(
                                  address: Address(address: ''),
                                ).toJson(),
                                'aeToken': aeToken.toJson(),
                              },
                            );
                          },
                        )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 200))
                          .scale(duration: const Duration(milliseconds: 200))
                      : ActionButton(
                          text: localizations.send,
                          icon: Symbols.call_made,
                          enabled: false,
                        )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 200))
                          .scale(duration: const Duration(milliseconds: 200)),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.33,
                  child: ActionButton(
                    key: const Key('receivebutton'),
                    text: localizations.receive,
                    icon: Symbols.call_received,
                    onTap: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );

                      await showBarModalBottomSheet(
                        context: context,
                        backgroundColor: aedappfm.AppThemeBase.sheetBackground
                            .withOpacity(0.2),
                        builder: (BuildContext context) {
                          return const FractionallySizedBox(
                            heightFactor: 0.75,
                            child: ReceiveModal(),
                          );
                        },
                      );
                    },
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .scale(duration: const Duration(milliseconds: 250)),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.33,
                  child: aeToken.isUCO == false
                      ? connectivityStatusProvider ==
                              ConnectivityStatus.isConnected
                          ? ActionButton(
                              text: localizations.explorer,
                              icon: Symbols.manage_search,
                              onTap: () async {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );
                                await launchUrl(
                                  Uri.parse(
                                    '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${aeToken.address}',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            )
                              .animate()
                              .fade(
                                duration: const Duration(milliseconds: 300),
                              )
                              .scale(
                                duration: const Duration(milliseconds: 300),
                              )
                          : ActionButton(
                              text: localizations.explorer,
                              icon: Symbols.manage_search,
                              enabled: false,
                            )
                              .animate()
                              .fade(
                                duration: const Duration(milliseconds: 300),
                              )
                              .scale(
                                duration: const Duration(milliseconds: 300),
                              )
                      : connectivityStatusProvider ==
                              ConnectivityStatus.isConnected
                          ? ActionButton(
                              text:
                                  '${localizations.tokenDetailMenuEarn.replaceFirst('%1', apr)}\nUCO',
                              icon: aedappfm.Iconsax.wallet_add,
                              enabled: pool != null && farmLock != null,
                              onTap: () async {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );

                                final poolJson = jsonEncode(pool!.toJson());
                                final poolEncoded =
                                    Uri.encodeComponent(poolJson);
                                final farmLockJson =
                                    jsonEncode(farmLock!.toJson());
                                final farmLockEncoded =
                                    Uri.encodeComponent(farmLockJson);
                                await context.push(
                                  Uri(
                                    path: FarmLockDepositSheet.routerPage,
                                    queryParameters: {
                                      'pool': poolEncoded,
                                      'farmLock': farmLockEncoded,
                                    },
                                  ).toString(),
                                );
                              },
                            )
                              .animate()
                              .fade(
                                duration: const Duration(milliseconds: 300),
                              )
                              .scale(
                                duration: const Duration(milliseconds: 300),
                              )
                          : ActionButton(
                              text:
                                  '${localizations.tokenDetailMenuEarn.replaceFirst('%1', apr)}\nAPR',
                              icon: aedappfm.Iconsax.wallet_add,
                              enabled: false,
                            )
                              .animate()
                              .fade(
                                duration: const Duration(milliseconds: 300),
                              )
                              .scale(
                                duration: const Duration(milliseconds: 300),
                              ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
