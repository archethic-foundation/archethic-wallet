/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
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
    final contact = ref.watch(ContactProviders.getSelectedContact).valueOrNull;
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
            if (accountSelected.balance!.isNativeTokenValuePositive() &&
                connectivityStatusProvider == ConnectivityStatus.isConnected)
              ActionButton(
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
            else
              ActionButton(
                text: localizations.send,
                icon: Symbols.call_made,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 200)),
            if (contact != null)
              ActionButton(
                key: const Key('receivebutton'),
                text: localizations.receive,
                icon: Symbols.call_received,
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  unawaited(
                    context.push(
                      ContactDetail.routerPage,
                      extra: ContactDetailsRouteParams(
                        contactAddress: contact.genesisAddress!,
                      ).toJson(),
                    ),
                  );
                },
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250))
            else
              ActionButton(
                text: localizations.receive,
                icon: Symbols.call_received,
                enabled: false,
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 250))
                  .scale(duration: const Duration(milliseconds: 250)),
            if (aeToken.isUCO == false)
              if (connectivityStatusProvider == ConnectivityStatus.isConnected)
                ActionButton(
                  text: localizations.explorer,
                  icon: Symbols.manage_search,
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    UIUtil.showWebview(
                      context,
                      '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${aeToken.address}',
                      '',
                    );
                  },
                )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 300))
                    .scale(duration: const Duration(milliseconds: 300))
              else
                ActionButton(
                  text: localizations.explorer,
                  icon: Symbols.manage_search,
                  enabled: false,
                )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 300))
                    .scale(duration: const Duration(milliseconds: 300)),
            if (aeToken.isUCO)
              if (connectivityStatusProvider == ConnectivityStatus.isConnected)
                ActionButton(
                  text: localizations.tokenDetailMenuEarn,
                  icon: aedappfm.Iconsax.wallet_add,
                  onTap: () {
                    // TODO(Reddwarf03): handle Token detail view
                  },
                )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 300))
                    .scale(duration: const Duration(milliseconds: 300))
              else
                ActionButton(
                  text: localizations.tokenDetailMenuEarn,
                  icon: aedappfm.Iconsax.wallet_add,
                  enabled: false,
                )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 300))
                    .scale(duration: const Duration(milliseconds: 300)),
          ],
        ),
      ),
    );
  }
}
