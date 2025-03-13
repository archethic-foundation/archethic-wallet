import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/views/buy/layouts/buy_sheet.dart';
import 'package:aewallet/ui/views/receive/receive_modal.dart';
import 'package:aewallet/ui/views/sheets/bridge_sheet.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/action_button.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MenuWidgetWallet extends ConsumerWidget {
  const MenuWidgetWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ActionButton(
              key: const Key('sendUCObutton'),
              text: localizations.send,
              icon: Symbols.call_made,
              enabled:
                  connectivityStatusProvider == ConnectivityStatus.isConnected,
              onTap: () async {
                await context.push(
                  TransferSheet.routerPage,
                  extra: {
                    'recipient': const TransferRecipient.address(
                      address: Address(address: ''),
                    ).toJson(),
                  },
                );
              },
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 200))
                .scale(duration: const Duration(milliseconds: 200)),
            ActionButton(
              key: const Key('receiveUCObutton'),
              text: localizations.receive,
              icon: Symbols.call_received,
              onTap: () async {
                await CupertinoScaffold.showCupertinoModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return FractionallySizedBox(
                      heightFactor: 1,
                      child: Scaffold(
                        backgroundColor: aedappfm.AppThemeBase.sheetBackground
                            .withValues(alpha: 0.2),
                        body: const ReceiveModal(),
                      ),
                    );
                  },
                );
              },
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 250))
                .scale(duration: const Duration(milliseconds: 250)),
            ActionButton(
              text: localizations.aeBridgeHeader,
              icon: aedappfm.Iconsax.recovery_convert,
              enabled:
                  connectivityStatusProvider == ConnectivityStatus.isConnected,
              onTap: () async {
                await context.push(BridgeSheet.routerPage);
              },
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 300))
                .scale(duration: const Duration(milliseconds: 300)),
            ActionButton(
              text: localizations.buy,
              icon: Symbols.add,
              onTap: () async {
                await context.push(BuySheet.routerPage);
              },
              enabled:
                  connectivityStatusProvider == ConnectivityStatus.isConnected,
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 350))
                .scale(duration: const Duration(milliseconds: 350)),
          ],
        ),
      ),
    );
  }
}
